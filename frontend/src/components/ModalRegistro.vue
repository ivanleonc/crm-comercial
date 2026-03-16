<template>
  <div class="modal-overlay" @click.self="$emit('cerrar')">
    <div class="modal-content modal-lg">
      <button class="cerrar-modal" @click="$emit('cerrar')" title="Cerrar (Esc)">
        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <line x1="18" y1="6" x2="6" y2="18"></line>
          <line x1="6" y1="6" x2="18" y2="18"></line>
        </svg>
      </button>

      <div class="modal-header">
        <div class="header-icon">
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M16 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
            <circle cx="8.5" cy="7" r="4"></circle>
            <line x1="20" y1="8" x2="20" y2="14"></line>
            <line x1="23" y1="11" x2="17" y2="11"></line>
          </svg>
        </div>
        <div>
          <h2>Registrar Prospecto</h2>
          <p class="text-muted">Añade un nuevo cliente al pipeline comercial.</p>
        </div>
      </div>

      <form @submit.prevent="guardarCliente" class="form-grid">
        <div class="input-group">
          <label>Nombres</label>
          <input v-model="nuevoCliente.nombres" type="text" placeholder="Ej. Juan Carlos" required />
        </div>

        <div class="input-group">
          <label>Apellidos</label>
          <input v-model="nuevoCliente.apellidos" type="text" placeholder="Ej. Pérez Gómez" required />
        </div>

        <div class="input-group full-width">
          <label>Empresa</label>
          <input v-model="nuevoCliente.empresa" type="text" placeholder="Nombre de la empresa u organización" required />
        </div>

        <div class="input-group">
          <label>Asesor Asignado</label>
          <div class="select-wrapper">
            <select v-model="nuevoCliente.id_asesor_inicial" required>
              <option value="" disabled>Seleccione un asesor...</option>
              <option v-for="asesor in asesoresDisponibles" :key="asesor.id_usuario" :value="asesor.id_usuario">
                {{ asesor.nombre }}
              </option>
            </select>
            <svg class="select-icon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
          </div>
        </div>

        <div class="input-group">
          <label>Etapa Inicial</label>
          <div class="select-wrapper">
            <select v-model="nuevoCliente.id_estado_actual" required>
              <option value="1">🎯 Prospecto (Inicial)</option>
              <option value="2">📞 Contacto Inicial</option>
              <option value="3">📄 Propuesta Enviada</option>
            </select>
            <svg class="select-icon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
          </div>
        </div>

        <div class="input-group full-width">
          <label>Producto de Interés</label>
          <div class="select-wrapper">
            <select v-model="nuevoCliente.id_tipo_producto" required>
              <option value="1">💻 Software ERP Empresarial</option>
              <option value="2">⚙️ Consultoría IT Especializada</option>
            </select>
            <svg class="select-icon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>
          </div>
        </div>

        <div v-if="errorMsg" class="error-msg shake full-width">
          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="8" x2="12" y2="12"></line><line x1="12" y1="16" x2="12.01" y2="16"></line></svg>
          <span>{{ errorMsg }}</span>
        </div>

        <div class="modal-actions full-width">
          <button type="button" class="btn-secondary" @click="$emit('cerrar')" :disabled="cargando">Cancelar</button>
          
          <button type="submit" class="btn-primary" :disabled="cargando">
            <span v-if="!cargando">Guardar Prospecto</span>
            <span v-else class="loading-state">
              <svg class="spinner" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="12" y1="2" x2="12" y2="6"></line><line x1="12" y1="18" x2="12" y2="22"></line><line x1="4.93" y1="4.93" x2="7.76" y2="7.76"></line><line x1="16.24" y1="16.24" x2="19.07" y2="19.07"></line><line x1="2" y1="12" x2="6" y2="12"></line><line x1="18" y1="12" x2="22" y2="12"></line><line x1="4.93" y1="19.07" x2="7.76" y2="16.24"></line><line x1="16.24" y1="7.76" x2="19.07" y2="4.93"></line></svg>
              Guardando...
            </span>
          </button>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import api from '../services/api';

const emit = defineEmits(['cerrar', 'guardado']);

const nuevoCliente = ref({
  nombres: '',
  apellidos: '',
  empresa: '',
  id_asesor_inicial: '',
  id_estado_actual: 1,
  id_tipo_producto: 1
});

const errorMsg = ref('');
const asesoresDisponibles = ref([]);
const cargando = ref(false);

const cargarAsesores = async () => {
  try {
    asesoresDisponibles.value = await api.obtenerAsesores();
  } catch (error) {
    console.error("Error al cargar asesores:", error);
    errorMsg.value = "No se pudo cargar la lista de asesores.";
  }
};

const guardarCliente = async () => {
  errorMsg.value = ''; 
  cargando.value = true;
  
  try {
    await api.crearCliente(nuevoCliente.value);
    emit('guardado'); 
  } catch (error) {
    console.error("Error al guardar:", error);
    errorMsg.value = error.response?.data?.error || 'Error de conexión con el servidor';
  } finally {
    cargando.value = false;
  }
};

onMounted(cargarAsesores);
</script>

<style scoped>
/* Control de ancho del modal para formularios de dos columnas */
.modal-lg { max-width: 650px; }

/* Encabezado del Modal */
.modal-header { display: flex; align-items: center; gap: 16px; margin-bottom: 24px; border-bottom: 1px solid var(--border-color); padding-bottom: 16px;}
.header-icon {
  display: flex; justify-content: center; align-items: center; width: 48px; height: 48px;
  background-color: #e0e7ff; color: var(--primary); border-radius: 12px;
}
.modal-header h2 { margin: 0 0 4px 0; font-size: 1.25rem; color: var(--text-main); }
.modal-header p { margin: 0; font-size: 0.9rem; }

/* Grid del Formulario */
.form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
.full-width { grid-column: 1 / -1; }

.input-group label { display: block; margin-bottom: 6px; font-weight: 600; font-size: 0.85rem; color: var(--text-main); }

/* Ajustes para los Selects y su flecha personalizada */
.select-wrapper { position: relative; }
select { cursor: pointer; appearance: none; padding-right: 36px; }
.select-icon { position: absolute; right: 12px; top: 50%; transform: translateY(-50%); color: #64748b; pointer-events: none; }

/* Botones de acción inferiores */
.modal-actions { display: flex; justify-content: flex-end; gap: 12px; margin-top: 10px; border-top: 1px solid var(--border-color); padding-top: 20px;}

.btn-secondary {
  background-color: white; color: var(--text-main); border: 1px solid var(--border-color);
  padding: 10px 20px; border-radius: var(--radius-md); font-weight: 600; font-size: 0.95rem;
  cursor: pointer; transition: all 0.2s ease;
}
.btn-secondary:hover { background-color: #f1f5f9; border-color: #cbd5e1; }

.loading-state { display: flex; align-items: center; gap: 8px; }
.spinner { animation: spin 1s linear infinite; }
@keyframes spin { 100% { transform: rotate(360deg); } }

/* Deshabilitar interacciones mientras carga */
button:disabled { opacity: 0.7; cursor: not-allowed; transform: none; box-shadow: none; }
</style>