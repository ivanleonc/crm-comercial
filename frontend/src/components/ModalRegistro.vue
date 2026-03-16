<template>
  <div class="modal-overlay" @click.self="$emit('cerrar')">
    <div class="modal-content modal-lg">
      <button class="cerrar-modal" @click="$emit('cerrar')" title="Cerrar (Esc)">
        <i class="ti ti-x"></i>
      </button>

      <div class="modal-header">
        <div class="header-icon">
          <i class="ti ti-user-plus header-icon-inner"></i>
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
            <i class="ti ti-chevron-down select-icon"></i>
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
            <i class="ti ti-chevron-down select-icon"></i>
          </div>
        </div>

        <div class="input-group full-width">
          <label>Producto de Interés</label>
          <div class="select-wrapper">
            <select v-model="nuevoCliente.id_tipo_producto" required>
              <option value="1">💻 Software ERP Empresarial</option>
              <option value="2">⚙️ Consultoría IT Especializada</option>
            </select>
            <i class="ti ti-chevron-down select-icon"></i>
          </div>
        </div>

        <div v-if="errorMsg" class="error-msg shake full-width">
          <i class="ti ti-alert-circle"></i>
          <span>{{ errorMsg }}</span>
        </div>

        <div class="modal-actions full-width">
          <button type="button" class="btn-secondary" @click="$emit('cerrar')" :disabled="cargando">Cancelar</button>
          
          <button type="submit" class="btn-primary" :disabled="cargando">
            <span v-if="!cargando">Guardar Prospecto</span>
            <span v-else class="loading-state">
              <i class="ti ti-loader-2 spinner"></i>
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
.header-icon-inner { font-size: 1.5rem; }
.modal-header h2 { margin: 0 0 4px 0; font-size: 1.25rem; color: var(--text-main); }
.modal-header p { margin: 0; font-size: 0.9rem; }

/* Grid del Formulario */
.form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
.full-width { grid-column: 1 / -1; }

.input-group label { display: block; margin-bottom: 6px; font-weight: 600; font-size: 0.85rem; color: var(--text-main); }

/* Ajustes para los Selects y su flecha personalizada */
.select-wrapper { position: relative; }
select { cursor: pointer; appearance: none; padding-right: 36px; }
.select-icon { position: absolute; right: 12px; top: 50%; transform: translateY(-50%); color: #64748b; pointer-events: none; font-size: 1.25rem; }

/* Botones de acción inferiores */
.modal-actions { display: flex; justify-content: flex-end; gap: 12px; margin-top: 10px; border-top: 1px solid var(--border-color); padding-top: 20px;}

.btn-secondary {
  background-color: white; color: var(--text-main); border: 1px solid var(--border-color);
  padding: 10px 20px; border-radius: var(--radius-md); font-weight: 600; font-size: 0.95rem;
  cursor: pointer; transition: all 0.2s ease;
}
.btn-secondary:hover { background-color: #f1f5f9; border-color: #cbd5e1; }

.loading-state { display: flex; align-items: center; gap: 8px; }
.spinner { animation: spin 1s linear infinite; font-size: 1.25rem; }
@keyframes spin { 100% { transform: rotate(360deg); } }

/* Deshabilitar interacciones mientras carga */
button:disabled { opacity: 0.7; cursor: not-allowed; transform: none; box-shadow: none; }
</style>