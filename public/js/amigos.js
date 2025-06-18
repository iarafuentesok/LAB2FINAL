// Funciones para gestionar solicitudes y lista de amigos
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
  // Sin usuario autenticado no se puede continuar
  if (!usuario) {
    window.location.href = 'login.html';
    return;
  }

  const resultadosBusqueda = document.getElementById('resultadosBusqueda');
  const solicitudesRecibidas = document.getElementById('solicitudesRecibidas');
  const listaAmigos = document.getElementById('listaAmigos');
  const imagenesAmigos = document.getElementById('imagenesAmigos');
  // Lista las solicitudes de amistad pendientes
  async function cargarSolicitudes() {
    try {
      const res = await fetch(`/api/amistad/pendientes/${usuario.id}`);
      const datos = await res.json();
      solicitudesRecibidas.innerHTML = '';
      datos.forEach((s) => {
        const li = document.createElement('li');
        li.innerHTML = `${s.remitente} <button data-id="${s.id}" class="aceptar">Aceptar</button> <button data-id="${s.id}" class="rechazar">Rechazar</button>`;
        solicitudesRecibidas.appendChild(li);
      });
    } catch (err) {
      console.error('Error al cargar solicitudes', err);
    }
  }
  // Carga amigos actuales y muestra algunas de sus imágenes públicas
  async function cargarAmigos() {
    try {
      const res = await fetch(`/api/amistad/amigos/${usuario.id}`);
      const amigos = await res.json();
      listaAmigos.innerHTML = '';
      imagenesAmigos.innerHTML = '';
      for (const amigo of amigos) {
        const li = document.createElement('li');
        li.innerHTML = `<a href="perfil.html?usuario_id=${amigo.id}">${amigo.nombre}</a> <button class="eliminar-amigo btn danger" data-id="${amigo.id}">Eliminar</button>`;
        listaAmigos.appendChild(li);

        const resImg = await fetch(`/api/imagenes/usuario/${amigo.id}`);
        const imagenes = await resImg.json();
        imagenes
          .filter((img) => img.visibilidad === 'publica')
          .forEach((img) => {
            const imgEl = document.createElement('img');
            imgEl.src = img.url_archivo;
            imgEl.alt = img.descripcion || '';
            imagenesAmigos.appendChild(imgEl);
          });
      }
    } catch (err) {
      console.error('Error al cargar amigos', err);
    }
  }

  // Acciones para aceptar o rechazar una solicitud
  solicitudesRecibidas.addEventListener('click', async (e) => {
    if (e.target.tagName !== 'BUTTON') return;
    const id = e.target.dataset.id;
    const acepta = e.target.classList.contains('aceptar');
    await fetch(`/api/amistad/responder/${id}`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ acepta }),
    });
    cargarSolicitudes();
  });

  // Búsqueda de nuevos usuarios a añadir
  document.getElementById('buscarBtn').addEventListener('click', async () => {
    const texto = document.getElementById('busqueda').value.trim();
    if (!texto) return;
    try {
      const res = await fetch(`/api/usuarios/buscar?q=${encodeURIComponent(texto)}`);
      const usuarios = res.ok ? await res.json() : [];
      resultadosBusqueda.innerHTML = '';
      if (!usuarios.length) {
        resultadosBusqueda.innerHTML = '<li>Usuario no encontrado</li>';
        return;
      }
      usuarios.forEach((u) => {
        const li = document.createElement('li');
        li.dataset.dest = u.id;

        let contenido = `<a href="perfil.html?usuario_id=${u.id}">${u.nombre}</a> `;

        if (u.id === usuario.id) {
          contenido += '<span>(Tú)</span>';
        } else if (u.siguiendo) {
          contenido += '<span>Ya son amigos</span>';
        } else if (u.solicitud_pendiente) {
          contenido += '<span>Solicitud enviada</span>';
        } else {
          contenido += '<button id="solicitarBtn">Enviar solicitud</button>';
        }

        li.innerHTML = contenido;
        resultadosBusqueda.appendChild(li);
      });
    } catch (err) {
      console.error('Error en búsqueda', err);
    }
  });

  // Enviar solicitud al hacer clic en el resultado
  resultadosBusqueda.addEventListener('click', async (e) => {
    if (e.target.id !== 'solicitarBtn') return;
    const dest = e.target.parentElement.dataset.dest;
    await fetch('/api/amistad/solicitar', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ id_remitente: usuario.id, id_destinatario: dest }),
    });
    e.target.disabled = true;
    e.target.textContent = 'Enviada';
  });

  // Permite eliminar un amigo existente
  listaAmigos.addEventListener('click', async (e) => {
    if (!e.target.classList.contains('eliminar-amigo')) return;
    const id = e.target.dataset.id;
    await fetch(`/api/amistad/${usuario.id}/${id}`, { method: 'DELETE' });
    cargarAmigos();
  });

  // Carga inicial de datos
  cargarSolicitudes();
  cargarAmigos();
});
