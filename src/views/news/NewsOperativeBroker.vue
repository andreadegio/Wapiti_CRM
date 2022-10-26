<template id="newsBroker">
  <iframe
    id="news_frame"
    :src="
      'https://broker.abybroker.it/ea2019/RicercaNotizieUO_NoBarre.aspx?userID=' +
      userID +
      '&anagraficaID=' +
      anagraficaID +
      '&unitaoperativaID=' +
      unitaoperativaID
    "
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
  name: "NewsOperativeBroker",
  data: function () {
    return {
      windowHeight: 0,
      userID: localStorage.getItem("userID"),
      anagraficaID: localStorage.getItem("anagraficaID"),
      unitaoperativaID: localStorage.getItem("unitaoperativaID"),
    };
  },
  methods: {
    getWindowHeight(event) {
      var head = document.getElementById("header").offsetHeight - 5;
      var foot = document.getElementById("footer").offsetHeight;
      var space = window.innerHeight;
      var spazio = space - (head + foot);
      document
        .getElementById("news_frame")
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
#news_frame {
  padding-top: 10px;
}
</style>