<template>
  <div class="c-app">
    <CWrapper>
      <TheHeader id="header"/>
      <div class="c-body">
        <main class="c-main">
          <CContainer fluid class="new_fluid" style="">
            <transition name="fade" mode="out-in">
              <router-view :key="$route.path"></router-view>
            </transition>
          </CContainer>
        </main>
      </div>
      <TheFooter id="footer" v-show="this.$route.path == '/dashboard'"  />
    </CWrapper>
  </div>
</template>

<script>
import TheHeader from "./TheHeader";
import TheFooter from "./TheFooter";

export default {
  name: "TheContainer",
  components: {
    TheHeader,
    TheFooter,
  },
};
</script>

<style scoped>
html,
body {
  height: 100%;
}
.new_fluid {
  padding-left: 0;
  padding-right: 0;
  height: 100%;
  min-height: 100%;
  height: auto !important; /* cross-browser */
  height: 100%; /* cross-browser */
}
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.3s;
}
.fade-enter,
.fade-leave-to {
  opacity: 0;
}
</style>
