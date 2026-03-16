<template>
  <section class="prospectos-list-wrapper">
    <div class="section-header">
      <div class="header-left">
        <div class="header-icon">
          <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
            <circle cx="9" cy="7" r="4"></circle>
            <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
            <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
          </svg>
        </div>
        <div>
          <h2>Directorio de Prospectos</h2>
          <p class="text-muted">Vista tabular detallada de todos los clientes y su estado en el pipeline.</p>
        </div>
      </div>
      
      <button class="btn-nuevo-prospecto" @click="$emit('abrir-registro')">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none"
          stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <line x1="12" y1="5" x2="12" y2="19"></line>
          <line x1="5" y1="12" x2="19" y2="12"></line>
        </svg>
        Nuevo Prospecto
      </button>
    </div>

    <div v-if="clientes.length === 0" class="empty-state">
      <svg class="empty-icon" xmlns="http://www.w3.org/2000/svg" width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
        <rect x="3" y="3" width="18" height="18" rx="2" ry="2"></rect>
        <line x1="3" y1="9" x2="21" y2="9"></line>
        <line x1="9" y1="21" x2="9" y2="9"></line>
      </svg>
      <h3>No hay prospectos disponibles</h3>
      <p class="text-muted">Aún no se han registrado prospectos en el sistema.</p>
    </div>

    <div v-else class="table-container fade-in-up">
      <table class="modern-table">
        <thead>
          <tr>
            <th>Cliente</th>
            <th>Empresa</th>
            <th>Estado Actual</th>
            <th>Asesor Asignado</th>
            <th>Acciones</th>
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
            <td>
               <button class="btn-action" title="Ver detalles" @click="$emit('ver-detalles', c)">
                  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                    <circle cx="12" cy="12" r="3"></circle>
                  </svg>
               </button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </section>
</template>

<script setup>
defineProps({
  clientes: {
    type: Array,
    required: true
  }
});

defineEmits(['abrir-registro', 'ver-detalles']);
</script>

<style scoped>
.prospectos-list-wrapper {
  padding-top: 10px;
  max-width: 1400px;
  margin: 0 auto;
}

/* --- ENCABEZADO DE SECCIÓN --- */
.section-header { margin-bottom: 32px; padding: 0 4px; display: flex; justify-content: space-between; align-items: center; }
.header-left { display: flex; align-items: center; gap: 16px; }
.header-icon {
  display: flex; justify-content: center; align-items: center; width: 48px; height: 48px;
  background-color: #f0fdfa; color: #0d9488; border-radius: 12px;
}
.section-header h2 { margin: 0 0 4px 0; font-size: 1.5rem; color: var(--text-main); font-weight: 700; letter-spacing: -0.025em; }
.section-header p { margin: 0; font-size: 0.95rem; }

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

/* --- TABLA --- */
.table-container {
  overflow-x: auto; 
  border: 1px solid var(--border-color);
  border-radius: var(--radius-lg); 
  box-shadow: var(--shadow-sm);
  background: var(--bg-surface);
}
.modern-table { width: 100%; border-collapse: collapse; text-align: left; }
.modern-table th {
  background: #F8FAFC; color: var(--text-muted); font-size: 0.75rem;
  text-transform: uppercase; letter-spacing: 0.5px; padding: 16px 20px; 
  border-bottom: 1px solid var(--border-color);
  font-weight: 600;
}
.modern-table td { padding: 16px 20px; border-bottom: 1px solid var(--border-color); font-size: 0.9rem; color: var(--text-main); }
.modern-table tr:hover { background-color: #f8fafc; transition: background-color 0.2s ease; }
.modern-table tr:last-child td { border-bottom: none; }

/* Elementos de tabla */
.client-cell { display: flex; align-items: center; gap: 12px; }
.client-avatar {
  display: flex; justify-content: center; align-items: center;
  width: 36px; height: 36px; background: #e2e8f0; color: #475569;
  border-radius: 50%; font-weight: 700; font-size: 0.85rem;
}
.asesor-cell { display: flex; align-items: center; gap: 6px; color: var(--text-muted); }

/* Badges de Estado */
.status-badge { 
  padding: 6px 12px; border-radius: 20px; font-size: 0.75rem; 
  font-weight: 600; display: inline-flex; align-items: center; justify-content: center;
  white-space: nowrap;
}
.status-prospecto { background-color: #F1F5F9; color: #475569; border: 1px solid #E2E8F0; }
.status-contacto-inicial { background-color: #DBEAFE; color: #1E40AF; border: 1px solid #BFDBFE; }
.status-propuesta-enviada { background-color: #FEF3C7; color: #B45309; border: 1px solid #FDE68A; }
.status-negociacion { background-color: #FFEDD5; color: #C2410C; border: 1px solid #FED7AA; }
.status-cerrado-ganado { background-color: #D1FAE5; color: #065F46; border: 1px solid #A7F3D0; }

.btn-action {
  background: transparent;
  color: var(--text-muted);
  border: none;
  border-radius: 6px;
  padding: 6px;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.2s;
}
.btn-action:hover {
  background: #f1f5f9;
  color: var(--primary);
}

/* Estado Vacío */
.empty-state {
  text-align: center; padding: 64px 24px; border: 1px dashed var(--border-color);
  border-radius: var(--radius-lg); background-color: var(--bg-surface);
}
.empty-icon { color: #cbd5e1; margin-bottom: 20px; }
.empty-state h3 { margin: 0 0 8px 0; color: var(--text-main); font-size: 1.25rem; font-weight: 600;}
</style>
