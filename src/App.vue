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
  color: #ef7918 !important;
}

.c-body {
  margin-top: 56px;
}
// profondità modale
.modal-backdrop {
  z-index: auto !important;
}

// STILE PER EMULARE LA CLASSE BOOTSTRAP DISPLAY CHE MA RENDERLA RESPONSIVE
// UTILIZZATO PER I TITOLI

.titolo-display {
  font-size: 4.5rem;
  letter-spacing: 0.1rem;
  font-weight: initial !important;
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

/* CARD CONTENUTI COMMERCIALE */
.card_materiale:hover {
  box-shadow: 0 12px 19px -7px rgba(0, 0, 0, 0.3);
  transform: translateY(-10px);
  -webkit-transform: translateY(-10px);
  -ms-transform: translateY(-10px);
  -moz-transform: translateY(-10px);
  cursor: pointer;
}
.latest {
  color: #3c4b64;
}
.card-accent-success {
  border-top: 0px solid #0e7731 !important;
}
.card-accent-info {
  border-top: 0px solid #223560 !important;
}
div.card-accent-info:before {
  content: "";
  position: absolute;
  left: 0;
  top: 0;
  height: 5px;
  width: 50%;
  border-top: 6px solid #223560 !important;
}
div.card-accent-success:before {
  content: "";
  position: absolute;
  left: 0;
  top: 0;
  height: 5px;
  width: 50%;
  border-top: 6px solid #0e7731 !important;
}

.card-img-none {
  max-height: 200px !important;
  min-height: 200px;
  object-fit: cover;
}

cite {
  color: #ef7918;
  font-size: 0.8rem;
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
  background-color: #1f4b6b !important;
}

// Dimensione delle modali
.modal-body {
  overflow-y: auto !important;
  max-height: 80vh !important;
}

// SOVRASCRITTURA COLORI ABY SU TOOLTIP
.arrow {
  border-right-color: #1f4b6b !important;
}
.tooltip-old-inner {
  background-color: #1f4b6b !important;
}

#icona_indietro {
  width: 2.5rem;
  height: 2.5rem;
  font-size: 2.5rem;
  margin-top: 7px;
}

// SOVRASCRITTURA COLORI ABY SU PRIMARY
.btn-primary:hover {
  background-color: #1a6eb9 !important;
  border-color: #1a6eb9 !important;
}

.dropdown-item.active,
.dropdown-item:active {
  text-decoration: none;
  color: #fff;
  background-color: #1f4b6b !important;
}
a {
  color: #1f4b6b !important;
  font-size: 1rem;
  font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
  font-weight: 400;
}
a.active {
  background: #ef7918ad !important;
  color: #fff !important;
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
  background-color: #1f4b6bba;
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
#formLogin .input-group { 
  border-radius: 0.3rem;
  -webkit-box-shadow: 2px 3px 8px 1px #aeaeae;
  -moz-box-shadow: 2px 3px 8px 1px #aeaeae;
  -o-box-shadow: 2px 3px 8px 1px #aeaeae;
  box-shadow: 2px 3px 8px 1px #aeaeae;
}

#accedi_btn {
  background-color: #1f4b6b;
  border: 0;
  color: white;
  padding-top: 8px;
  padding-bottom: 8px;
  font-weight: 500;
  font-size: 1.4em;
  border-radius: 0.3rem;
  -webkit-box-shadow: 2px 3px 8px 1px #aeaeae;
  -moz-box-shadow: 2px 3px 8px 1px #aeaeae;
  -o-box-shadow: 2px 3px 8px 1px #aeaeae;
  box-shadow: 2px 3px 8px 1px #aeaeae;
}
#accedi_btn:hover {
  background: #EF7918;
}
.container {
  max-width: 1320px !important;
}
.titolo_sezione {
  font-weight: 700;
  font-size: xx-large;
  text-transform: uppercase;
}

// .c-wrapper{
//   flex-grow: initial !important;
// }
.c-body {
  flex-grow: initial !important;
}

/* LOADER*/
.attendere {
  width: 10rem !important;
}
.lds-grid {
  display: inline-block;
  position: relative;
  width: 80px;
  height: 80px;
}
.lds-grid div {
  position: absolute;
  width: 16px;
  height: 16px;
  border-radius: 50%;
  background: #01295c;
  animation: lds-grid 1.2s linear infinite;
}
.lds-grid div:nth-child(1) {
  top: 8px;
  left: 8px;
  animation-delay: 0s;
}
.lds-grid div:nth-child(2) {
  top: 8px;
  left: 32px;
  animation-delay: -0.4s;
}
.lds-grid div:nth-child(3) {
  top: 8px;
  left: 56px;
  animation-delay: -0.8s;
}
.lds-grid div:nth-child(4) {
  top: 32px;
  left: 8px;
  animation-delay: -0.4s;
}
.lds-grid div:nth-child(5) {
  top: 32px;
  left: 32px;
  animation-delay: -0.8s;
  background: #EF7918 ;
}
.lds-grid div:nth-child(6) {
  top: 32px;
  left: 56px;
  animation-delay: -1.2s;
}
.lds-grid div:nth-child(7) {
  top: 56px;
  left: 8px;
  animation-delay: -0.8s;
}
.lds-grid div:nth-child(8) {
  top: 56px;
  left: 32px;
  animation-delay: -1.2s;
}
.lds-grid div:nth-child(9) {
  top: 56px;
  left: 56px;
  animation-delay: -1.6s;
}
@media only screen and (max-width: 768px) {
  .login_sx{
    opacity: 30% !important;
  }
  .login_dx{
    opacity: 30% !important;
  }
}

@keyframes lds-grid {
  0%,
  100% {
    opacity: 1;
  }
  50% {
    opacity: 0.5;
  }
}
.content {
  margin-bottom: 0px !important;
}
</style>
