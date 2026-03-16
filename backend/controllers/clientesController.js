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
exports.obtenerHistorialCliente = (req, res) => {
    const { id } = req.params;

    const sql = `
        -- 1. Evento de Creación del Prospecto
        SELECT 
            'creacion' AS tipo,
            'Sistema' AS autor,
            fecha_creacion AS fecha,
            'Prospecto creado' AS titulo,
            '' AS descripcion,
            '' AS detalle_extra
        FROM clientes_oportunidades 
        WHERE id_cliente = ?

        UNION ALL

        -- 2. Historial de Cambios de Fase
        SELECT 
            'cambio_fase' AS tipo,
            IFNULL(emp.nombre_completo, 'Sistema') AS autor,
            h.fecha_cambio AS fecha,
            -- ¡AQUÍ ESTABA EL ERROR! Cambiamos nombre_estado por nombre
            CONCAT('Cambio de fase de [', IFNULL(ea.nombre, 'Nuevo'), '] a [', IFNULL(en.nombre, 'Desconocido'), ']') AS titulo,
            IFNULL(h.justificacion, '') AS descripcion,
            '' AS detalle_extra
        FROM historial_estados_cliente h
        LEFT JOIN empleados emp ON h.id_asesor_cambio = emp.id_empleado
        LEFT JOIN estados_embudo ea ON h.id_estado_anterior = ea.id_estado_embudo
        LEFT JOIN estados_embudo en ON h.id_estado_nuevo = en.id_estado_embudo
        WHERE h.id_cliente = ?

        UNION ALL

        -- 3. Actividades (Anotaciones y Tareas)
        SELECT 
            LOWER(a.tipo_actividad) AS tipo,
            IFNULL(emp.nombre_completo, 'Asesor') AS autor,
            IFNULL(a.fecha_recordatorio, CURRENT_TIMESTAMP) AS fecha, 
            CONCAT(a.tipo_actividad, ' registrada') AS titulo,
            IFNULL(a.descripcion, '') AS descripcion,
            IF(a.fecha_recordatorio IS NOT NULL, DATE_FORMAT(a.fecha_recordatorio, '%Y-%m-%d %H:%i'), '') AS detalle_extra
        FROM actividades_simples a
        LEFT JOIN empleados emp ON a.id_asesor = emp.id_empleado
        WHERE a.id_cliente = ?

        UNION ALL

        -- 4. Citas Programadas
        SELECT 
            'cita' AS tipo,
            IFNULL(emp.nombre_completo, 'Asesor') AS autor,
            c.fecha_hora_cita AS fecha,
            'Cita programada' AS titulo,
            IFNULL(c.notas_resultado, '') AS descripcion,
            DATE_FORMAT(c.fecha_hora_cita, '%Y-%m-%d %h:%i %p') AS detalle_extra
        FROM citas c
        LEFT JOIN empleados emp ON c.id_asesor = emp.id_empleado
        WHERE c.id_cliente = ?

        ORDER BY fecha DESC;
    `;

    db.query(sql, [id, id, id, id], (err, results) => {
        if (err) {
            console.error("Error al obtener historial:", err);
            return res.status(500).json({ error: err.message });
        }
        res.json(results);
    });
};