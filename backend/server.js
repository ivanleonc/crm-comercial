const express = require('express');
const cors = require('cors');
require('dotenv').config();

const db = require('./config/db');
const clientesRoutes = require('./routes/clientesRoutes');
const authRoutes = require('./routes/authRoutes');

const app = express();
app.use(cors());
app.use(express.json());

// Usar las rutas modularizadas
app.use('/api/clientes', clientesRoutes);
app.use('/api/auth', authRoutes); // Aquí agrupamos login y register
app.use('/api', authRoutes); // Para mantener compatibilidad con /api/usuarios si se usa directamente

const PORT = process.env.PORT || 3000;

// Middleware de manejo de errores global (To be implemented)
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).send({ error: 'Algo salió mal!' });
});

app.listen(PORT, () => console.log(`🚀 Servidor CRM corriendo en http://localhost:${PORT}`));