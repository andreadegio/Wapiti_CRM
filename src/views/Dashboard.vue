<template >
  <div v-if="show_async == 2">
    <CToaster
      v-for="(avviso, index) in avvisiToast"
      :key="index"
      :autohide="5000"
      position="top-center"
    >
      <template>
        <CToast color="info" :show="true" :header="avviso.Titolo">
          <p v-html="avviso.Messaggio"></p>
        </CToast>
      </template>
    </CToaster>
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
      <CCol id="pulsanti_aree" align-horizontal="center" md="2">
        <PulsantiAree />
      </CCol>
      <CCol md="4">
        <NewsOperative
          class="h-100"
          :operativeParent="news_operative"
          @reload_operative="reload_operative()"
          :key="triggerNews"
        />
      </CCol>
      <CCol md="4">
        <NewsMondo
          class="h-100"
          :newsParent="news_mondo"
          :key="triggerNews"
          @reload_mondo="reload_mondo()"
        />
      </CCol>
      <CCol md="1"> </CCol>
    </CRow>
    <CRow align-horizontal="center">
      <CCol md="1"> </CCol>
      <CCol sm="10" md="10">
        <div class="row">
          <div class="col-sm">
            <CCardLink :href="$custom_json.broker_veicoli" target="_self">
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
                  <span class="portali">Piattaforma</span>
                  <h1 class="pulsante_portali">ASSICURAZIONI</h1>
                </CCardTitle>
              </CCard>
            </CCardLink>
          </div>
          <!-- <div v-if="isRami && entra_rami" class="col-sm">
            <CCardLink :href="urlRami" target="_blank">
              <CCard
                class="text-center elevation-6 portali-btn"
                body-wrapper
                style="
                  height: 200px;
                  background-image: url('img/buttons/rami.png');
                  background-position: center;
                  z-index: 0;
                  background-size: cover;
                "
                ><CCardTitle>
                  <span class="portali">Piattaforma</span>
                  <h1 class="pulsante_portali">RC PROFESSIONALI</h1>
                </CCardTitle>
              </CCard>
            </CCardLink>
          </div> -->
          <div v-if="isRami && entra_rami" class="col-sm">
            <CCardLink to="Comingsoon_rami" target="_self">
              <CCard
                class="text-center elevation-6 portali-btn"
                body-wrapper
                style="
                  height: 200px;
                  background-image: url('img/buttons/rami.png');
                  background-position: center;
                  z-index: 0;
                  background-size: cover;
                "
                ><CCardTitle>
                  <span class="portali">Piattaforma</span>
                  <h1 class="pulsante_portali">PROFESSIONISTI</h1>
                </CCardTitle>
              </CCard>
            </CCardLink>
          </div>
          <div v-else class="col-sm">
            <CCardLink to="Comingsoon_rami2" target="_self">
              <CCard
                class="text-center elevation-6 portali-btn"
                body-wrapper
                style="
                  height: 200px;
                  background-image: url('img/buttons/rami.png');
                  background-position: center;
                  z-index: 0;
                  background-size: cover;
                "
                ><CCardTitle>
                  <span class="portali">Piattaforma</span>
                  <h1 class="pulsante_portali">PROFESSIONISTI</h1>
                </CCardTitle>
              </CCard>
            </CCardLink>
          </div>
          <div class="col-sm" v-if="!isEnergy">
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
                ><CCardTitle>
                  <span class="portali">Piattaforma</span>
                  <h1 class="pulsante_portali">GAS E LUCE</h1>
                </CCardTitle>
              </CCard>
            </CCardLink>
          </div>
          <div class="col-sm" v-else>
            <CCardLink :href="$custom_json.urlEnergy" target="_blank">
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
                ><CCardTitle>
                  <span class="portali">Piattaforma</span>
                  <h1 class="pulsante_portali">GAS E LUCE</h1>
                </CCardTitle>
              </CCard>
            </CCardLink>
          </div>
        </div>
      </CCol>
      <CCol md="1"> </CCol>
    </CRow>
  </div>
  <div v-else style="position: fixed; top: 50%; left: 50%" class="my-5">
    <div class="lds-grid">
      <div></div>
      <div></div>
      <div></div>
      <div></div>
      <div></div>
      <div></div>
      <div></div>
      <div></div>
      <div></div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import NewsMondo from "./../containers/NewsMondo";
