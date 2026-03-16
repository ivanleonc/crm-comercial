import { ref, watchEffect } from 'vue';

// Estado global reactivo para el tema
const theme = ref(localStorage.getItem('crm-theme') || 'system');

export function useTheme() {
  
  // Función para evaluar y aplicar la clase .dark al HTML
  const applyTheme = () => {
    const isDark = theme.value === 'dark' || 
                  (theme.value === 'system' && window.matchMedia('(prefers-color-scheme: dark)').matches);
                  
    if (isDark) {
      document.documentElement.classList.add('dark');
    } else {
      document.documentElement.classList.remove('dark');
    }
  };

  // Función cíclica para cambiar el tema
  const toggleTheme = () => {
    if (theme.value === 'light') {
      theme.value = 'dark';
    } else if (theme.value === 'dark') {
      theme.value = 'system';
    } else {
      theme.value = 'light';
    }
    
    // Guardar preferencia
    localStorage.setItem('crm-theme', theme.value);
  };
  
  // Reaccionar a cambios en las preferencias del sistema en tiempo real
  window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', () => {
    if (theme.value === 'system') {
      applyTheme();
    }
  });

  // Watcher reactivo que aplica el tema cada vez que cambia el estado
  watchEffect(() => {
    applyTheme();
  });

  return {
    theme,
    toggleTheme,
    applyTheme
  };
}
