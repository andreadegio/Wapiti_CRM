<template>
  <div class="c-app">
    <CWrapper v-if="loading && get_recapiti">
      <TheHeader id="header" @set-loading="onSetLoading" />
      <div class="c-body">
        <main class="c-main">
          <CContainer fluid class="new_fluid" style="">
            <transition name="fade" mode="out-in">
              <router-view :key="$route.path" @set-loading="onSetLoading"></router-view>
            </transition>
          </CContainer>
        </main>
      </div>
      <TheFooter id="footer" v-show="this.$route.path == '/dashboard'" />
    </CWrapper>
    <div v-else style="position: relative; width: 100%; top: 50%; left: 50%">
      <img src="img/loader.gif" style="
          position: fixed;
          top: 50%;
          left: 50%;
          -webkit-transform: translate(-50%, -50%);
          -moz-transform: translate(-50%, -50%);
          -ms-transform: translate(-50%, -50%);
          -o-transform: translate(-50%, -50%);
          transform: translate(-50%, -50%);
        " />
    </div>
  </div>
</template>

<script>
import axios from "axios";
import TheHeader from "./TheHeader";
import TheFooter from "./TheFooter";
import store from "./../store";
export default {
  name: "Abyway",
  components: {
    TheHeader,
    TheFooter,
  },
  data() {
    return {
      // userID: "",
      // news_mondo: [],
      loading: false,
      get_recapiti: false,
      // get_news: false,
      url_versione: "",
    };
  },
  created() {
    this.url_versione = this.$custom_json.base_url + this.$custom_json.api_url + this.$custom_json.ep_api.get_version;
    if (this.$route.query.auth == "1") {
      store.commit("user_login", this.url_versione);
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

  methods: {
    async chisono() {
      // console.log("START Chisono");
      // Confronto la data del login in cache con l'attuale data, se maggiore di un giorno atterro su login
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
        // console.log("devo rifare il login - sessione scaduta");
        this.$router.push("login");
        return;
      }

      //  chiamo il servizio chisono per recuperare i dati dell'utente loggato
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

          let risposta_chisono = "";
          await axios(config)
            .then(
              function (response) {
                risposta_chisono = response;
                // console.log("RISPOSTA Chisono");
                // alert(JSON.stringify(risposta_chisono.data));
                localStorage.setItem(
                  "chisono_data",
                  JSON.stringify(risposta_chisono.data)
                );
                localStorage.setItem("userID", risposta_chisono.data.idUtente);
                // this.userID = risposta_chisono.data.idUtente;
                localStorage.setItem(
                  "anagraficaID",
                  risposta_chisono.data.idAnagrafica
                );
                localStorage.setItem(
                  "unitaoperativaID",
                  risposta_chisono.data.idUnitaOperativa
                );
                // console.log("START ALTRE FUNZIONI");
                // this.load_news(); // ultime news mondo
                this.recapitiAby(); // recupero i recapiti aby
                // controllo se sono abilitato all'utilizzo del portale rami
                if (risposta_chisono.data.Abilitato_Rami) {
                  //Imposto il parametro isRami a true in modo da visualizzare il pulsante
                  localStorage.setItem("isRami", true);
                  // se sono abilitato chiamo il servizio per recuperare l'url da inserire nel pulsante
                  try {
                    var param = {
                      id_persona_operativa: risposta_chisono.data.idUtente,
                    };
                    axios
                      .post(
                        this.$custom_json.base_url +
                        this.$custom_json.api_url +
                        this.$custom_json.ep_api.getUrlRami,
                        param
                      )
                      .then((response) => {
                        localStorage.setItem("urlRami", response.data);
                        // this.urlRami = response.data;
                      });
                  } catch (error) {
                    console.log("impossibile recuperare jwt rami " + error);
                  }

                }
              }.bind(this)
            )
            .catch(
              function () {
                this.loading = true;
              }.bind(this)
            );

          localStorage.setItem("userID", risposta_chisono.data.idUtente);
        } catch (error) {
          console.log("errore");
          this.$router.push("login");
        }
      }
      // this.load_news(); // ultime news mondo
      this.recapitiAby(); // recupero i recapiti aby
      // console.log("CHIUSURA LOADER");
      this.loading = true;
    },
    async recapitiAby() {
      // console.log("START Recapiti");
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
          // this.recapiti = JSON.stringify(risposta_recapitiAby.data);
        } catch (error) {
          console.log("errore" + error);
        }
      }
      // console.log("RISPOSTA Recapiti");
      this.get_recapiti = true;
    },
    // async load_news() {
    //   // console.log("START News");
    //   var chiamata_news = [];
    //   try {
    //     await axios
    //       .get(
    //         this.$custom_json.base_url +
    //           this.$custom_json.api_url +
    //           this.$custom_json.ep_api.listanews_home
    //       )
    //       .then((response) => {
    //         chiamata_news = response.data;
    //       });
    //     this.news_mondo = chiamata_news.map((item, id) => {
    //       return { ...item, id };
    //     });

    //     localStorage.setItem("news_mondo", JSON.stringify(this.news_mondo));
    //   } catch (error) {
    //     // alert(JSON.parse(localStorage.getItem("news_mondo")));
    //     if (localStorage.getItem("news_mondo") != null) {
    //       this.news_mondo = JSON.parse(localStorage.getItem("news_mondo"));
    //     } else {
    //       // in caso di chiamata fallita e contenuto non presente nello storage tento una seconda volta
    //       try {
    //         await axios
    //           .get(
    //             this.$custom_json.base_url +
    //               this.$custom_json.api_url +
    //               this.$custom_json.ep_api.listanews_home
    //           )
    //           .then((response) => {
    //             chiamata_news = response.data;
    //             // console.log("RISPOSTA News");
    //           });
    //         this.news_mondo = chiamata_news.map((item, id) => {
    //           return { ...item, id };
    //         });

    //         localStorage.setItem("news_mondo", JSON.stringify(this.news_mondo));
    //       } catch (error) {
    //         // se ricevo il secondo errore allora mosto la sezione vuota
    //         this.news_mondo = "";
    //       }
    //     }
    //   }
    //   this.get_news = true;
    // },

    // nell'html trovi @set-loading="onSetLoading"
    // quando il componente figlio (es. Dashboard) emette l'evento "set-loading"
    // il padre (questo componente) esegue la funzione onSetLoading
    onSetLoading(is_loading, timeout_ms = null) {
      console.debug("thecontainer.onSetLoading", is_loading, timeout_ms);
      this.loading = is_loading;

      if(timeout_ms !== null) { 
        setTimeout(() => { this.loading = !is_loading; }, timeout_ms);
      }
    },
    
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
  height: auto !important;
  /* cross-browser */
  height: 100%;
  /* cross-browser */
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
