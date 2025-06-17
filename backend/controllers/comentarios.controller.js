import { db } from '../db.js';
import { getIO } from '../socket.js';

// Agregar comentario a una imagen
export const agregarComentario = async (req, res) => {
  try {
    const id_imagen = req.params.idImagen;
    const { id_usuario, comentario } = req.body;

    if (!comentario || !id_usuario) {
      return res.status(400).json({ mensaje: 'Datos incompletos' });
    }

    await db.query('INSERT INTO comentarios (id_imagen, id_usuario, comentario) VALUES (?, ?, ?)', [
      id_imagen,
      id_usuario,
      comentario,
    ]);

    // Obtener propietario de la imagen para notificar
    const [rows] = await db.query('SELECT id_usuario FROM imagenes WHERE id = ?', [id_imagen]);

    if (rows.length) {
      const autor = rows[0].id_usuario;
      if (autor !== id_usuario) {
        const [[{ nombre: comentarista }]] = await db.query(
          'SELECT nombre FROM usuarios WHERE id = ?',
          [id_usuario]
        );

        const extracto = comentario.length > 20 ? `${comentario.slice(0, 20)}...` : comentario;
        const mensaje = `${comentarista} comentó: ${extracto}`;
        const url = `/perfil.html?usuario_id=${autor}&img=${id_imagen}`;
        const [resNotif] = await db.query(
          "INSERT INTO notificaciones (id_usuario, tipo, mensaje, url) VALUES (?, 'comentario', ?, ?)",
          [autor, mensaje, url]
        );

        // Notificación en tiempo real
        getIO().to(String(autor)).emit('notificacion', {
          id: resNotif.insertId,
          tipo: 'comentario',
          mensaje,
          url,
          leido: 0,
        });
      }
    }

    res.status(201).json({ mensaje: 'Comentario agregado' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ mensaje: 'Error al agregar comentario' });
  }
};

// Obtener todos los comentarios de una imagen
export const obtenerComentariosPorImagen = async (req, res) => {
  try {
    const id_imagen = req.params.idImagen;
    const [rows] = await db.query(
      `SELECT c.id, c.id_usuario, u.nombre, c.comentario, c.fecha_comentario
       FROM comentarios c
       JOIN usuarios u ON c.id_usuario = u.id
       WHERE c.id_imagen = ?
       ORDER BY c.fecha_comentario ASC`,
      [id_imagen]
    );
    res.json(rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({ mensaje: 'Error al obtener comentarios' });
  }
};
