import express from 'express';
import {
  obtenerImagenesPorUsuario,
  obtenerImagenesPublicas,
  obtenerImagenPorId,
  eliminarImagen,
  cambiarVisibilidadImagen,
} from '../controllers/imagenes.controller.js';

const router = express.Router();

router.get('/usuario/:id', obtenerImagenesPorUsuario);
router.get('/publicas', obtenerImagenesPublicas);
router.get('/:id', obtenerImagenPorId);
router.delete('/:id', eliminarImagen);
router.put('/visibilidad/:id', cambiarVisibilidadImagen);
export default router;
