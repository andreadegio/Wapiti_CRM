<template >
  <div v-show="show_async != 0">
    <CRow>
      <CCol md="1"> </CCol>
      <CCol md="10">
        <div style="text-align: center; padding-bottom: 15px">
          <h1 class="display-3" style="color: #1e2f56; font-weight: 900">
            Benvenuto in
            <img class="login-img" src="img/logo_abyway.png" height="50px" />
          </h1>
          <div id="scritta"><hr class="mt-4" /></div>
        </div>
      </CCol>
      <CCol md="1"> </CCol>
    </CRow>
    <CRow>
      <CCol md="1"> </CCol>
      <CCol id="pulsanti_aree" align-horizontal="center" md="2" >
        <PulsantiAree />
      </CCol>
      <CCol md="4">
        <NewsOperative class="h-100" :key="triggerNews" />
      </CCol>
      <CCol md="4">
        <NewsMondo class="h-100" :key="triggerNews" />
      </CCol>
      <CCol md="1"> </CCol>
    </CRow>
    <CRow align-horizontal="center">
      <CCol md="1"> </CCol>
      <CCol sm="10" md="10">
        <div class="row">
          <div class="col-sm">
            <CCardLink :href="config_data.broker_veicoli" target="_self">
              <CCard
                class="text-center elevation-6 portali-btn"
                body-wrapper
                style="
                  height: 200px;
                  background-image: url('img/buttons/auto.png');
                  background-position: center;
                  z-index: 0;
                  background-size: cover;
                "
              ><CCardTitle>
          
                <h1
                  style="
                    color: white;
                    font-weight: 800;
                    text-shadow: 1px 1px midnightblue;
                    font-size: 2vw;
                    margin-bottom: 0 !important;
                    margin-top: 10%;
                  "
                >
                  ASSICURAZIONI
                </h1>
        </CCardTitle>
              </CCard>
            </CCardLink>
          </div>
          <!-- <div class="col-sm"> -->
          <!-- <CCardLink href="#" target="_self">
              <CCard
                class="text-center elevation-6 portali-btn"
                body-wrapper
                style="
                  height: 200px;
                  background-image: url('img/buttons/rami.png');
                  background-position: center;
                  z-index: 0;
                "
              
              >
                <h1
                  style="
                    color: white;
                    font-weight: 800;
                    text-shadow: 1px 1px midnightblue;
                    font-size: 2vw;
                    margin-bottom: 0 !important;
                    margin-top: 10%;
                  "
                >
                  RAMI ASSICURATIVI
                </h1>
              </CCard>
            </CCardLink> -->
          <!-- </div> -->
          <div class="col-sm">
            <CCardLink to="Comingsoon_gas" target="_self">
              <CCard
                class="text-center elevation-6 portali-btn"
                body-wrapper
                style="
                  height: 200px;
                  background-image: url('img/buttons/energy.png');
                  background-position: center;
                  z-index: 0;
                  background-size: cover;
                "
              >
                <h1
                  style="
                    color: white;
                    font-weight: 800;
                    text-shadow: 1px 1px midnightblue;
                    font-size: 2vw;
                    margin-bottom: 0 !important;
                    margin-top: 10%;
                  "
                >
                  GAS E LUCE
                </h1>
              </CCard>
            </CCardLink>
          </div>
        </div>
      </CCol>
      <CCol md="1"> </CCol>
    </CRow>
  </div>
</template>

<script>
import axios from "axios";
import NewsMondo from "./../containers/NewsMondo";
import NewsOperative from "./../containers/NewsOperative";
import PulsantiAree from "./../containers/PulsantiAree";
import store from "./../store";
import { config_data } from "../../public/config/config";

