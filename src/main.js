import "core-js/stable";
import Vue from "vue";
import App from "./App";
import router from "./router";
import CoreuiVue from "@coreui/vue";
import { iconsSet as icons, iconsSet } from "./assets/icons/icons.js";
import store from "./store";
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
import VueAnalytics from "vue-analytics";
import VueSimpleAlert from "vue-simple-alert";
import VueFileAgent from "vue-file-agent";
import moment from "moment";
// import VueFileAgentStyles from 'vue-file-agent/dist/vue-file-agent.css';

library.add(faUserSecret);
Vue.component("font-awesome-icon", FontAwesomeIcon);
Vue.config.performance = true;
Vue.use(CoreuiVue, vuetify);

Vue.use(VueAnalytics, {
  id: "UA-197949487-1",
  router,
});
Vue.use(VueFileAgent);

Vue.use(VueSimpleAlert);

const axiosFileUploader = axios.create({
  baseURL: "https://www.abyway.it/API",
});

// const axiosFileUploader = axios.create({
//   baseURL: "https://abyway-staging.navert.cloud/API",
// });



Vue.use(VueFormulate, {
  uploader: axiosFileUploader,
  uploadUrl: "",
});

Vue.use(iconsSet);

Vue.prototype.$log = console.log.bind(console);

//#region FILTRO PER RIDURRE LA LUNGHEZZA DEI TESTI ED AGGIUNGERE " [...]"
var filter = function(text, length, clamp) {
  clamp = clamp || " [...]";
  var node = document.createElement("div");
  node.innerHTML = text;
  var content = node.innerHTML;
  // console.log(node.innerHTML);
  return content.length > length ? content.slice(0, length) + clamp : content;
};
Vue.filter("truncate", filter);
//#endregion

//#region FILTRO PER LA FORMATTAZIONE DELLA DATA PARTENDO DA QUELLA SU DB
Vue.filter("formatDate", function(value) {
  if (value) {
    moment.locale("it");
    return moment(String(value)).format("DD MMMM yyyy");
  }
});
//#endregion

Vue.mixin({
  methods: {},
});

fetch("/config/config.json")
  .then((response) =>response.json())
  .then((custom_json) => {
    Vue.prototype.$custom_json = custom_json;
    // console.log(custom_json.ep_api.secondo);
    // console.log('main');

    new Vue({
      el: "#app",
      router,
      store,
      icons,
      vuetify,
      axios,
      VueAnalytics,

      beforeDestroy() {},

      template: "<App/>",

      components: {
        App,
      },
    });
  })
  .catch(error=>console.log("--- " + error));
