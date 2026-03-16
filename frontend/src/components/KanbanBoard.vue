<template>
  <section id="kanban" class="kanban-wrapper">
    <div class="section-header">
      <div class="header-left">
        <div class="header-icon">
          <i class="ti ti-layout-kanban header-icon-inner"></i>
        </div>
        <div>
          <h2>Pipeline de Ventas</h2>
          <p class="text-muted">Arrastra los prospectos para avanzar en su proceso comercial.</p>
        </div>
      </div>

      <button v-if="!esLector" class="btn-nuevo-prospecto" @click="$emit('abrir-registro')">
        <i class="ti ti-plus"></i>
        Nuevo Prospecto
      </button>
    </div>

    <div class="kanban-container custom-scrollbar">

      <div v-for="estado in estados" :key="estado.id" class="kanban-column">

        <div class="column-header">
          <div class="column-title">
            <span :class="['status-dot', 'dot-' + estado.id]"></span>
            <h3>{{ estado.nombre }}</h3>
          </div>
          <span class="count-badge">{{ listasPorEstado[estado.id]?.length || 0 }}</span>
        </div>

        <draggable v-model="listasPorEstado[estado.id]" group="clientes" item-key="id_cliente" class="kanban-cards"
          ghost-class="ghost-card" drag-class="dragging-card" :animation="200" :disabled="esLector"
          @change="onCambio($event, estado.id)">
          <template #item="{ element: cliente }">
            <div class="kanban-card" :class="{ 'is-readonly': esLector }" @click="$emit('ver-detalles', cliente)">
              <h4 class="card-title">{{ cliente.nombre_cliente }}</h4>

              <div class="card-company">
                <i class="ti ti-building"></i>
                <span>{{ cliente.empresa }}</span>
              </div>

              <div class="card-footer">
                <div class="asesor-tag">
                  <i class="ti ti-user"></i>
                  <span>{{ cliente.asesor_asignado }}</span>
                </div>
              </div>
            </div>
          </template>
        </draggable>

        <div v-if="!listasPorEstado[estado.id] || listasPorEstado[estado.id].length === 0" class="empty-zone">
          <i class="ti ti-inbox empty-zone-icon"></i>
          <span>Soltar tarjeta aquí</span>
        </div>

      </div>
    </div>

  </section>
</template>

<script setup>
import { ref, watch, computed } from 'vue';
import draggable from 'vuedraggable';
import api from '../services/api';

const props = defineProps({ clientes: Array });
const emit = defineEmits(['estado-actualizado', 'abrir-registro', 'ver-detalles']);

// Obtenemos el usuario del LocalStorage para saber su rol
const usuarioActual = ref(JSON.parse(localStorage.getItem('usuario')) || { rol: 'Lector' });

// Propiedad computada que nos dice si es Lector (true o false)
const esLector = computed(() => usuarioActual.value.rol === 'Lector');

const estados = ref([
  { id: 1, nombre: 'Prospecto' },
  { id: 2, nombre: 'Contacto Inicial' },
  { id: 3, nombre: 'Propuesta Enviada' },
  { id: 4, nombre: 'Negociación' },
  { id: 5, nombre: 'Cerrado Ganado' }
]);

const listasPorEstado = ref({});

watch(() => props.clientes, (nuevosClientes) => {
  estados.value.forEach(estado => {
    listasPorEstado.value[estado.id] = nuevosClientes.filter(c => c.estado_actual === estado.nombre);
  });
}, { immediate: true, deep: true });

const onCambio = async (evento, idEstadoNuevo) => {
  if (evento.added) {
    const clienteId = evento.added.element.id_cliente;
    try {
      const exito = await api.actualizarEstado(clienteId, idEstadoNuevo);
      if (exito) {
        emit('estado-actualizado');
      }
    } catch (error) {
      console.error("Error al actualizar el estado:", error);
      alert(error.response?.data?.error || "Error al mover la tarjeta.");
      emit('estado-actualizado');
    }
  }
};
</script>

<style scoped>
/* --- CONTENEDOR PRINCIPAL --- */
.kanban-wrapper {
  padding-top: 10px;
}

/* Encabezado Principal Ajustado */
.section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 32px;
  padding: 0 4px;
}

.header-left {
  display: flex;
  align-items: center;
  gap: 16px;
}

.header-icon {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 48px;
  height: 48px;
  background-color: #e0e7ff;
  color: var(--primary);
  border-radius: 12px;
}
.header-icon-inner {
  font-size: 1.5rem;
}

.section-header h2 {
  margin: 0 0 4px 0;
  font-size: 1.5rem;
  color: var(--text-main);
  font-weight: 700;
  letter-spacing: -0.025em;
}

