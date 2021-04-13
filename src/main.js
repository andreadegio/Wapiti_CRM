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
  clamp = clamp || "...";
  var node = document.createElement("div");
  node.innerHTML = text;
  var content = node.textContent;
  return content.length > length ? content.slice(0, length) + clamp : content;
};
Vue.filter("truncate", filter);
//#endregion


Vue.mixin({
  methods:{
    // async chisono(spot) {
    //   //  chiamo il chisono per recuperare i dati dell'utente loggato
    //   console.log("chiamata al chisono da " + spot);
    //   var config = {
    //     method: "post",
    //     url: config_data.servizi_broker + "chisono",
    //     headers: {
    //       utente: localStorage.getItem("user"),
    //       password: localStorage.getItem("pwd"),
    //     },
    //   };

    //   const risposta_chisono = await axios(config)
    //     .then(function (response) {
    //       alert(JSON.stringify(response.data));
    //       console.log("risposta al servizio chisono");
    //       localStorage.setItem("chisono_data", JSON.stringify(response.data));
    //       localStorage.setItem("userID", response.data.idUtente);
    //       localStorage.setItem("anagraficaID", response.data.idAnagrafica);
    //       localStorage.setItem(
    //         "unitaoperativaID",
    //         response.data.idUnitaOperativa
    //       );
          
    //     })
    //     .catch(function (error) {
    //       console.log(error);
    //     });
    //     alert (JSON.stringify(risposta_chisono.data));
    //       return risposta_chisono.data;
    // },
  }
})

// Vue.mixin({
//   methods: {
    
//     async chisono(spot) {
//       //  chiamo il chisono per recuperare i dati dell'utente loggato
//       console.log("chiamata al chisono da " + spot);
//       var config = {
//         method: "post",
//         url: config_data.servizi_broker + "chisono",
//         headers: {
//           utente: localStorage.getItem("user"),
//           password: localStorage.getItem("pwd"),
//         },
//       };

//       await axios(config)
//         .then(function(response) {
//           console.log("risposta al servizio chisono");
//           localStorage.setItem("chisono_data", JSON.stringify(response.data));
//           localStorage.setItem("userID", response.data.idUtente);
//           localStorage.setItem("anagraficaID", response.data.idAnagrafica);
//           localStorage.setItem(
//             "unitaoperativaID",
//             response.data.idUnitaOperativa
//           );
//           // return response.data;
//           console.log("utente " + localStorage.getItem("userID"));

//           let chiamata_news = [];
//           let news_operative = [];

//           var config = {
//             method: "post",
//             url: config_data.servizi_broker + "LatestNewsOperative",
//             headers: {
//               userID: localStorage.getItem("userID"),
//               anagraficaID: localStorage.getItem("anagraficaID"),
//               unitaoperativaID: localStorage.getItem("unitaoperativaID"),
//             },
//           };
//           console.log(
//             "parametri richiesta news: " +
//               localStorage.getItem("userID") +
//               " " +
//               localStorage.getItem("anagraficaID")
//           );
//           axios(config)
//             .then(function(response) {
//               console.log("risposta api news" + JSON.stringify(response.data));
//               chiamata_news = response.data;
//               news_operative = chiamata_news.map((item, id) => {
//                 return { ...item, id };
//               });
//               localStorage.setItem(
//                 "news_operative",
//                 JSON.stringify(news_operative)
//               );
//             })
//             .catch(function(error) {
//               console.log(error);
//             });
//         })
//         .catch(function(error) {
//           console.log(error);
//         });
//     },
//   },
// });

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