import NewsOperative from "./../containers/NewsOperative";
import PulsantiAree from "./../containers/PulsantiAree";
import store from "./../store";

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
      unitaOperativaTipoID: "",
      show_async: 0,
      news_operative: null,
      triggerNews: 0,
      news_mondo: null,
      urlRami: localStorage.getItem("urlRami"),
      isEnergy: "",
      isRami: false,
      avvisiToast: null,
      entra_rami: false,
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
      return;
    }
    this.chisono();
  },
  mounted() {
    this.get_avvisiToast();
  },

  methods: {
    async get_avvisiToast() {
      // Chiamata per recuperare l'array dei messaggi Toast

      try {
        await axios
          .post(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.ep_api.get_avvisiToast
          )
          .then((response) => {
            this.avvisiToast = response.data;
          });
      } catch (error) {
        console.log("errore: " + error);
      }
    },

    async chisono() {
      const _MS_PER_DAY = 1000 * 60 * 60 * 24;
      //data salvata
      const datasalvata = new Date(localStorage.getItem("lastLogin"));
      const dataoggi = new Date();
      //data di oggi
      const data1 = Date.UTC(
        dataoggi.getFullYear(),
        dataoggi.getMonth(),
        dataoggi.getDate()
      );
      const data2 = Date.UTC(
        datasalvata.getFullYear(),
        datasalvata.getMonth(),
        datasalvata.getDate()
      );
      const differenza = Math.floor((data1 - data2) / _MS_PER_DAY);

      // console.log(
      //   "data di oggi = " +
      //     data1 +
      //     " data storage= " +
      //     data2 +
      //     " differenza= " +
      //     differenza
      // );
      if (differenza != 0) {
        console.log("devo rifare il login - sessione scaduta");
        this.$router.push("login");
        return;
      }
      //  chiamo il chisono per recuperare i dati dell'utente loggato
      // prima verifico di non averli già nello storage, altrimenti effettuo la chiamata
      if (localStorage.getItem("chisono_data") == null) {
        try {
          var config = {
            method: "post",
            url: this.$custom_json.servizi_broker + "chisono",
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
          localStorage.setItem(
            "anagraficaID",
            risposta_chisono.data.idAnagrafica
          );
          localStorage.setItem(
            "unitaoperativaID",
            risposta_chisono.data.idUnitaOperativa
          );
          // controllo se sono abilitato all'utilizzo del portale rami
          if (risposta_chisono.data.Abilitato_Rami) {
            //Imposto il parametro isRami a true in modo da visualizzare il pulsante
            this.isRami = true;
            // se sono abilitato chiamo il servizio per recuperare l'url da inserire nel pulsante
            try {
              var param = {
                id_persona_operativa: risposta_chisono.data.idUtente,
              };
              await axios
                .post(
                  this.$custom_json.base_url +
                    this.$custom_json.api_url +
                    this.$custom_json.ep_api.getUrlRami,
                  param
                )
                .then((response) => {
                  localStorage.setItem("urlRami", response.data);
                  this.urlRami = response.data;
                });
            } catch (error) {
              console.log("impossibile recuperare jwt rami " + error);
            }
          }
          this.isEnergy = JSON.parse(
            localStorage.getItem("chisono_data")
          ).Abilitato_Energy;
          this.unitaOperativaTipoID = JSON.parse(
            localStorage.getItem("chisono_data")
          ).UnitaOperativa_Tipo_ID;
        } catch (error) {
          console.log("errore");
          this.$router.push("login");
        }
      }
      this.isEnergy = JSON.parse(
        localStorage.getItem("chisono_data")
      ).Abilitato_Energy;
      this.unitaOperativaTipoID = JSON.parse(
        localStorage.getItem("chisono_data")
      ).UnitaOperativa_Tipo_ID;
      //se sono già autenticato e non ho effettuato il login da più di un giorno, controllo il localstorage
      this.isRami = JSON.parse(
        localStorage.getItem("chisono_data")
      ).Abilitato_Rami;
      // this.triggerNews += 1;
      this.latest_news(); // ultime news operative
      this.load_news(); // ultime news mondo
      // Controllo che tipo di unità operativa sono per visualizzare un messaggio diverso e per abilitare l'accesso alla piattaforma rami
      if (
        this.unitaOperativaTipoID == 7 ||
        this.unitaOperativaTipoID == 8 ||
        this.unitaOperativaTipoID == 10
      ) {
        this.entra_rami = true;
      }
    },

    // CARICO LE ULTIME 3 NEWS OPERATIVE PER LA HOME
    async latest_news() {
      try {
        var config = {
          method: "post",
          url: this.$custom_json.servizi_broker + "LatestNewsOperative", //non recupero l'end-point dal config perchè genera cors error
          headers: {
            userID: localStorage.getItem("userID"),
            anagraficaID: localStorage.getItem("anagraficaID"),
            unitaoperativaID: localStorage.getItem("unitaoperativaID"),
          },
        };
        const risposta_latestNews = await axios(config);
        // this.triggerNews += 1;
        this.news_operative = risposta_latestNews.data.map((item, id) => {
          return { ...item, id };
        });
        localStorage.setItem(
          "news_operative",
          JSON.stringify(this.news_operative)
        );
      } catch (error) {
        //se non ricevo una risposta valida allora guardo se nello storage c'è un salvataggio dei dati e recupero
        // provvisoriamente quelli

        if (localStorage.getItem("news_operative")) {
          this.news_operative = JSON.parse(
            localStorage.getItem("news_operative")
          );
        } else {
          // in caso di chiamata fallita e contenuto non presente nello storage tento una seconda volta
          try {
            const risposta_latestNews = await axios(config);

            this.news_operative = risposta_latestNews.data.map((item, id) => {
              return { ...item, id };
            });
            localStorage.setItem(
              "news_operative",
              JSON.stringify(this.news_operative)
            );
          } catch (error) {
            // se ricevo il secondo errore allora mosto la sezione vuota
            this.news_operative = "";
          }
        }
      }
      this.show_async++;
      this.triggerNews += 1;
    },

    // Funzione che richiamo in caso di mancato caricamento delle news al primo accesso
    async reload_operative() {
      // alert("ricarico");
      //provo la chiamata all'end-point se l'esito è OK assegno il valore e scrivo nello storage
      try {
        var config = {
          method: "post",
          url: this.$custom_json.servizi_broker + "LatestNewsOperative", //non recupero l'end-point dal config perchè genera cors error
          headers: {
            userID: localStorage.getItem("userID"),
            anagraficaID: localStorage.getItem("anagraficaID"),
            unitaoperativaID: localStorage.getItem("unitaoperativaID"),
          },
        };
        const risposta_latestNews = await axios(config);

        this.news_operative = risposta_latestNews.data.map((item, id) => {
          return { ...item, id };
        });
        localStorage.setItem(
          "news_operative",
          JSON.stringify(this.news_operative)
        );
        // alert(this.news_operative);
      } catch (error) {
        //se non ricevo una risposta valida allora guardo se nello storage c'è un salvataggio dei dati e recupero
        // provvisoriamente quelli
        if (localStorage.getItem("news_operative") != null) {
          this.news_mondo = JSON.parse(localStorage.getItem("news_operative"));
        } else {
          // in caso di chiamata fallita e contenuto non presente nello storage tento una seconda volta
          try {
            const risposta_latestNews = await axios(config);

            this.news_operative = risposta_latestNews.data.map((item, id) => {
              return { ...item, id };
            });
            localStorage.setItem(
              "news_operative",
              JSON.stringify(this.news_operative)
            );
          } catch (error) {
            // se ricevo il secondo errore allora mosto la sezione vuota
            this.news_operative = "";
          }
        }
      }
    },

    // CARICO LE ULTIME 3 NEWS MONDO PER LA HOME
    async load_news() {
      var chiamata_news = [];
      try {
        await axios
          .get(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.ep_api.listanews_home
          )
          .then((response) => {
            chiamata_news = response.data;
          });
        this.news_mondo = chiamata_news.map((item, id) => {
          return { ...item, id };
        });

        localStorage.setItem("news_mondo", JSON.stringify(this.news_mondo));
      } catch (error) {
        // alert(JSON.parse(localStorage.getItem("news_mondo")));
        if (localStorage.getItem("news_mondo") != null) {
          this.news_mondo = JSON.parse(localStorage.getItem("news_mondo"));
        } else {
          // in caso di chiamata fallita e contenuto non presente nello storage tento una seconda volta
          try {
            await axios
              .get(
                this.$custom_json.base_url +
                  this.$custom_json.api_url +
                  this.$custom_json.ep_api.listanews_home
              )
              .then((response) => {
                chiamata_news = response.data;
              });
            this.news_mondo = chiamata_news.map((item, id) => {
              return { ...item, id };
            });

            localStorage.setItem("news_mondo", JSON.stringify(this.news_mondo));
          } catch (error) {
            // se ricevo il secondo errore allora mosto la sezione vuota
            this.news_mondo = "";
          }
        }
      }

      this.show_async++;
      this.triggerNews += 1;
    },

    // Funzione che richiamo in caso di mancato caricamento delle news al primo accesso
    async reload_mondo() {
      // CARICO LE ULTIME 3 NEWS MONDO PER LA HOME
      var chiamata_news = [];
      //provo la chiamata all'end-point se l'esito è OK assegno il valore e scrivo nello storage
      try {
        await axios
          .get(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              "listanewshome"
          )
          .then((response) => {
            chiamata_news = response.data;
          });
        this.news_mondo = chiamata_news.map((item, id) => {
          return { ...item, id };
        });
        localStorage.setItem("news_mondo", JSON.stringify(this.news_mondo));
      } catch (error) {
        //se non ricevo una risposta valida allora guardo se nello storage c'è un salvataggio dei dati e recupero
        // provvisoriamente quelli
        if (localStorage.getItem("news_mondo") != null) {
          this.news_mondo = JSON.parse(localStorage.getItem("news_mondo"));
        } else {
          // in caso di chiamata fallita e contenuto non presente nello storage tento una seconda volta
          try {
            await axios
              .get(
                this.$custom_json.base_url +
                  this.$custom_json.api_url +
                  this.$custom_json.ep_api.listanews_home
              )
              .then((response) => {
                chiamata_news = response.data;
              });
            this.news_mondo = chiamata_news.map((item, id) => {
              return { ...item, id };
            });

            localStorage.setItem("news_mondo", JSON.stringify(this.news_mondo));
          } catch (error) {
            // se ricevo il secondo errore allora mosto la sezione vuota
            this.news_mondo = "";
          }
        }
      }
    },
  },
};
</script>
<style scoped>
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
  font-size: 2rem;
  position: relative;
  left: -0.5em;
  /* font-family: "Indie Flower", cursive; */
  font-family: "FreeStyle", cursive;

  background-color: #ebedef;
  padding-left: 1em;
  padding-right: 1em;
}
#pulsanti_aree {
  display: grid;
  justify-content: center;
}

.pulsante_portali {
  color: white;
  font-weight: 800;
  text-shadow: 1px 1px midnightblue;
  font-size: 2.5rem;
  margin-bottom: 0 !important;
  margin-top: 5%;
}
.portali {
  color: white;
  text-shadow: 1px 1px midnightblue;
  font-size: 1.5rem;
  margin-bottom: 0 !important;
}
</style>