.section-header p {
  margin: 0;
  font-size: 0.95rem;
}

/* Botón Nuevo Prospecto */
.btn-nuevo-prospecto {
  display: flex;
  align-items: center;
  gap: 8px;
  background-color: var(--primary);
  color: white;
  border: none;
  padding: 12px 20px;
  border-radius: var(--radius-md);
  font-weight: 600;
  font-size: 0.95rem;
  cursor: pointer;
  transition: all 0.2s ease;
  box-shadow: 0 4px 6px -1px rgba(79, 70, 229, 0.2);
}

.btn-nuevo-prospecto:hover {
  background-color: #4338ca;
  transform: translateY(-1px);
  box-shadow: 0 6px 12px -2px rgba(79, 70, 229, 0.3);
}
.btn-nuevo-prospecto i { font-size: 1.25rem; }

/* --- ESTRUCTURA DEL TABLERO --- */
.kanban-container {
  display: flex;
  gap: 24px;
  overflow-x: auto;
  padding-bottom: 20px;
  align-items: flex-start;
  scroll-behavior: smooth;
}

/* Custom Scrollbar */
.custom-scrollbar::-webkit-scrollbar {
  height: 10px;
}

.custom-scrollbar::-webkit-scrollbar-track {
  background: #f1f5f9;
  border-radius: 8px;
}

.custom-scrollbar::-webkit-scrollbar-thumb {
  background: #cbd5e1;
  border-radius: 8px;
}

/* --- COLUMNAS --- */
.kanban-column {
  background: #f8fafc;
  border-radius: var(--radius-lg);
  min-width: 320px;
  max-width: 320px;
  padding: 16px;
  min-height: 65vh;
  display: flex;
  flex-direction: column;
  border: 1px solid var(--border-color);
}

.column-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.column-title {
  display: flex;
  align-items: center;
  gap: 8px;
}

.column-title h3 {
  font-size: 0.9rem;
  color: var(--text-main);
  margin: 0;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

/* Puntos de color por estado */
.status-dot {
  width: 10px;
  height: 10px;
  border-radius: 50%;
  display: block;
}

.dot-1 {
  background-color: #94a3b8;
  box-shadow: 0 0 0 3px #f1f5f9;
}

.dot-2 {
  background-color: #3b82f6;
  box-shadow: 0 0 0 3px #dbeafe;
}

.dot-3 {
  background-color: #eab308;
  box-shadow: 0 0 0 3px #fef08a;
}

.dot-4 {
  background-color: #f97316;
  box-shadow: 0 0 0 3px #ffedd5;
}

.dot-5 {
  background-color: #10b981;
  box-shadow: 0 0 0 3px #d1fae5;
}

.count-badge {
  background: #e2e8f0;
  color: #475569;
  font-weight: 700;
  padding: 4px 10px;
  border-radius: 20px;
  font-size: 0.75rem;
}

/* --- TARJETAS --- */
.kanban-cards {
  display: flex;
  flex-direction: column;
  gap: 12px;
  flex-grow: 1;
  min-height: 150px;
}

.kanban-card {
  background: var(--bg-surface);
  padding: 16px;
  border-radius: var(--radius-md);
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
  border: 1px solid var(--border-color);
  transition: all 0.2s ease;
  cursor: grab;
}

.kanban-card:hover {
  box-shadow: var(--shadow-md);
  transform: translateY(-2px);
  border-color: #cbd5e1;
}

.is-readonly {
  cursor: pointer;
}

.card-title {
  margin: 0 0 8px 0;
  font-size: 0.95rem;
  font-weight: 600;
  color: var(--text-main);
}

.card-company {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 0.8rem;
  color: var(--text-muted);
  margin-bottom: 16px;
}

.card-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-top: 1px solid #f1f5f9;
  padding-top: 12px;
}

.asesor-tag {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  font-size: 0.75rem;
  color: #475569;
  background: #f1f5f9;
  padding: 4px 10px;
  border-radius: 20px;
  font-weight: 600;
}

/* --- ANIMACIONES --- */
.ghost-card {
  opacity: 0.4;
  background: #e2e8f0;
  border: 2px dashed #94a3b8;
}

.dragging-card {
  transform: rotate(2deg);
  box-shadow: var(--shadow-lg);
}

.empty-zone {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: #94a3b8;
  font-size: 0.85rem;
  border: 2px dashed #e2e8f0;
  border-radius: var(--radius-md);
  padding: 30px 20px;
  margin-top: auto;
}
.empty-zone-icon {
  font-size: 2rem;
  margin-bottom: 8px;
  color: #cbd5e1;
}
</style>