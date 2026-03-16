<template>
  <aside class="dashboard-sidebar">
    <div class="sidebar-content">
      <ul class="sidebar-menu">
        <li>
          <a href="#" class="sidebar-link" :class="{ 'active': vistaActiva === 'tablero' }" @click.prevent="$emit('cambiar-vista', 'tablero')">
            <svg class="sidebar-icon" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <rect x="3" y="3" width="7" height="7"></rect>
              <rect x="14" y="3" width="7" height="7"></rect>
              <rect x="14" y="14" width="7" height="7"></rect>
              <rect x="3" y="14" width="7" height="7"></rect>
            </svg>
            <span class="link-text">Tablero</span>
          </a>
        </li>
        <li>
          <a href="#" class="sidebar-link" :class="{ 'active': vistaActiva === 'prospectos' }" @click.prevent="$emit('cambiar-vista', 'prospectos')">
            <svg class="sidebar-icon" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
              <circle cx="9" cy="7" r="4"></circle>
              <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
              <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
            </svg>
            <span class="link-text">Prospectos</span>
          </a>
        </li>
        <li>
          <a href="#" class="sidebar-link" @click.prevent="$emit('abrir-reportes')">
            <svg class="sidebar-icon" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <line x1="18" y1="20" x2="18" y2="10"></line>
              <line x1="12" y1="20" x2="12" y2="4"></line>
              <line x1="6" y1="20" x2="6" y2="14"></line>
            </svg>
            <span class="link-text">Reportes</span>
          </a>
        </li>
        <li>
          <a href="#" class="sidebar-link">
            <svg class="sidebar-icon" xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <circle cx="12" cy="12" r="3"></circle>
              <path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z"></path>
            </svg>
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
  color: #94a3b8;
  transition: all 0.2s ease;
  flex-shrink: 0;
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
  background-color: #f1f5f9;
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
