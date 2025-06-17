// backend/server.js

import express from 'express';
import { createServer } from 'http';
import cors from 'cors';
import dotenv from 'dotenv';
import helmet from 'helmet';
import morgan from 'morgan';
import path from 'path';
import session from 'express-session';
import { fileURLToPath } from 'url';
import { initSocket } from './socket.js';
import { db } from './db.js';
import usuariosRoutes from './routes/usuarios.routes.js';
import imagenesRoutes from './routes/imagenes.routes.js';
import albumesRoutes from './routes/albumes.routes.js';
import comentariosRoutes from './routes/comentarios.routes.js';
import amistadRoutes from './routes/amistad.routes.js';
import notificacionesRoutes from './routes/notificaciones.routes.js';
import busquedaRoutes from './routes/busqueda.routes.js';
dotenv.config();

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const publicPath = path.join(__dirname, '../public');

const app = express();
const httpServer = createServer(app);
initSocket(httpServer);

// 🛡 Seguridad básica
app.use(helmet());

// 🌐 CORS
app.use(cors());

// 📝 Logging de peticiones HTTP
app.use(morgan('dev'));

// 📦 Parseo JSON en requests
app.use(express.json());

// 🗝 Gestión de sesiones básicas
app.use(
  session({
    secret: 'secret',
    resave: false,
    saveUninitialized: false,
    cookie: { httpOnly: true },
  })
);

// 🧩 Archivos estáticos (HTML, CSS, JS, imágenes)
app.use(express.static(publicPath));

// 🔗 Rutas de API REST
app.use('/api/usuarios', usuariosRoutes);
app.use('/api/imagenes', imagenesRoutes);
app.use('/api/albumes', albumesRoutes);
app.use('/api/comentarios', comentariosRoutes);
app.use('/api/amistad', amistadRoutes);
app.use('/api/notificaciones', notificacionesRoutes);
app.use('/api/busqueda', busquedaRoutes);

app.get('/ping', async (req, res) => {
  try {
    const [rows] = await db.query('SELECT NOW() AS hora');
    res.json({ ok: true, hora: rows[0].hora });
  } catch (error) {
    console.error('Error en /ping:', error);
    res.status(500).json({ ok: false, error: 'Error al conectar con la base de datos' });
  }
});
// 🔍 Ruta de prueba
app.get('/', (req, res) => {
  res.send('Servidor funcionando 🎉');
});

// ❗ Middleware de errores internos
app.use((err, req, res, next) => {
  console.error('💥 Error inesperado:', err.stack);
  res.status(500).json({ mensaje: 'Error interno del servidor' });
});

// ❌ Ruta no encontrada (404)
app.use((req, res) => {
  res.status(404).send('Archivo no encontrado: ' + req.originalUrl);
});

// 🚀 Iniciar servidor con soporte WebSocket
const PORT = process.env.PORT || 3000;
console.log('Archivos estáticos servidos desde:', publicPath);

if (process.env.NODE_ENV !== 'test') {
  httpServer.listen(PORT, () => {
    console.log(`Servidor corriendo en puerto ${PORT}`);
  });
}

export { app, httpServer };
