<template>
  <div class="modal-overlay" @click.self="$emit('cerrar')">
    <div class="modal-content modal-md">
      <button class="cerrar-modal" @click="$emit('cerrar')" title="Cerrar (Esc)">
        <i class="ti ti-x"></i>
      </button>

      <div class="detalle-header">
        <div class="avatar-perfil">
          {{ iniciales }}
        </div>
        <div class="info-principal">
          <h2>{{ cliente.nombre_cliente }}</h2>
          <div class="empresa-tag">
            <i class="ti ti-building"></i>
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
              <i class="ti ti-user"></i>
            </div>
            <p>{{ cliente.asesor_asignado }}</p>
          </div>
        </div>

        <div class="info-group full-width">
          <label>Notas y Actividad</label>
          <div class="notas-box">
            <div class="empty-notes">
              <i class="ti ti-clipboard-text empty-icon"></i>
              <p>Aún no hay notas registradas para este prospecto. Aquí podrás agregar el historial de reuniones y seguimientos.</p>
            </div>
          </div>
        </div>
      </div>

      <div class="detalle-footer">
        <button type="button" class="btn-secondary" @click="$emit('cerrar')">Cerrar Perfil</button>
        <button type="button" class="btn-primary contactar-btn">
          <i class="ti ti-headset"></i>
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
  background-color: var(--bg-avatar); color: var(--text-avatar); border-radius: 50%; font-size: 1.15rem;
}
.asesor-info p { margin: 0; font-size: 1rem; color: var(--text-main); font-weight: 600; }

/* Caja de Notas (Empty State) */
.notas-box { 
  background: var(--bg-app); border: 1px dashed var(--border-color); padding: 24px; 
  border-radius: var(--radius-md); 
}
.empty-notes {
  display: flex; flex-direction: column; align-items: center; text-align: center;
  color: #94a3b8; gap: 12px;
}
.empty-icon { font-size: 2rem; color: #cbd5e1; }
.empty-notes p { margin: 0; font-size: 0.9rem; max-width: 400px; line-height: 1.5; }

/* --- PIE DEL MODAL (Botones) --- */
.detalle-footer { 
  margin-top: 32px; display: flex; justify-content: flex-end; gap: 12px;
  padding-top: 20px; border-top: 1px solid var(--border-color);
}

.btn-secondary {
  background-color: var(--bg-surface); color: var(--text-main); border: 1px solid var(--border-color);
  padding: 10px 20px; border-radius: var(--radius-md); font-weight: 600; font-size: 0.95rem;
  cursor: pointer; transition: all 0.2s ease;
}
.btn-secondary:hover { background-color: var(--bg-element); border-color: var(--primary); }

.contactar-btn { display: flex; align-items: center; gap: 8px; }


</style>