export default {
  name: "Dashboard",
  components: {
    NewsMondo,
    NewsOperative,
    PulsantiAree,
  },
  data() {
    return {
      newsModal: false,
      userID: "",
      anagraficaID: "",
      unitaoperativaID: "",
      config_data,
      show_async: 0,
      news_operative: null,
      triggerNews: 0,
      news_mondo: null,
    };
  },

  beforeCreate() {},
  created() {
    if (this.$route.query.auth == "1") {
      store.commit("user_login");
      this.$router.push("dashboard");
    }
    if (
      localStorage.getItem("utente") !== "ok" &&
      this.$route.query.auth !== "1"
    ) {
      this.$router.push("login");
    }
    this.chisono();
  },
  mounted() {},

  methods: {
    async chisono() {
      //  chiamo il chisono per recuperare i dati dell'utente loggato
      var config = {
        method: "post",
        url: config_data.servizi_broker + "chisono",
        headers: {
          utente: localStorage.getItem("user"),
          password: localStorage.getItem("pwd"),
        },
      };

      const risposta_chisono = await axios(config);

      // alert(JSON.stringify(risposta_chisono.data));
      localStorage.setItem(
        "chisono_data",
        JSON.stringify(risposta_chisono.data)
      );
      localStorage.setItem("userID", risposta_chisono.data.idUtente);
      localStorage.setItem("anagraficaID", risposta_chisono.data.idAnagrafica);
      localStorage.setItem(
        "unitaoperativaID",
        risposta_chisono.data.idUnitaOperativa
      );

      this.triggerNews += 1;
      this.latest_news(); // ultime news operative
      this.load_news(); // ultime news mondo
    },

    async latest_news() {
      // CARICO LE ULTIME 3 NEWS OPERATIVE PER LA HOME
      var config = {
        method: "post",
        url: config_data.servizi_broker + "LatestNewsOperative",
        headers: {
          userID: localStorage.getItem("userID"),
          anagraficaID: localStorage.getItem("anagraficaID"),
          unitaoperativaID: localStorage.getItem("unitaoperativaID"),
        },
      };
      const risposta_latestNews = await axios(config);
      this.triggerNews += 1;
      this.news_operative = risposta_latestNews.data.map((item, id) => {
        return { ...item, id };
      });
      localStorage.setItem(
        "news_operative",
        JSON.stringify(this.news_operative)
      );

      this.show_async = 1;
      this.triggerNews += 1;
    },

    async load_news() {
      // console.log("caricamento news mondo.........")
      // CARICO LE ULTIME 3 NEWS MONDO PER LA HOME
      var chiamata_news = [];
      await axios
        .get(config_data.api_url + "listanewshome")
        .then((response) => {
          chiamata_news = response.data;
        });
      this.news_mondo = chiamata_news.map((item, id) => {
        return { ...item, id };
      });
      localStorage.setItem("news_mondo", JSON.stringify(this.news_mondo));
      // console.log(this.news_mondo);

      this.show_async = 1;
      this.triggerNews += 1;
    },
  },
};
</script>
<style scoped>
/* @import url("https://fonts.googleapis.com/css2?family=Indie+Flower&display=swap"); */
@font-face {
  font-family: FreeStyle;
  src: url("/img/fonts/FREESCPT.TTF");
}
.elevation-6 {
  box-shadow: 0 3px 5px -1px rgba(0, 0, 0, 0.2),
    0 6px 10px 0 rgba(0, 0, 0, 0.14), 0 1px 18px 0 rgba(0, 0, 0, 0.12) !important;
}
.elevation-6:hover {
  box-shadow: 0 3px 5px -1px rgba(0, 0, 0, 0.2),
    0 6px 10px 0 rgba(0, 0, 0, 0.14), 0 1px 18px 0 rgba(21, 7, 141, 0.12) !important;
  border-color: midnightblue;
}
.portali-btn {
  -webkit-filter: grayscale(0%); /* Safari 6.0 - 9.0 */
  filter: grayscale(0%);
}
.portali-btn:hover {
  -webkit-filter: grayscale(100%); /* Safari 6.0 - 9.0 */
  filter: grayscale(100%);
}
hr {
  background-color: #c6c6c6;
  border-width: 0;
  color: #999;
  height: 1px;
  line-height: 0;
  margin: 0.5em 0;
  text-align: center;
}
hr:after {
  content: "La nuova piattaforma operativa";
  font-size: 2.9em;
  position: relative;
  left: -0.5em;
  /* font-family: "Indie Flower", cursive; */
  font-family: "FreeStyle", cursive;

  background-color: #ebedef;
  padding-left: 1em;
  padding-right: 1em;
}
#pulsanti_aree {
  display: flex;
  justify-content: center;
}
</style>
