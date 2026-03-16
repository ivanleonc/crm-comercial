const db = require('../config/db');

exports.obtenerClientes = (req, res) => {
    db.query('SELECT * FROM v_reporte_detallado_clientes', (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
};

exports.crearCliente = (req, res) => {
    const { nombres, apellidos, empresa, id_asesor_inicial, id_estado_actual, id_tipo_producto } = req.body;
    const sql = `INSERT INTO clientes_oportunidades (nombres, apellidos, empresa, id_asesor_inicial, id_estado_actual, id_tipo_producto) VALUES (?, ?, ?, ?, ?, ?)`;
    const valores = [nombres, apellidos, empresa, id_asesor_inicial, id_estado_actual, id_tipo_producto || 1];

    db.query(sql, valores, (err, result) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json({ message: "Cliente creado con éxito", id: result.insertId });
    });
};

exports.actualizarEstado = (req, res) => {
    const { id } = req.params;
    const { id_estado_nuevo } = req.body;
    const sql = 'UPDATE clientes_oportunidades SET id_estado_actual = ? WHERE id_cliente = ?';
    
    db.query(sql, [id_estado_nuevo, id], (err, result) => {
        if (err) return res.status(500).json(err);
        res.json({ message: "Estado actualizado correctamente" });
    });
};