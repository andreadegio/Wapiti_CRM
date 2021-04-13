<template>
  <router-view
  id="new_home"></router-view>
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
  background-color:#e47373 !important;
  margin-right: 1em;
}


</style>
