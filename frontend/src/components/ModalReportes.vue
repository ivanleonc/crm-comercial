<template>
  <div class="modal-overlay" @click.self="$emit('cerrar')">
    <div class="modal-content modal-xl">
      <button class="cerrar-modal" @click="$emit('cerrar')" title="Cerrar (Esc)">
        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <line x1="18" y1="6" x2="6" y2="18"></line>
          <line x1="6" y1="6" x2="18" y2="18"></line>
        </svg>
      </button>

      <div class="modal-header">
        <div class="header-icon">
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <line x1="18" y1="20" x2="18" y2="10"></line>
            <line x1="12" y1="20" x2="12" y2="4"></line>
            <line x1="6" y1="20" x2="6" y2="14"></line>
          </svg>
        </div>
        <div>
          <h2>Reporte General de Clientes</h2>
          <p class="text-muted">Vista tabular de todos los prospectos y su estado actual en el pipeline.</p>
        </div>
      </div>
      
      <div v-if="clientes.length === 0" class="empty-state">
        <svg class="empty-icon" xmlns="http://www.w3.org/2000/svg" width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
          <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
          <line x1="3" y1="9" x2="21" y2="9"></line>
          <line x1="9" y1="21" x2="9" y2="9"></line>
        </svg>
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
                <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
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
.modal-xl { max-width: 900px; width: 95%; }

/* Encabezado del Modal (Mismo estilo que Registro) */
.modal-header { display: flex; align-items: center; gap: 16px; margin-bottom: 24px; }
.header-icon {
  display: flex; justify-content: center; align-items: center; width: 48px; height: 48px;
  background-color: #f0fdfa; color: #0d9488; border-radius: 12px; /* Verde esmeralda para reportes */
}
.modal-header h2 { margin: 0 0 4px 0; font-size: 1.25rem; color: var(--text-main); }
.modal-header p { margin: 0; font-size: 0.9rem; }

/* Contenedor de la Tabla */
.table-container {
  overflow-x: auto; border: 1px solid var(--border-color);
  border-radius: var(--radius-lg); max-height: 60vh;
  box-shadow: var(--shadow-sm);
}
.modern-table { width: 100%; border-collapse: collapse; background: var(--bg-surface); text-align: left; }
.modern-table th {
  background: #F8FAFC; color: var(--text-muted); font-size: 0.75rem;
  text-transform: uppercase; letter-spacing: 0.5px; padding: 16px 20px; 
  border-bottom: 1px solid var(--border-color); position: sticky; top: 0; z-index: 10;
  font-weight: 600;
}
.modern-table td { padding: 16px 20px; border-bottom: 1px solid var(--border-color); font-size: 0.9rem; color: var(--text-main); }
.modern-table tr:hover { background-color: #f8fafc; transition: background-color 0.2s ease; }
.modern-table tr:last-child td { border-bottom: none; }

/* Celda del Cliente (con inicial) */
.client-cell { display: flex; align-items: center; gap: 12px; }
.client-avatar {
  display: flex; justify-content: center; align-items: center;
  width: 32px; height: 32px; background: #e2e8f0; color: #475569;
  border-radius: 50%; font-weight: 700; font-size: 0.85rem;
}

/* Celda del Asesor */
.asesor-cell { display: flex; align-items: center; gap: 6px; color: var(--text-muted); }

/* Badges de Estado Premium */
.status-badge { 
  padding: 6px 12px; border-radius: 20px; font-size: 0.75rem; 
  font-weight: 600; display: inline-flex; align-items: center; justify-content: center;
  white-space: nowrap;
}
/* Mapeo de colores (Tailwind Palette) */
.status-prospecto { background-color: #F1F5F9; color: #475569; border: 1px solid #E2E8F0; }
.status-contacto-inicial { background-color: #DBEAFE; color: #1E40AF; border: 1px solid #BFDBFE; }
.status-propuesta-enviada { background-color: #FEF3C7; color: #B45309; border: 1px solid #FDE68A; }
.status-negociacion { background-color: #FFEDD5; color: #C2410C; border: 1px solid #FED7AA; }
.status-cerrado-ganado { background-color: #D1FAE5; color: #065F46; border: 1px solid #A7F3D0; }

/* Estado Vacío */
.empty-state {
  text-align: center; padding: 48px 24px; border: 1px dashed var(--border-color);
  border-radius: var(--radius-lg); background-color: #f8fafc;
}
.empty-icon { color: #cbd5e1; margin-bottom: 16px; }
.empty-state h3 { margin: 0 0 8px 0; color: var(--text-main); font-size: 1.1rem; }
</style>