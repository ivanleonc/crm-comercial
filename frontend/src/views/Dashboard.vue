<template>
  <div v-if="notificacion" class="toast-notificacion">
    <i class="ti ti-check check-icon"></i>
    <span>{{ notificacion }}</span>
  </div>

  <Navbar :usuario="usuarioActual" @abrir-registro="mostrarModal = true" @abrir-reportes="mostrarModalReportes = true"
    @cerrar-sesion="cerrarSesion" />

  <div class="dashboard-wrapper">
    <Sidebar :vistaActiva="vistaActiva" @abrir-reportes="mostrarModalReportes = true" @cambiar-vista="v => vistaActiva = v" />

    <main class="dashboard-main">
      <ModalRegistro v-if="mostrarModal" @cerrar="mostrarModal = false" @guardado="clienteGuardadoExito" />

      <ModalReportes v-if="mostrarModalReportes" :clientes="listaClientes" @cerrar="mostrarModalReportes = false" />
      <ModalDetalles v-if="modalAbierto" :cliente="clienteSeleccionado" @cerrar="modalAbierto = false" />

      <KanbanBoard v-if="vistaActiva === 'tablero'" :clientes="listaClientes" @estado-actualizado="cargarDatos" @abrir-registro="mostrarModal = true" @ver-detalles="abrirDetalles" />
      
      <ProspectosList v-if="vistaActiva === 'prospectos'" :clientes="listaClientes" @abrir-registro="mostrarModal = true" @ver-detalles="abrirDetalles" />
    </main>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import api from '../services/api';
import { useRouter } from 'vue-router';
import Navbar from '../components/Navbar.vue';
import Sidebar from '../components/Sidebar.vue';
import ModalRegistro from '../components/ModalRegistro.vue';
import ModalReportes from '../components/ModalReportes.vue';
import KanbanBoard from '../components/KanbanBoard.vue';
import ProspectosList from '../components/ProspectosList.vue';
import ModalDetalles from '../components/ModalDetalles.vue';

const router = useRouter();
const listaClientes = ref([]);
const notificacion = ref('');
const mostrarModal = ref(false);
const mostrarModalReportes = ref(false);
const vistaActiva = ref('tablero'); // Control de vistas: 'tablero', 'prospectos'

// Estado del ModalDetalles (se abre desde Kanban o ProspectosList)
const modalAbierto = ref(false);
const clienteSeleccionado = ref(null);

const abrirDetalles = (cliente) => {
  clienteSeleccionado.value = cliente;
  modalAbierto.value = true;
};

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