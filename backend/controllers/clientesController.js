const clienteService = require('../services/clienteService');

exports.obtenerClientes = async (req, res) => {
    try {
        const results = await clienteService.getAllClientsDetailed();
        res.json(results);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

exports.crearCliente = async (req, res) => {
    try {
        const result = await clienteService.createClient(req.body);
        res.json(result);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

exports.actualizarEstado = async (req, res) => {
    const { id } = req.params;
    const { id_estado_nuevo } = req.body;
    try {
        const result = await clienteService.updateClientStatus(id, id_estado_nuevo);
        res.json(result);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
};

exports.obtenerHistorialCliente = async (req, res) => {
    const { id } = req.params;
    try {
        const results = await clienteService.getClientHistory(id);
        res.json(results);
    } catch (err) {
        console.error("Error al obtener historial:", err);
        res.status(500).json({ error: err.message });
    }
};