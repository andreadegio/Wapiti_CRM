import "core-js/stable";
import Vue from "vue";
import App from "./App";
import router from "./router";
import CoreuiVue from "@coreui/vue";
import { iconsSet as icons, iconsSet } from "./assets/icons/icons.js";
import store from "./store";
import AOS from "aos";
import "aos/dist/aos.css";
import vuetify from "./plugins/vuetify";
import VueFormulate from "@braid/vue-formulate";
import "../node_modules/@braid/vue-formulate/themes/snow/snow.scss";
import axios from "../node_modules/axios";
import "@fortawesome/fontawesome-free/css/all.css";
import "@fortawesome/fontawesome-free/js/all.js";
import { library } from "@fortawesome/fontawesome-svg-core";
import { faUserSecret } from "@fortawesome/free-solid-svg-icons";
import { FontAwesomeIcon } from "@fortawesome/vue-fontawesome";
import "regenerator-runtime/runtime";
// import { config_data } from "../public/config/config";

library.add(faUserSecret);
Vue.component("font-awesome-icon", FontAwesomeIcon);
Vue.config.performance = true;
Vue.use(CoreuiVue, vuetify);

const axiosFileUploader = axios.create({
  baseURL: "https://www.abyway.it/API",
});

Vue.use(VueFormulate, {
  uploader: axiosFileUploader,
  uploadUrl: "",
});

Vue.use(axios);
Vue.use(iconsSet);
Vue.prototype.$log = console.log.bind(console);

//#region FILTRO PER RIDURRE LA LUNGHEZZA DEI TESTI ED AGGIUNGERE "..."
var filter = function(text, length, clamp) {
  clamp = clamp || " [...]";
  var node = document.createElement("div");
  node.innerHTML = text;
  var content = node.textContent;
  return content.length > length ? content.slice(0, length) + clamp : content;
};
Vue.filter("truncate", filter);
//#endregion


Vue.mixin({
  methods:{
  }
})

new Vue({
  el: "#app",
  router,
  store,
  icons,
  vuetify,
  axios,

  created() {
    AOS.init({ disable: "phone" });
  },
  beforeDestroy() {},

  template: "<App/>",

  components: {
    App,
  },
});
