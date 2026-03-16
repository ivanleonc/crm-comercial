<template>
  <aside class="dashboard-sidebar">
    <div class="sidebar-content">
      <ul class="sidebar-menu">
        <li>
          <a href="#" class="sidebar-link" :class="{ 'active': vistaActiva === 'tablero' }" @click.prevent="$emit('cambiar-vista', 'tablero')">
            <i class="ti ti-layout-dashboard sidebar-icon"></i>
            <span class="link-text">Tablero</span>
          </a>
        </li>
        <li>
          <a href="#" class="sidebar-link" :class="{ 'active': vistaActiva === 'prospectos' }" @click.prevent="$emit('cambiar-vista', 'prospectos')">
            <i class="ti ti-users sidebar-icon"></i>
            <span class="link-text">Prospectos</span>
          </a>
        </li>
        <li>
          <a href="#" class="sidebar-link" @click.prevent="$emit('abrir-reportes')">
            <i class="ti ti-chart-bar sidebar-icon"></i>
            <span class="link-text">Reportes</span>
          </a>
        </li>
        <li>
          <a href="#" class="sidebar-link">
            <i class="ti ti-settings sidebar-icon"></i>
            <span class="link-text">Configuración</span>
          </a>
        </li>
      </ul>
    </div>
  </aside>
</template>

<script setup>
defineProps({
  vistaActiva: {
    type: String,
    default: 'tablero'
  }
});

defineEmits(['abrir-reportes', 'cambiar-vista']);
</script>

<style scoped>
.dashboard-sidebar {
  width: 72px;
  background-color: var(--bg-surface);
  border-right: 1px solid var(--border-color);
  height: calc(100vh - 72px); /* Altura total menos el navbar */
  position: fixed;
  top: 72px; /* Debajo del navbar */
  left: 0;
  overflow-y: hidden;
  overflow-x: hidden;
  box-shadow: 2px 0 8px -2px rgba(0, 0, 0, 0.05); /* Sombra suave a la derecha */
  z-index: 800;
  transition: width 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.dashboard-sidebar:hover {
  width: 260px;
  overflow-y: auto;
  box-shadow: 8px 0 24px -4px rgba(0, 0, 0, 0.1);
}

.sidebar-content {
  padding: 24px 0;
}

.sidebar-menu {
  list-style: none;
  padding: 0;
  margin: 0;
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.sidebar-link {
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 12px 14px;
  margin: 0 12px;
  color: var(--text-muted);
  text-decoration: none;
  font-weight: 500;
  font-size: 0.95rem;
  border-radius: var(--radius-md);
  transition: all 0.2s ease;
  white-space: nowrap;
}

.sidebar-icon {
  color: var(--text-muted);
  transition: all 0.2s ease;
  flex-shrink: 0;
  font-size: 1.25rem; /* Ajuste para webfont (ocupa el lugar de width/height) */
}

.link-text {
  opacity: 0;
  transform: translateX(-10px);
  transition: opacity 0.2s ease, transform 0.2s ease;
}

.dashboard-sidebar:hover .link-text {
  opacity: 1;
  transform: translateX(0);
  transition-delay: 0.1s;
}

.sidebar-link:hover {
  background-color: var(--bg-element);
  color: var(--primary);
}

.sidebar-link:hover .sidebar-icon {
  color: var(--primary);
  transform: translateX(2px);
}

.sidebar-link.active {
  background-color: var(--focus-ring);
  color: var(--primary);
  font-weight: 600;
}

.sidebar-link.active .sidebar-icon {
  color: var(--primary);
}
</style>
