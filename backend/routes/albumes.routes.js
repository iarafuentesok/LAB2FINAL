// backend/routes/albumes.routes.js
import express from 'express';
import {
  obtenerAlbumesPorUsuario,
  crearAlbum,
  subirImagen,
  editarTituloAlbum,
  eliminarAlbum,
} from '../controllers/albumes.controller.js';
import { upload } from '../middlewares/upload.middleware.js';

const router = express.Router();

router.get('/usuario/:id', obtenerAlbumesPorUsuario);
router.post('/crear', crearAlbum);
router.post('/imagen/:albumId', upload.single('imagen'), subirImagen); // Nueva ruta
router.put('/editar/:id', editarTituloAlbum);
router.delete('/eliminar/:id', eliminarAlbum);

export default router;
