// Maneja el inicio de sesión de usuarios
document.addEventListener('DOMContentLoaded', () => {
  const form = document.getElementById('loginForm');
  const errorDisplay = document.getElementById('loginError');

  // Envío de credenciales al backend
  form.addEventListener('submit', async (e) => {
    e.preventDefault();

    const email = form.email.value.trim();
    const password = form.password.value;

    try {
      const response = await fetch('/api/usuarios/login', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ email, password }),
      });

      const data = await response.json();

      if (!response.ok) {
        errorDisplay.textContent = '❌ ' + data.mensaje;
        return;
      }

      // Sesión iniciada correctamente
      window.location.href = 'perfil.html';
    } catch (error) {
      console.error('Error:', error);
      errorDisplay.textContent = '❌ Error al conectar con el servidor.';
    }
  });
});
