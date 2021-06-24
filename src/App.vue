<template>
  <router-view id="new_home"></router-view>
</template>

<script>
import store from "./store";
export default {
  name: "App",
  beforeDestroy() {
    store.commit("user_logout");
  },
};
</script>

<style lang="scss">
// Import Main styles for this application
@import "assets/scss/style";
.c-main {
  padding-top: 0 !important;
}
// Header fissa e body shift di 50px in basso e con ombreggiatura
.fixed-nav {
  position: fixed !important;
  top: 0;
}
// #header {
//   box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
// }
.c-header-nav-link {
  color: #0b4a9b !important;
}
.c-header-nav-link:hover {
  color: #ef7a12 !important;
}

.c-body {
  margin-top: 56px;
}
//STILE PER IL PULSANTE RESET DELLA MODALE ADD-NEWS
#reset-btn {
  color: #e55353 !important;
  border-color: #e55353 !important;
  background-color: white;
  margin-right: 1em;
}
#reset-btn:active {
  color: #ffffff !important;
  border-color: #e55353 !important;
  background-color: #e47373 !important;
  margin-right: 1em;
}

//ICONA ROSSA NELLE TABELLE IN CASO DI NESSUN RISULTATO
.text-danger.mb-2.c-icon.c-icon-custom-size {
  display: none !important;
}

// Colori Modali
.close:hover {
  color: white;
}
.close {
  opacity: 1;
  color: white;
}

.modal-header {
  background-color: #1e2f56 !important;
}

// SOVRASCRITTURA COLORI ABY SU TOOLTIP
.arrow {
  border-right-color: #1e2f56 !important;
}
.tooltip-old-inner {
  background-color: #1e2f56 !important;
}

#icona_indietro {
  width: 2.5rem;
  height: 2.5rem;
  font-size: 2.5rem;
  margin-top: 7px;
}

// SOVRASCRITTURA COLORI ABY SU PRIMARY
.dropdown-item.active,
.dropdown-item:active {
  text-decoration: none;
  color: #fff;
  background-color: #1f4b6b !important;
}

.btn-outline-primary:hover {
  color: #fff;
  background-color: #1f4b6b;
  border-color: #1f4b6b;
}
.btn-outline-primary:active {
  color: #fff;
  background-color: #1f4b6b !important;
  border-color: #1f4b6b !important;
}
.btn-outline-primary:focus {
  box-shadow: 0 0 0 0.2rem rgba(148, 140, 215, 0.5) !important;
}
.btn-primary {
  color: #fff;
  background-color: #1f4b6b;
  border-color: #1f4b6b;
}
.btn-outline-primary {
  border-color: #1f4b6b;
  color: #1f4b6b;
}

.table td {
  vertical-align: middle !important;
}

::after,
::before {
  text-decoration: inherit !important;
  vertical-align: middle !important;
}

// Paginazione
.page-item.active .page-link {
  color: #fff;
  background-color: #1f4b6b;
  border-color: #1f4b6b;
}
.page-link {
  color: #1f4b6b;
}

.c-app {
  --primary: #1f4b6b !important;
  --info: #1f4b6b !important;
}
:root {
  --primary: #1f4b6b !important;
}

#accedi_btn {
  background-color: #1f2f55;
  border: 0;
  color: white;
  padding-top: 8px;
  padding-bottom: 8px;
  font-weight: 900;
  font-size: 1.4em;
  text-transform: uppercase;
}
#accedi_btn:hover {
  background: #1255a6;
}
.container {
  max-width: 1320px !important;
}
.titolo_sezione {
  font-weight: 700;
  font-size: xx-large;
  text-transform: uppercase;
}
.c-body{
  flex-grow: initial !important;
}

</style>
