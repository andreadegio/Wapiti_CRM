<template >
  <div v-if="show_async == 3">
    <CToaster
      id="messaggi_toast"
      v-for="(avviso, index) in avvisiToast"
      :key="index"
      position="top-center"
      :autohide="5000"
    >
      <template>
        <CToast color="info" :show="true">
          <template #header>
            <div class="titolo_toast" v-html="avviso.Titolo"></div>
          </template>
          <p class="messaggio_toast" v-html="avviso.Messaggio"></p>
        </CToast>
      </template>
    </CToaster>

    <CRow class="pt-3">
      <CCol md="1"> </CCol>
      <CCol sm="10" md="10">
        <div class="row">
          <div class="col-sm p-0">
            <CCol class="h-100">
              <AreaManager />
            </CCol>
          </div>
          <div class="col-sm p-0">
            <CCol class="h-100">
              <contattiAby :recapitiParent="recapiti" class="h-100" />
            </CCol>
          </div>
          <div class="col-sm p-0">
            <CCol class="h-100">
              <NewsMondo
                class="h-100"
                :newsParent="news_mondo"
                :key="triggerNews"
                @reload_mondo="reload_mondo()"
              />
            </CCol>
          </div>
        </div>
      </CCol>

      <CCol md="1"> </CCol>
    </CRow>
    <CRow align-horizontal="center">
      <CCol md="1"> </CCol>
      <CCol sm="10" md="10">
        <div class="row">
          <div class="col-sm">
            <CCardLink target="_self" @click="conta_accesso('broker')">
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
          <div v-if="isRami" class="col-sm">
            <CCardLink @click="conta_accesso('rami')" target="_self">
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
            <CCardLink @click="conta_accesso('energy')">
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
  <div v-else style="position: relative; width: 100%; top: 50%; left: 50%">
    <img
      src="img/loader.gif"
      style="
        position: fixed;
        top: 50%;
        left: 50%;
        -webkit-transform: translate(-50%, -50%);
        -moz-transform: translate(-50%, -50%);
        -ms-transform: translate(-50%, -50%);
        -o-transform: translate(-50%, -50%);
        transform: translate(-50%, -50%);
      "
    />
  </div>
</template>

<script>
import axios from "axios";
import NewsMondo from "./../containers/NewsMondo";

import AreaManager from "./../containers/ContattiAreaManager";
import ContattiAby from "./../containers/ContattiAby";

import store from "./../store";

export default {
  name: "Dashboard",
  components: {
    AreaManager,
    ContattiAby,
    NewsMondo,
  },
  data() {
    return {
      newsModal: false,
      userID: "",
      anagraficaID: "",
      unitaoperativaID: "",
      unitaOperativaTipoID: "",
      show_async: 0,
      triggerNews: 0,
      news_mondo: null,
      urlRami: localStorage.getItem("urlRami"),
      isEnergy: "",
      isRami: false,
      avvisiToast: null,
      recapiti: [],
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
    if (localStorage.getItem("versione") !== "1") {
      console.log("logout_forzato");
      this.$router.push("login");
      return;
    }
    this.chisono();
  },
  mounted() {
    this.get_avvisiToast();
    // this.meteo();
    this.$forceUpdate();
  },

  methods: {
    async conta_accesso(settore) {
      let params = {
        utente: this.userID,
        piattaforma: settore,
      };
      try {
        await axios
          .post(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.ep_api.set_accesso,
            { params }
          )
          .then((response) => {
            switch (settore) {
              case "broker":
                window.location.href = this.$custom_json.broker_veicoli;
                break;
              case "energy":
                this.loginEnergy();
                break;
              case "rami":
                window.location.href = this.urlRami;
                break;
              default:
                break;
            }
            console.log(response.data);
          });
      } catch (error) {
        console.log(error);
      }
      // alert("uno in più per " + settore + " è entrato " + this.userID);
    },
    loginEnergy() {
      // console.log("invio il form di login");
      // Creo un form
      var EnergyForm = document.createElement("form");
      EnergyForm.name = "formLogin";
      EnergyForm.target = "_self";
      EnergyForm.method = "POST";
      EnergyForm.action = this.$custom_json.login_url_energy;

      // Creo l'input per l'user
      var EnergyFormUser = document.createElement("input");
      EnergyFormUser.type = "hidden";
      EnergyFormUser.name = "user";
      EnergyFormUser.value = localStorage.getItem("user");

      // Creo l'input per la passwd
      var EnergyFormPwd = document.createElement("input");
      EnergyFormPwd.type = "hidden";
      EnergyFormPwd.name = "password";
      EnergyFormPwd.value = localStorage.getItem("pwd");

      // Creo l'input per il token
      var EnergyFormToken = document.createElement("input");
      EnergyFormToken.type = "hidden";
      EnergyFormToken.name = "72aeb0fc-7bd8-11e5-b78d-00505693441e";
      EnergyFormToken.value = "securetoken";

      // Aggiungo i campi al form
      EnergyForm.appendChild(EnergyFormUser);
      EnergyForm.appendChild(EnergyFormPwd);
      EnergyForm.appendChild(EnergyFormToken);

      // Aggiungo il form al dom
      document.body.appendChild(EnergyForm);

      // Invio la richiesta
      EnergyForm.submit();
    },

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
          this.userID = risposta_chisono.data.idUtente;
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
          localStorage.setItem("userID", risposta_chisono.data.idUtente);
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
      this.userID = localStorage.getItem("userID");
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
      this.load_news(); // ultime news mondo
      this.recapitiAby(); // recupero i recapiti aby
      this.show_async++;
      this.triggerNews += 1;
    },

    // RECUPERO I RECAPITI ABY
    async recapitiAby() {
      if (localStorage.getItem("RecapitiAby") == null) {
        try {
          var config = {
            method: "post",
            url:
              this.$custom_json.servizi_broker +
              this.$custom_json.ep_broker.RecapitiAby,
            headers: {
              userID: localStorage.getItem("userID"),
              anagraficaid: localStorage.getItem("anagraficaID"),
              unitaoperativaId: localStorage.getItem("unitaoperativaID"),
              unitaOperativaTipologiaId: JSON.parse(
                localStorage.getItem("chisono_data")
              ).UnitaOperativa_Tipo_ID,
            },
          };
          const risposta_recapitiAby = await axios(config);
          // console.log(JSON.stringify(risposta_recapitiAby));
          localStorage.setItem(
            "RecapitiAby",
            JSON.stringify(risposta_recapitiAby.data)
          );
          this.recapiti = JSON.stringify(risposta_recapitiAby.data);
        } catch (error) {
          console.log("errore" + error);
        }
      }
      this.show_async++;
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
  /* font-family: FreeStyle;
  src: url("/img/fonts/FREESCPT.TTF"); */
  font-family: Shadows;
  src: url("/img/fonts/Shadows.ttf");
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
  font-size: 1.5rem;
  position: relative;
  left: -0.5em;
  /* font-family: "Indie Flower", cursive; 
  font-family: "FreeStyle", cursive; */
  font-family: "Shadows";

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
/* PERSONALIZZAZIONE MESSAGGI TOAST */
.messaggio_toast {
  padding: 0.75rem !important;
  font-size: 1.2rem;
}
.titolo_toast {
  text-align: center !important;
  font-size: 2rem !important;
}
#messaggi_toast {
  width: 80vh !important;
}

.mfs-2 .close {
  margin-left: 20rem !important;
}
</style>
