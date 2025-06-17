import { db } from '../db.js';

// Obtener álbumes con imágenes
export const obtenerAlbumesPorUsuario = async (req, res) => {
  try {
    const id_usuario = req.params.id;

    let consulta = 'SELECT id, titulo, fecha_creacion, id_amigo FROM albumes WHERE id_usuario = ?';
    const params = [id_usuario];

    if (String(req.session.usuarioId) !== String(id_usuario)) {
      consulta += ' AND id_amigo IS NULL';
    }

    const [albumes] = await db.query(consulta, params);

    const albumesConImagenes = await Promise.all(
      albumes.map(async (album) => {
        let imagenes;
        if (album.id_amigo) {
          const [rows] = await db.query(
            `SELECT i.id, i.id_album, i.id_usuario, i.url_archivo, i.descripcion, i.visibilidad, i.fecha_subida
             FROM imagenes i
             JOIN imagenes_compartidas ic ON ic.id_imagen = i.id
             WHERE ic.id_usuario = ? AND i.id_usuario = ?`,
            [id_usuario, album.id_amigo]
          );
          imagenes = rows;
        } else {
          const [rows] = await db.query(
            'SELECT id, id_album, id_usuario, url_archivo, descripcion, visibilidad, fecha_subida FROM imagenes WHERE id_album = ?',
            [album.id]
          );
          imagenes = rows;
        }

        const withRecipients = await Promise.all(
          imagenes.map(async (img) => {
            const [rows] = await db.query(
              'SELECT id_usuario FROM imagenes_compartidas WHERE id_imagen = ?',
              [img.id]
            );
            const destinatarios = rows.map((r) => r.id_usuario);

            const [tagRows] = await db.query(
              `SELECT t.nombre FROM imagenes_tags it JOIN tags t ON it.id_tag = t.id WHERE it.id_imagen = ?`,
              [img.id]
            );
            const tags = tagRows.map((t) => t.nombre);

            return { ...img, destinatarios, tags };
          })
        );

        return { ...album, imagenes: withRecipients };
      })
    );

    res.json(albumesConImagenes);
  } catch (err) {
    console.error(err);
    res.status(500).json({ mensaje: 'Error al obtener los álbumes' });
  }
};

// Crear álbum
export const crearAlbum = async (req, res) => {
  try {
    const { titulo, id_usuario } = req.body;

    const [usuarios] = await db.query('SELECT id FROM usuarios WHERE id = ?', [id_usuario]);
    if (usuarios.length === 0) {
      return res.status(404).json({ mensaje: 'Usuario no encontrado' });
    }

    await db.query('INSERT INTO albumes (titulo, id_usuario) VALUES (?, ?)', [titulo, id_usuario]);
    res.status(201).json({ mensaje: 'Álbum creado correctamente' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ mensaje: 'Error al crear el álbum' });
  }
};

// Subir imagen a álbum
export const subirImagen = async (req, res) => {
  try {
    const { albumId } = req.params;
    const { descripcion, visibilidad, destinatarios = [], id_usuario, tags = [] } = req.body;

    // Validar y normalizar destinatariosList
    let destinatariosList = destinatarios;
    if (typeof destinatariosList === 'string') {
      try {
        destinatariosList = JSON.parse(destinatariosList);
      } catch {
        destinatariosList = destinatariosList
          .split(',')
          .map((d) => d.trim())
          .filter((d) => d);
      }
    }

    if (!Array.isArray(destinatariosList)) {
      destinatariosList = destinatariosList ? [destinatariosList] : [];
    }

    // Verificar que se haya subido un archivo
    const archivo = req.file;
    if (!archivo) {
      return res.status(400).json({ mensaje: 'No se recibió la imagen.' });
    }

    const url_archivo = `/uploads/${archivo.filename}`;

    const [result] = await db.query(
      `INSERT INTO imagenes (id_album, id_usuario, url_archivo, descripcion, visibilidad)
       VALUES (?, ?, ?, ?, ?)`,
      [albumId, id_usuario, url_archivo, descripcion || '', visibilidad]
    );

    // Procesar tags
    let tagList = tags;
    if (typeof tagList === 'string') {
      try {
        tagList = JSON.parse(tagList);
      } catch {
        tagList = tagList.split(',').map((t) => t.trim());
      }
    }

    if (Array.isArray(tagList) && tagList.length) {
      const tagIds = [];
      for (const nombre of tagList) {
        const [rows] = await db.query('SELECT id FROM tags WHERE nombre = ?', [nombre]);
        if (rows.length) tagIds.push(rows[0].id);
      }

      if (tagIds.length) {
        const values = tagIds.map((tid) => [result.insertId, tid]);
        await db.query('INSERT INTO imagenes_tags (id_imagen, id_tag) VALUES ?', [values]);
      }
    }

    // Compartir imagen si es compartida
    if (visibilidad === 'compartida' && Array.isArray(destinatariosList)) {
      const values = destinatariosList.map((uid) => [result.insertId, uid]);

      if (values.length === 1) {
        await db.query(
          'INSERT INTO imagenes_compartidas (id_imagen, id_usuario) VALUES (?, ?)',
          values[0]
        );
      } else if (values.length > 1) {
        await db.query('INSERT INTO imagenes_compartidas (id_imagen, id_usuario) VALUES ?', [
          values,
        ]);
      }
    }

    res.status(201).json({ mensaje: 'Imagen subida correctamente', url_archivo });
  } catch (err) {
    console.error(err);
    res.status(500).json({ mensaje: 'Error al subir imagen' });
  }
};

// Editar título del álbum
export const editarTituloAlbum = async (req, res) => {
  try {
    const id_album = req.params.id;
    const { titulo } = req.body;

    if (!titulo) {
      return res.status(400).json({ mensaje: 'Título requerido' });
    }

    const [result] = await db.query('UPDATE albumes SET titulo = ? WHERE id = ?', [
      titulo,
      id_album,
    ]);

    if (result.affectedRows === 0) {
      return res.status(404).json({ mensaje: 'Álbum no encontrado' });
    }

    res.json({ mensaje: 'Álbum actualizado correctamente' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ mensaje: 'Error al actualizar álbum' });
  }
};

// Eliminar álbum completo (imágenes incluidas por ON DELETE CASCADE)
export const eliminarAlbum = async (req, res) => {
  try {
    const id_album = req.params.id;
    const [result] = await db.query('DELETE FROM albumes WHERE id = ?', [id_album]);

    if (result.affectedRows === 0) {
      return res.status(404).json({ mensaje: 'Álbum no encontrado' });
    }

    res.json({ mensaje: 'Álbum eliminado correctamente' });
  } catch (err) {
    console.error(err);
    res.status(500).json({ mensaje: 'Error al eliminar álbum' });
  }
};
