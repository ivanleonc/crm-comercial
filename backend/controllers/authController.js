const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const db = require('../config/db');
require('dotenv').config();

// 1. REGISTRO DE USUARIO
exports.register = async (req, res) => {
  const { nombre, email, password, id_rol } = req.body;

  try {
    // Verificar si el email ya existe
    db.query('SELECT * FROM usuarios WHERE email = ?', [email], async (err, results) => {
      if (err) return res.status(500).json({ error: err.message });
      if (results.length > 0) return res.status(400).json({ error: 'El email ya está registrado' });

      // Encriptar la contraseña (Salt de 10 rondas)
      const salt = await bcrypt.genSalt(10);
      const hashedPassword = await bcrypt.hash(password, salt);

      // Guardar en la BD
      const sql = 'INSERT INTO usuarios (nombre, email, password, id_rol) VALUES (?, ?, ?, ?)';
      db.query(sql, [nombre, email, hashedPassword, id_rol || 2], (err, result) => { // Por defecto rol 2 (Asesor)
        if (err) return res.status(500).json({ error: err.message });
        res.status(201).json({ message: 'Usuario registrado exitosamente' });
      });
    });
  } catch (error) {
    res.status(500).json({ error: 'Error en el servidor' });
  }
};

// 2. LOGIN DE USUARIO
exports.login = (req, res) => {
  const { email, password } = req.body;

  // Buscar al usuario por email, incluyendo el nombre de su rol
  const sql = `
    SELECT u.*, r.nombre_rol 
    FROM usuarios u 
    JOIN roles r ON u.id_rol = r.id_rol 
    WHERE u.email = ?
  `;

  db.query(sql, [email], async (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    if (results.length === 0) return res.status(401).json({ error: 'Credenciales inválidas' });

    const usuario = results[0];

    // Comparar la contraseña ingresada con el Hash de la BD
    const passwordValida = await bcrypt.compare(password, usuario.password);
    if (!passwordValida) return res.status(401).json({ error: 'Credenciales inválidas' });

    // Generar el JWT
    const token = jwt.sign(
      { 
        id: usuario.id_usuario, 
        rol: usuario.nombre_rol,
        nombre: usuario.nombre
      }, 
      process.env.JWT_SECRET, 
      { expiresIn: '8h' } // El token expira en 8 horas
    );

    res.json({
      message: 'Login exitoso',
      token,
      usuario: { id: usuario.id_usuario, nombre: usuario.nombre, email: usuario.email, rol: usuario.nombre_rol }
    });
  });
};

// 3. OBTENER USUARIOS
exports.getUsers = (req, res) => {
  // Solo queremos usuarios que sean Asesores (rol 2) o Admin (rol 1) que puedan recibir prospectos
  const sql = 'SELECT id_usuario, nombre FROM usuarios WHERE id_rol IN (1, 2)';
  
  db.query(sql, (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(results);
  });
};
