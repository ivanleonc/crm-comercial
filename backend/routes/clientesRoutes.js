const express = require('express');
const router = express.Router();
const clientesController = require('../controllers/clientesController');
// Importamos los middlewares
const { verificarToken, verificarRol } = require('../middlewares/authMiddleware');

// 🔒 Aplicamos verificarToken a TODAS las rutas de este archivo
router.use(verificarToken);

// Rutas protegidas
router.get('/', clientesController.obtenerClientes);

// 🔒 Solo un Admin puede crear nuevos clientes (Ejemplo de uso de roles)
router.post('/', verificarRol(['Admin']), clientesController.crearCliente);

// Admin y Asesor pueden mover las tarjetas en el Kanban
router.put('/:id/estado', verificarRol(['Admin', 'Asesor']), clientesController.actualizarEstado);

module.exports = router;
