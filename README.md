# 🧶 Artesanos.com - Red Social de Creadores

Proyecto integrador final para la materia **Laboratorio 2**.  
Una red social donde artistas y artesanos pueden compartir sus obras, organizar álbumes, gestionar amistades y comentar imágenes en tiempo real.

---

## 🌐 Enlaces del Proyecto

🔗 **Sitio Web**: [https://lab2final-m22q.onrender.com](https://lab2final-m22q.onrender.com)  
🔗 **Repositorio en GitHub**: [https://github.com/iarafuentesok/LAB2FINAL](https://github.com/iarafuentesok/LAB2FINAL)  
🎥 **Video Explicativo**: [https://youtu.be/jAS77reXMjQ](https://youtu.be/jAS77reXMjQ)

---

## ✅ Funcionalidades obligatorias implementadas

- Registro y login de usuarios con autenticación JWT
- Búsqueda de usuarios
- Envío, aceptación y rechazo de solicitudes de amistad
- Creación de álbumes personalizados
- Subida de imágenes a álbumes
- Compartir imágenes con contactos seleccionados
- Comentarios en imágenes compartidas
- Notificaciones en tiempo real con WebSockets
- Base de datos relacional (MySQL)

---

## ✨ Funcionalidad extra implementada

- 🖼️ **Modo portafolio público**: permite a visitantes sin cuenta ver obras de usuarios con ese modo activado.

---

## 🛠️ Tecnologías utilizadas

### Frontend

- HTML5, CSS3 y JavaScript (vanilla)
- Fetch API para peticiones asincrónicas
- WebSockets (Socket.IO) para notificaciones en tiempo real

### Backend

- Node.js + Express
- Autenticación con JSON Web Tokens (JWT)
- MySQL (mediante `mysql2/promise`)
- Subida de imágenes con Multer
- Seguridad: Helmet, CORS y Express Rate Limit
- Gestión de sesiones con Express-Session
- Logging con Morgan
- WebSockets con Socket.IO

### Testing y desarrollo

- Mocha, Chai y Supertest (pruebas automatizadas)
- Nodemon para desarrollo en caliente
- Prettier para formateo de código
- Cross-env para configuración multiplataforma

### Hosting

- Backend + frontend: Render (servidos desde el mismo proyecto)
- Base de datos: AlwaysData (MySQL externa)

---

## 📂 Estructura del proyecto

El archivo `estructura.md` contiene un árbol completo de carpetas y archivos del proyecto.

---

## 🧪 Datos precargados

La aplicación incluye usuarios simulados, amistades activas, álbumes con imágenes públicas y privadas, portafolios visibles, y comentarios. Esto facilita la demostración sin necesidad de registrar nuevos usuarios manualmente.

---

## 👤 Autora

**Iara Nievas**  
Estudiante de la Tecnicatura Universitaria en Desarrollo de Software  
Universidad de La Punta

---

## 📌 Notas finales

El proyecto cumple con todos los requisitos funcionales para regularizar la materia.  
Se recomienda activar el sitio con antelación para evitar demoras por servidores en reposo durante la presentación.
