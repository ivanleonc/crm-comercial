import api from './axiosConfig';

export const clienteService = {
  async obtenerClientes() {
    const res = await api.get('/clientes');
    return res.data;
  },

  async obtenerHistorialCliente(idCliente) {
    const response = await api.get(`/clientes/${idCliente}/historial`);
    return response.data;
  },

  async crearCliente(cliente) {
    const res = await api.post('/clientes', cliente);
    return res.data;
  },

  async actualizarEstado(id, idEstadoNuevo) {
    const res = await api.put(`/clientes/${id}/estado`, { id_estado_nuevo: idEstadoNuevo });
    return res.data;
  }
};
