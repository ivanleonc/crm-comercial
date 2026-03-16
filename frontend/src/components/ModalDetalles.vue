<template>
  <div class="modal-overlay" @click.self="$emit('cerrar')">
    <div class="modal-content modal-md">
      <button class="cerrar-modal" @click="$emit('cerrar')" title="Cerrar (Esc)">
        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <line x1="18" y1="6" x2="6" y2="18"></line>
          <line x1="6" y1="6" x2="18" y2="18"></line>
        </svg>
      </button>

      <div class="detalle-header">
        <div class="avatar-perfil">
          {{ iniciales }}
        </div>
        <div class="info-principal">
          <h2>{{ cliente.nombre_cliente }}</h2>
          <div class="empresa-tag">
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <rect x="4" y="2" width="16" height="20" rx="2" ry="2"></rect>
              <path d="M9 22v-4h6v4"></path>
              <path d="M8 6h.01M16 6h.01M12 6h.01M12 10h.01M16 10h.01M8 10h.01M8 14h.01M12 14h.01M16 14h.01"></path>
            </svg>
            <span>{{ cliente.empresa }}</span>
          </div>
        </div>
      </div>

      <hr class="divider" />

      <div class="detalle-body">
        
        <div class="info-group">
          <label>Estado en el Pipeline</label>
          <div>
            <span :class="['status-badge', 'status-' + (cliente.estado_actual || '').replace(/\s+/g, '-').toLowerCase()]">
              {{ cliente.estado_actual }}
            </span>
          </div>
        </div>

        <div class="info-group">
          <label>Asesor Comercial</label>
          <div class="asesor-info">
            <div class="asesor-icon">
              <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                <circle cx="12" cy="7" r="4"></circle>
              </svg>
            </div>
            <p>{{ cliente.asesor_asignado }}</p>
          </div>
        </div>

        <div class="info-group full-width">
          <label>Notas y Actividad</label>
          <div class="notas-box">
            <div class="empty-notes">
              <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                <polyline points="14 2 14 8 20 8"></polyline>
                <line x1="16" y1="13" x2="8" y2="13"></line>
                <line x1="16" y1="17" x2="8" y2="17"></line>
                <polyline points="10 9 9 9 8 9"></polyline>
              </svg>
              <p>Aún no hay notas registradas para este prospecto. Aquí podrás agregar el historial de reuniones y seguimientos.</p>
            </div>
          </div>
        </div>
      </div>

      <div class="detalle-footer">
        <button type="button" class="btn-secondary" @click="$emit('cerrar')">Cerrar Perfil</button>
        <button type="button" class="btn-primary contactar-btn">
          <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path>
            <polyline points="22,6 12,13 2,6"></polyline>
          </svg>
          Contactar Cliente
        </button>
      </div>

    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue';

const props = defineProps({
  cliente: {
    type: Object,
    required: true
  }
});

defineEmits(['cerrar']);

// Función para calcular iniciales (Ej: "Ivan Capote" -> "IC")
const iniciales = computed(() => {
  if (!props.cliente?.nombre_cliente) return '?';
  const partes = props.cliente.nombre_cliente.trim().split(' ');
  if (partes.length > 1) {
    return (partes[0][0] + partes[1][0]).toUpperCase();
  }
  return props.cliente.nombre_cliente.substring(0, 2).toUpperCase();
});
</script>

<style scoped>
/* Control de ancho del modal */
.modal-md { max-width: 600px; width: 95%; }

/* --- ENCABEZADO (Avatar y Nombre) --- */
.detalle-header { display: flex; align-items: center; gap: 20px; margin-bottom: 8px; }

.avatar-perfil {
  width: 72px; height: 72px; border-radius: 50%;
  background: linear-gradient(135deg, var(--primary) 0%, #6366f1 100%);
  color: white; display: flex; justify-content: center; align-items: center;
  font-size: 1.75rem; font-weight: 700; box-shadow: 0 4px 6px -1px rgba(79, 70, 229, 0.3);
  letter-spacing: 1px;
}

.info-principal h2 { margin: 0 0 6px 0; color: var(--text-main); font-size: 1.5rem; letter-spacing: -0.025em; }

.empresa-tag {
  display: inline-flex; align-items: center; gap: 6px;
  color: var(--text-muted); font-size: 0.95rem; font-weight: 500;
}

.divider { border: none; border-top: 1px solid var(--border-color); margin: 24px 0; }

/* --- CUERPO DEL DETALLE (Grid de Info) --- */
.detalle-body { display: grid; grid-template-columns: 1fr 1fr; gap: 24px; }
.full-width { grid-column: 1 / -1; }

.info-group label { 
  display: block; font-size: 0.75rem; color: #64748b; 
  font-weight: 700; margin-bottom: 10px; text-transform: uppercase; letter-spacing: 0.5px;
}

/* Info del Asesor */
.asesor-info { display: flex; align-items: center; gap: 8px; }
.asesor-icon { 
  display: flex; justify-content: center; align-items: center; width: 28px; height: 28px; 
  background-color: #f1f5f9; color: #475569; border-radius: 50%; 
}
.asesor-info p { margin: 0; font-size: 1rem; color: var(--text-main); font-weight: 600; }

/* Caja de Notas (Empty State) */
.notas-box { 
  background: #f8fafc; border: 1px dashed #cbd5e1; padding: 24px; 
  border-radius: var(--radius-md); 
}
.empty-notes {
  display: flex; flex-direction: column; align-items: center; text-align: center;
  color: #94a3b8; gap: 12px;
}
.empty-notes p { margin: 0; font-size: 0.9rem; max-width: 400px; line-height: 1.5; }

/* --- PIE DEL MODAL (Botones) --- */
.detalle-footer { 
  margin-top: 32px; display: flex; justify-content: flex-end; gap: 12px;
  padding-top: 20px; border-top: 1px solid var(--border-color);
}

.btn-secondary {
  background-color: white; color: var(--text-main); border: 1px solid var(--border-color);
  padding: 10px 20px; border-radius: var(--radius-md); font-weight: 600; font-size: 0.95rem;
  cursor: pointer; transition: all 0.2s ease;
}
.btn-secondary:hover { background-color: #f1f5f9; border-color: #cbd5e1; }

.contactar-btn { display: flex; align-items: center; gap: 8px; }

/* --- BADGES (Mismo estilo que Reportes) --- */
.status-badge { 
  padding: 6px 12px; border-radius: 20px; font-size: 0.8rem; 
  font-weight: 600; display: inline-flex; align-items: center; justify-content: center;
}
.status-prospecto { background-color: #F1F5F9; color: #475569; border: 1px solid #E2E8F0; }
.status-contacto-inicial { background-color: #DBEAFE; color: #1E40AF; border: 1px solid #BFDBFE; }
.status-propuesta-enviada { background-color: #FEF3C7; color: #B45309; border: 1px solid #FDE68A; }
.status-negociacion { background-color: #FFEDD5; color: #C2410C; border: 1px solid #FED7AA; }
.status-cerrado-ganado { background-color: #D1FAE5; color: #065F46; border: 1px solid #A7F3D0; }
</style>