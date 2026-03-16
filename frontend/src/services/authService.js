import api from './axiosConfig';

export const authService = {
  async login(credenciales) {
    const res = await api.post('/auth/login', credenciales);
    return res.data;
  },

  async register(usuario) {
    const res = await api.post('/auth/register', usuario);
    return res.data;
  },

  async obtenerAsesores() {
    // Mantengo compatibilidad con ambas rutas si es necesario
    try {
        const res = await api.get('/auth/usuarios');
        return res.data;
    } catch (e) {
        const res = await api.get('/usuarios');
        return res.data;
    }
  }
};
