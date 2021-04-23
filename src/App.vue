<template>
  <router-view id="new_home"></router-view>
</template>

<script>
export default {
  name: "App",
};
</script>

<style lang="scss">
// Import Main styles for this application
@import "assets/scss/style";
.c-main {
  padding-top: 0 !important;
}
// Header fissa e body shift di 50px in basso
.fixed-nav {
  position: fixed !important;
  top: 0;
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

// SOVRASCRITTURA COLORI ABY SU PRIMARY
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

.table td{
  vertical-align: middle !important;
}

::after, ::before {
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
</style>
