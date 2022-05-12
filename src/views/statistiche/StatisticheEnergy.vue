<template id="st">
  <iframe
    id="stats_frame"
    :src="$custom_json.broker_statistiche + userID"
    
    class="frame-stats"
    width="100%"
    frameborder="0"
    :height="windowHeight"
  >
  </iframe>
  <!-- </div> -->
</template>
<script>

export default {
  name: "Statistiche",
  data: function () {
    return {
      windowHeight: 0,
      userID: localStorage.getItem("userID"),
    };
  },
  methods: {
    // eslint-disable-next-line no-unused-vars
    getWindowHeight(event) {
      var head = document.getElementById("header").offsetHeight - 5;
      var foot = document.getElementById("footer").offsetHeight;
      var space = window.innerHeight;
      var spazio = space - (head + foot);
      document
        .getElementById("stats_frame")
        .setAttribute("style", "height:" + spazio + "px !important;");
      this.windowHeight = spazio;
    },
  },
  mounted() {
    this.$nextTick(function () {
      window.addEventListener("resize", this.getWindowHeight);
      this.getWindowHeight();
      document.documentElement.style.overflow = "hidden";
    });
  },
  beforeDestroy() {
    window.removeEventListener("resize", this.getWindowHeight);
    document.documentElement.style.overflow = "auto";
  },
};
</script>
<style scoped>
.row-stats {
  padding-left: 0;
  padding-right: 0;

  min-height: 100%;
  height: auto !important; /* cross-browser */
  height: 100%; /* cross-browser */
}
#stats_frame{
  /* margin-top: -55px !important; */
}
</style>