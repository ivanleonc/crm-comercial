const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');

// Rutas de autenticación
router.post('/register', authController.register);
router.post('/login', authController.login);
router.get('/usuarios', authController.getUsers);

module.exports = router;
