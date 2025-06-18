// Manejo de álbumes e imágenes del usuario autenticado
async function obtenerUsuario() {
  try {
    const res = await fetch('/api/usuarios/me');
    if (!res.ok) return null;
    return await res.json();
  } catch {
    return null;
  }
}

document.addEventListener('DOMContentLoaded', async () => {
  const usuario = await obtenerUsuario();
  // Si no hay sesión activa, redirigimos al formulario de login
  if (!usuario) {
    window.location.href = 'login.html';
    return;
  }

  document.getElementById('infoUsuarioAlbumes').textContent = `Álbumes de ${usuario.nombre}`;

  const crearAlbumForm = document.getElementById('crearAlbumForm');
  const listaAlbumes = document.getElementById('listaAlbumes');
  const mensajeAlbum = document.getElementById('mensajeAlbum');
  const mensajeImagen = document.getElementById('mensajeImagen');

  let albumes = [];
  let amigos = [];

  // Obtiene la lista de amigos para permitir imágenes compartidas
  async function cargarAmigos() {
    try {
      const res = await fetch(`/api/amistad/amigos/${usuario.id}`);
      amigos = res.ok ? await res.json() : [];
    } catch (err) {
      console.error('Error al cargar amigos', err);
      amigos = [];
    }
  }

  // Consulta los álbumes en el backend y luego los dibuja en pantalla
  async function cargarAlbumes() {
    try {
      const res = await fetch(`/api/albumes/usuario/${usuario.id}`);
      albumes = await res.json();
      renderAlbumes();
    } catch (err) {
      console.error('Error al cargar álbumes', err);
    }
  }

  // Dibuja en el DOM cada álbum y sus imágenes
  function renderAlbumes() {
    listaAlbumes.innerHTML = '';
    const opcionesAmigos = amigos
      .map((a) => `<option value="${a.id}">${a.nombre}</option>`)
      .join('');

    // Crear tarjeta visual para cada álbum
    albumes.forEach((album) => {
      const div = document.createElement('div');
      div.classList.add('album-card');
      if (album.id_amigo) div.classList.add('album-compartido');

      const portada =
        album.imagenes && album.imagenes.length
          ? album.imagenes[0].url_archivo
          : '/assets/albumvacio-default.png';

      const imagenesHTML = (album.imagenes || [])
        .map(
          (img) =>
            `<img src="${img.url_archivo}" data-id="${img.id}" data-owner="${img.id_usuario}" data-vis="${img.visibilidad}" data-dest='${JSON.stringify(
              img.destinatarios || []
            )}' alt="${img.descripcion || ''}">`
        )
        .join('');

      let inner = `
       <img class="album-portada" src="${portada}" alt="${album.titulo}">
        <h3>${album.titulo}</h3>
         <div class="album-contenido">
         `;
      if (!album.id_amigo) {
        inner += `
          <button class="editar-album" data-id="${album.id}">Editar título</button>
           <button class="eliminar-album" data-id="${album.id}">Eliminar álbum</button>
          <div class="imagenes-album">${imagenesHTML}</div>
          <form class="formAgregarImagen" data-album-id="${album.id}">
            <input type="file" name="imagen" accept="image/*" required><br>
            <input type="text" name="descripcion" placeholder="Descripción"><br>
            <select name="visibilidad">
              <option value="publica">Pública</option>
              <option value="privada">Solo amigos</option>
              <option value="compartida">Seleccionar amigos</option>
            </select><br>
            <select name="destinatarios" multiple style="display:none">
              ${opcionesAmigos}
            </select><br>
            <button type="submit">Subir imagen</button>
         </form>`;
      } else {
        inner += `<div class="imagenes-album">${imagenesHTML}</div>`;
      }
      inner += `</div>`;
      div.innerHTML = inner;
      listaAlbumes.appendChild(div);

      const contenido = div.querySelector('.album-contenido');
      div.addEventListener('click', (e) => {
        if (e.target.closest('.album-contenido')) return;
        if (contenido)
          contenido.style.display =
            contenido.style.display === 'none' || contenido.style.display === '' ? 'block' : 'none';
      });
    });

    document.querySelectorAll('select[name="visibilidad"]').forEach((sel) => {
      sel.addEventListener('change', () => {
        const destSel = sel.parentElement.querySelector('select[name="destinatarios"]');
        if (destSel) destSel.style.display = sel.value === 'compartida' ? 'block' : 'none';
      });
    });

    document.querySelectorAll('.formAgregarImagen').forEach((form) => {
      form.addEventListener('submit', async (e) => {
        e.preventDefault();
        const albumId = form.dataset.albumId;
        const file = form.imagen.files[0];
        if (!file) return;
        const formData = new FormData();
        formData.append('imagen', file);
        formData.append('descripcion', form.descripcion.value);
        formData.append('visibilidad', form.visibilidad.value);
        formData.append('id_usuario', usuario.id);
        if (form.visibilidad.value === 'compartida') {
          const sel = form.querySelector('select[name="destinatarios"]');
          const seleccionados = Array.from(sel.selectedOptions).map((o) => o.value);
          seleccionados.forEach((id) => formData.append('destinatarios', id));
        }
        const resp = await fetch(`/api/albumes/imagen/${albumId}`, {
          method: 'POST',
          body: formData,
        });
        if (resp.ok) {
          mensajeImagen.textContent = '✅ Imagen subida correctamente.';
          await cargarAlbumes();
        } else {
          mensajeImagen.textContent = '❌ Error al subir la imagen.';
        }
        setTimeout(() => (mensajeImagen.textContent = ''), 3000);
      });
    });
    let imagenActual = null;

    async function cargarComentarios(idImagen) {
      try {
        const res = await fetch(`/api/comentarios/imagen/${idImagen}`);
        const comentarios = await res.json();
        const lista = document.getElementById('listaComentarios');
        lista.innerHTML = '';
        comentarios.forEach((c) => {
          const li = document.createElement('li');
          li.textContent = `${c.nombre}: ${c.comentario}`;
          lista.appendChild(li);
        });
      } catch (e) {
        console.error('Error comentarios', e);
      }
    }

    document.getElementById('formComentario').addEventListener('submit', async (e) => {
      e.preventDefault();
      if (!imagenActual) return;
      const texto = document.getElementById('comentario').value.trim();
      if (!texto) return;
      const resp = await fetch(`/api/comentarios/imagen/${imagenActual}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ id_usuario: usuario.id, comentario: texto }),
      });
      if (resp.ok) {
        document.getElementById('comentario').value = '';
        await cargarComentarios(imagenActual);
      }
    });

    const lightbox = document.getElementById('lightbox');
    const cerrarBtn = document.getElementById('cerrarLightbox');
    const btnEliminar = document.getElementById('btnEliminarImagen');
    const btnCambiarVis = document.getElementById('btnCambiarVisibilidad');
    const selectVis = document.getElementById('selectVisibilidad');
    const selectDest = document.getElementById('selectDestinatarios');

    function cerrarLightbox() {
      lightbox.style.display = 'none';
      selectDest.style.display = 'none';
    }

    selectVis.addEventListener('change', () => {
      selectDest.style.display = selectVis.value === 'compartida' ? 'block' : 'none';
    });

    cerrarBtn.addEventListener('click', cerrarLightbox);
    lightbox.addEventListener('click', (e) => {
      if (e.target === lightbox) cerrarLightbox();
    });
    document.addEventListener('keydown', (e) => {
      if (e.key === 'Escape') cerrarLightbox();
    });

    btnEliminar.addEventListener('click', async () => {
      if (!imagenActual) return;
      await fetch(`/api/imagenes/${imagenActual}`, { method: 'DELETE' });
      cerrarLightbox();
      await cargarAlbumes();
    });

    btnCambiarVis.addEventListener('click', async () => {
      if (!imagenActual) return;
      const destinatarios = Array.from(selectDest.selectedOptions).map((o) => o.value);
      await fetch(`/api/imagenes/visibilidad/${imagenActual}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ visibilidad: selectVis.value, destinatarios }),
      });
      cerrarLightbox();
      await cargarAlbumes();
    });

    document.querySelectorAll('.imagenes-album img').forEach((img) => {
      img.addEventListener('click', async () => {
        imagenActual = img.dataset.id;
        document.getElementById('lightboxImagen').src = img.src;
        document.getElementById('lightboxTitulo').textContent = img.alt || '';
        document.getElementById('lightboxDescripcion').textContent = '';
        const esPropia = String(img.dataset.owner) === String(usuario.id);
        selectVis.value = img.dataset.vis;
        const destData = JSON.parse(img.dataset.dest || '[]');
        selectDest.innerHTML = amigos
          .map((a) => `<option value="${a.id}">${a.nombre}</option>`)
          .join('');
        destData.forEach((id) => {
          const opt = selectDest.querySelector(`option[value="${id}"]`);
          if (opt) opt.selected = true;
        });
        btnEliminar.style.display = esPropia ? 'inline-block' : 'none';
        btnCambiarVis.style.display = esPropia ? 'inline-block' : 'none';
        selectVis.style.display = esPropia ? 'inline-block' : 'none';
        selectDest.style.display = esPropia && selectVis.value === 'compartida' ? 'block' : 'none';
        document.getElementById('lightbox').style.display = 'flex';
        await cargarComentarios(imagenActual);
      });
    });

    document.querySelectorAll('.editar-album').forEach((btn) => {
      btn.addEventListener('click', async () => {
        const nuevo = prompt('Nuevo título del álbum:');
        if (!nuevo) return;
        const id = btn.dataset.id;
        await fetch(`/api/albumes/editar/${id}`, {
          method: 'PUT',
          headers: { 'Content-Type': 'application/json' },
          body: JSON.stringify({ titulo: nuevo }),
        });
        await cargarAlbumes();
      });
    });

    document.querySelectorAll('.eliminar-album').forEach((btn) => {
      btn.addEventListener('click', async () => {
        if (!confirm('¿Eliminar álbum completo?')) return;
        const id = btn.dataset.id;
        await fetch(`/api/albumes/eliminar/${id}`, { method: 'DELETE' });
        await cargarAlbumes();
      });
    });
  }

  // Envío del formulario para crear un nuevo álbum
  crearAlbumForm.addEventListener('submit', async (e) => {
    e.preventDefault();
    const titulo = document.getElementById('tituloAlbum').value.trim();
    if (!titulo) return;
    const res = await fetch('/api/albumes/crear', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ titulo, id_usuario: usuario.id }),
    });
    if (res.ok) {
      mensajeAlbum.textContent = '✅ Álbum creado exitosamente.';
      await cargarAlbumes();
      crearAlbumForm.reset();
    } else {
      mensajeAlbum.textContent = '❌ Error al crear el álbum.';
    }
    setTimeout(() => (mensajeAlbum.textContent = ''), 3000);
  });

  // Cargar datos iniciales
  await cargarAmigos();
  await cargarAlbumes();
});
