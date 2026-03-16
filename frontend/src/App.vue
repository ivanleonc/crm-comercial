<template>
  <router-view></router-view>
</template>

<script setup>
import { useTheme } from './composables/useTheme';

// Inicializar el sistema de temas al cargar la app
useTheme();
</script>