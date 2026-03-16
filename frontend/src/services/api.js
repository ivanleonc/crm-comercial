import axios from 'axios';
import { authService } from './authService';
import { clienteService } from './clienteService';

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
  ...authService,
  ...clienteService
};