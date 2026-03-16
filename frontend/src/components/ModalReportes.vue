<template>
  <div class="modal-overlay" @click.self="$emit('cerrar')">
    <div class="modal-content modal-xl">
      <button class="cerrar-modal" @click="$emit('cerrar')" title="Cerrar (Esc)">
        <i class="ti ti-x"></i>
      </button>

      <div class="modal-header">
        <div class="header-icon">
          <i class="ti ti-chart-bar header-icon-inner"></i>
        </div>
        <div>
          <h2>Reporte General de Clientes</h2>
          <p class="text-muted">Vista tabular de todos los prospectos y su estado actual en el pipeline.</p>
        </div>
      </div>

      <div v-if="clientes.length === 0" class="empty-state">
        <i class="ti ti-database-off empty-icon"></i>
        <h3>No hay datos disponibles</h3>
        <p class="text-muted">Aún no se han registrado clientes en el sistema.</p>
      </div>

      <div v-else class="table-container">
        <table class="modern-table">
          <thead>
            <tr>
              <th>Cliente</th>
              <th>Empresa</th>
              <th>Estado Actual</th>
              <th>Asesor Asignado</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="c in clientes" :key="c.id_cliente">
              <td>
                <div class="client-cell">
                  <div class="client-avatar">{{ c.nombre_cliente.charAt(0).toUpperCase() }}</div>
                  <strong>{{ c.nombre_cliente }}</strong>
                </div>
              </td>
              <td>{{ c.empresa }}</td>
              <td>
                <span :class="['status-badge', 'status-' + (c.estado_actual || '').replace(/\s+/g, '-').toLowerCase()]">
                  {{ c.estado_actual }}
                </span>
              </td>
              <td class="asesor-cell">
                <i class="ti ti-user"></i>
                {{ c.asesor_asignado }}
              </td>
            </tr>
          </tbody>
        </table>
      </div>

    </div>
  </div>
</template>

<script setup>
defineProps({
  clientes: {
    type: Array,
    required: true
  }
});

defineEmits(['cerrar']);
</script>

<style scoped>
/* Control de ancho del modal para vistas de tabla */
.modal-xl {
  max-width: 900px;
  width: 95%;
}

/* Encabezado del Modal (Mismo estilo que Registro) */
.modal-header {
  display: flex;
  align-items: center;
  gap: 16px;
  margin-bottom: 24px;
}

.header-icon {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 48px;
  height: 48px;
  background-color: var(--bg-element);
  color: var(--primary);
  border-radius: 12px;
}

.header-icon-inner {
  font-size: 1.5rem;
}

.modal-header h2 {
  margin: 0 0 4px 0;
  font-size: 1.25rem;
  color: var(--text-main);
}

.modal-header p {
  margin: 0;
  font-size: 0.9rem;
}

/* Contenedor de la Tabla */
.table-container {
  overflow-x: auto;
  border: 1px solid var(--border-color);
  border-radius: var(--radius-lg);
  max-height: 60vh;
  box-shadow: var(--shadow-sm);
}

.modern-table {
  width: 100%;
  border-collapse: collapse;
  background: var(--bg-surface);
  text-align: left;
}

.modern-table th {
  background: var(--bg-app);
  color: var(--text-muted);
  font-size: 0.75rem;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  padding: 16px 20px;
  border-bottom: 1px solid var(--border-color);
  position: sticky;
  top: 0;
  z-index: 10;
  font-weight: 600;
}

.modern-table td {
  padding: 16px 20px;
  border-bottom: 1px solid var(--border-color);
  font-size: 0.9rem;
  color: var(--text-main);
}

.modern-table tr:hover {
  background-color: var(--bg-element);
  transition: background-color 0.2s ease;
}

.modern-table tr:last-child td {
  border-bottom: none;
}

/* Celda del Cliente (con inicial) */
.client-cell {
  display: flex;
  align-items: center;
  gap: 12px;
}

.client-avatar {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 32px;
  height: 32px;
  background: var(--bg-avatar);
  color: var(--text-avatar);
  border-radius: 50%;
  font-weight: 700;
  font-size: 0.85rem;
}

/* Celda del Asesor */
.asesor-cell {
  align-items: center;
}

.asesor-cell i {
  font-size: 1.1rem;
}



/* Estado Vacío */
.empty-state {
  text-align: center;
  padding: 48px 24px;
  border: 1px dashed var(--border-color);
  border-radius: var(--radius-lg);
  background-color: var(--bg-element);
}

.empty-icon {
  color: #cbd5e1;
  margin-bottom: 16px;
  font-size: 3rem;
}

.empty-state h3 {
  margin: 0 0 8px 0;
  color: var(--text-main);
  font-size: 1.1rem;
}
</style>