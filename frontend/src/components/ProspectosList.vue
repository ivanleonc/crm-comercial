<template>
  <section class="prospectos-list-wrapper">
    <div class="section-header">
      <div class="header-left">
        <div class="header-icon">
          <i class="ti ti-users header-icon-inner"></i>
        </div>
        <div>
          <h2>Directorio de Prospectos</h2>
          <p class="text-muted">Vista tabular detallada de todos los clientes y su estado en el pipeline.</p>
        </div>
      </div>

      <button class="btn-nuevo-prospecto" @click="$emit('abrir-registro')">
        <i class="ti ti-plus"></i>
        Nuevo Prospecto
      </button>
    </div>

    <div v-if="clientes.length === 0" class="empty-state">
      <i class="ti ti-folder-open empty-icon"></i>
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
              <i class="ti ti-user"></i>
              {{ c.asesor_asignado }}
            </td>
            <td>
              <button class="btn-action" title="Ver detalles" @click="$emit('ver-detalles', c)">
                <i class="ti ti-eye"></i>
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
.section-header {
  margin-bottom: 32px;
  padding: 0 4px;
  display: flex;
  justify-content: space-between;
  align-items: center;
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
  background-color: var(--bg-element);
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

.btn-nuevo-prospecto i {
  font-size: 1.25rem;
}

/* --- TABLA --- */
.table-container {
  overflow-x: auto;
  border: 1px solid var(--border-color);
  border-radius: var(--radius-lg);
  box-shadow: var(--shadow-sm);
  background: var(--bg-surface);
}

.modern-table {
  width: 100%;
  border-collapse: collapse;
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

/* Elementos de tabla */
.client-cell {
  display: flex;
  align-items: center;
  gap: 12px;
}

.client-avatar {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 36px;
  height: 36px;
  background: var(--bg-avatar);
  color: var(--text-avatar);
  border-radius: 50%;
  font-weight: 700;
  font-size: 0.85rem;
}

.asesor-cell {
  align-items: center;
}

.asesor-cell i {
  font-size: 1.1rem;
}


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
  background: var(--bg-element);
  color: var(--primary);
}

.btn-action i {
  font-size: 1.25rem;
}

/* Estado Vacío */
.empty-state {
  text-align: center;
  padding: 64px 24px;
  border: 1px dashed var(--border-color);
  border-radius: var(--radius-lg);
  background-color: var(--bg-surface);
}

.empty-icon {
  color: #cbd5e1;
  margin-bottom: 20px;
  font-size: 4rem;
}

.empty-state h3 {
  margin: 0 0 8px 0;
  color: var(--text-main);
  font-size: 1.25rem;
  font-weight: 600;
}
</style>
