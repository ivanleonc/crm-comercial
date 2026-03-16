<template>
  <div v-if="notificacion" class="toast-notificacion">
    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
      <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
      <polyline points="22 4 12 14.01 9 11.01"></polyline>
    </svg>
    <span>{{ notificacion }}</span>
  </div>

  <Navbar 
    :usuario="usuarioActual"
    @abrir-registro="mostrarModal = true" 
    @abrir-reportes="mostrarModalReportes = true" 
    @cerrar-sesion="cerrarSesion"
  />

  <div class="contenedor-principal">
    <ModalRegistro 
      v-if="mostrarModal" 
      @cerrar="mostrarModal = false" 
      @guardado="clienteGuardadoExito" 
    />

    <ModalReportes 
      v-if="mostrarModalReportes" 
      :clientes="listaClientes" 
      @cerrar="mostrarModalReportes = false" 
    />

    <KanbanBoard 
      :clientes="listaClientes" 
      @estado-actualizado="cargarDatos" 
    />
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import api from '../services/api';
import { useRouter } from 'vue-router';
import Navbar from '../components/Navbar.vue';
import ModalRegistro from '../components/ModalRegistro.vue';
import ModalReportes from '../components/ModalReportes.vue';
import KanbanBoard from '../components/KanbanBoard.vue';

const router = useRouter();
const listaClientes = ref([]);
const notificacion = ref('');
const mostrarModal = ref(false); 
const mostrarModalReportes = ref(false); 

// 1. Obtenemos el usuario logueado desde el localStorage
const usuarioActual = ref(JSON.parse(localStorage.getItem('usuario')) || { nombre: 'Usuario', rol: 'Desconocido' });

// 2. Función para cerrar sesión
const cerrarSesion = () => {
  localStorage.removeItem('token');
  localStorage.removeItem('usuario');
  router.push('/login');
};

const cargarDatos = async () => {
  try {
    listaClientes.value = await api.obtenerClientes();
  } catch (err) {
    console.error("Error cargando datos:", err);
    if (err.response && (err.response.status === 401 || err.response.status === 403)) {
      cerrarSesion(); // Reutilizamos la función si el token expira
    } else {
      listaClientes.value = [];
    }
  }
};

const clienteGuardadoExito = async () => {
  mostrarModal.value = false;
  notificacion.value = "¡Prospecto guardado con éxito!";
  setTimeout(() => notificacion.value = '', 3000);
  await cargarDatos();
};

onMounted(cargarDatos);
</script>