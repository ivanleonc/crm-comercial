# 🚀 CRM Comercial - Sistema de Gestión de Prospectos

Un moderno sistema CRM (Customer Relationship Management) diseñado para gestionar el flujo de ventas a través de un tablero Kanban interactivo. Construido con una arquitectura cliente-servidor utilizando Vue 3 y Node.js.

## ✨ Características Principales

* **Tablero Kanban Interactivo:** Sistema de arrastrar y soltar (Drag & Drop) fluido con `vuedraggable` para mover clientes entre las distintas fases de venta.
* **Gestión de Prospectos:** Formularios modales para registrar nuevos clientes y asignar asesores.
* **Vista de Detalles:** Tarjetas interactivas que despliegan la información completa del prospecto al hacer clic.
* **Sincronización en Tiempo Real:** Interfaz reactiva que actualiza la base de datos de forma asíncrona al mover tarjetas.
* **UI/UX Premium:** Diseño moderno tipo SaaS, utilizando variables CSS globales, sombras suaves (soft-shadows) y animaciones.

## 🛠️ Tecnologías Utilizadas

* **Frontend:** Vue 3 (Composition API), Vite, VueDraggable (Sortable.js), CSS3 (Variables globales).
* **Backend:** Node.js, Express, CORS.
* **Base de Datos:** MySQL (con paquete `mysql2`).

## ⚙️ Requisitos Previos

Para ejecutar este proyecto localmente, necesitarás tener instalado:
* [Node.js](https://nodejs.org/) (v16 o superior)
* [MySQL Server](https://dev.mysql.com/downloads/mysql/)

## 🚀 Instalación y Configuración (Entorno de Desarrollo)

### 1. Clonar el repositorio
```bash
git clone [https://github.com/ivanleonc/crm-comercial.git](https://github.com/ivanleonc/crm-comercial.git)
cd crm-comercial
