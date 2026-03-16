import axios from 'axios';

// 1. Configuramos la instancia base de Axios
const api = axios.create({
  baseURL: 'http://localhost:3000/api'
});

// 2. INTERCEPTOR DE PETICIONES (El Guardia de Salida)
// Antes de que cualquier petición salga hacia el backend, le pegamos el Token
api.interceptors.request.use((config) => {
  const token = localStorage.getItem('token');
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
}, (error) => {
  return Promise.reject(error);
});

// 3. Exportamos los métodos limpios
export default {
  // --- RUTAS DE CLIENTES ---
  async obtenerClientes() {
    const res = await api.get('/clientes');
    return res.data; // Axios guarda la respuesta del server dentro de ".data"
  },

  // OBTENER LISTA DE ASESORES
  async obtenerAsesores() {
    const res = await api.get('/usuarios');
    return res.data;
  },
  
  async crearCliente(cliente) {
    const res = await api.post('/clientes', cliente);
    return res.data;
  },
  
  async actualizarEstado(id, idEstadoNuevo) {
    const res = await api.put(`/clientes/${id}/estado`, { id_estado_nuevo: idEstadoNuevo });
    return res.data;
  },

  // --- RUTAS DE AUTENTICACIÓN ---
  async login(credenciales) {
    const res = await api.post('/auth/login', credenciales);
    return res.data; 
  },

  async register(usuario) {
    const res = await api.post('/auth/register', usuario);
    return res.data;
  }
};