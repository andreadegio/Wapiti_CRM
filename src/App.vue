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
@import "assets/css/global_purged.css";
@import "assets/css/darkmode_purged.css";
</style>
