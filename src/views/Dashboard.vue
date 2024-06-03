<template>
  <div v-if="show_async !== 3">
    <CToaster id="messaggi_toast" v-for="(avviso, index) in avvisiToast" :key="index" position="top-center"
      :autohide="5000">
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
          <!-- <div class="col-sm p-0">
            <CCol class="h-100">
              <NewsMondo
                class="h-100"
                :newsParent="news_mondo"
                @reload_mondo="reload_mondo()"
              />
            </CCol>
          </div> -->
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
              <CCard class="text-center elevation-6 portali-btn grow" body-wrapper style="
                  height: 200px;
                  background-image: url('img/buttons/auto.png');
                  background-position: center;
                  z-index: 0;
                  background-size: cover;
                ">
                <CCardTitle class="grow titolo_piattaforme">
                  <span class="portali">Piattaforma</span>
                  <h1 class="pulsante_portali">ASSICURAZIONI</h1>
                </CCardTitle>
              </CCard>
            </CCardLink>
          </div>
          <div v-if="isRami" class="col-sm">
            <CCardLink @click="conta_accesso('rami')" target="_self">
              <CCard class="text-center elevation-6 portali-btn grow" body-wrapper style="
                  height: 200px;
                  background-image: url('img/buttons/rami.png');
                  background-position: center;
                  z-index: 0;
                  background-size: cover;
                ">
                <CCardTitle class="grow titolo_piattaforme">
                  <span class="portali">Piattaforma</span>
                  <h1 class="pulsante_portali">PROFESSIONISTI</h1>
                </CCardTitle>
              </CCard>
            </CCardLink>
          </div>
          <div v-else class="col-sm">
            <CCardLink to="Comingsoon_rami2" target="_self">
              <CCard class="text-center elevation-6 portali-btn grow" body-wrapper style="
                  height: 200px;
                  background-image: url('img/buttons/rami.png');
                  background-position: center;
                  z-index: 0;
                  background-size: cover;
                ">
                <CCardTitle class="grow titolo_piattaforme">
                  <span class="portali">Piattaforma</span>
                  <h1 class="pulsante_portali">PROFESSIONISTI</h1>
                </CCardTitle>
              </CCard>
            </CCardLink>
          </div>
          <div v-if="isRami && isNext2" class="col-sm">
            <CCardLink @click="conta_accesso('ramiNext')" target="_self">
              <CCard class="text-center elevation-6 portali-btn grow" body-wrapper style="
                  height: 200px;
                  background-image: url('img/buttons/rami.png');
                  background-position: center;
                  z-index: 0;
                  background-size: cover;
                ">
                <CCardTitle class="grow titolo_piattaforme">
                  <span class="portali">Piattaforma</span>
                  <h1 class="pulsante_portali">TEST ABYNEXT</h1>
                </CCardTitle>
              </CCard>
            </CCardLink>
          </div>
          <div class="col-sm" v-if="!isEnergy">
            <CCardLink to="Comingsoon_gas" target="_self">
              <CCard class="text-center elevation-6 portali-btn grow" body-wrapper style="
                  height: 200px;
                  background-image: url('img/buttons/energy.png');
                  background-position: center;
                  z-index: 0;
                  background-size: cover;
                ">
                <CCardTitle class="grow titolo_piattaforme">
                  <span class="portali">Piattaforma</span>
                  <h1 class="pulsante_portali">ENERGIA</h1>
                </CCardTitle>
              </CCard>
            </CCardLink>
          </div>
          <div class="col-sm" v-else>
            <CCardLink @click="conta_accesso('energy')">
              <CCard class="text-center elevation-6 portali-btn grow" body-wrapper style="
                  height: 200px;
                  background-image: url('img/buttons/energy.png');
                  background-position: center;
                  z-index: 0;
                  background-size: cover;
                ">
                <CCardTitle class="grow titolo_piattaforme">
                  <span class="portali">Piattaforma</span>
                  <h1 class="pulsante_portali">ENERGIA</h1>
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
</template>

<script>
import axios from "axios";
// import NewsMondo from "./../containers/NewsMondo";
import AreaManager from "./../containers/ContattiAreaManager";
import ContattiAby from "./../containers/ContattiAby";

export default {
  name: "Dashboard",
  components: {
    AreaManager,
    ContattiAby,
    // NewsMondo,
  },
  data() {
    return {
      newsModal: false,
      show_async: 0,
      // news_mondo: JSON.parse(localStorage.getItem("news_mondo")),
      urlRami: localStorage.getItem("urlRami"),
      urlRamiNext2: localStorage.getItem("urlRamiNext2"),
      isEnergy: JSON.parse(localStorage.getItem("chisono_data"))
        .Abilitato_Energy,
      isRami: JSON.parse(localStorage.getItem("chisono_data")).Abilitato_Rami,
      isNext2: true,
      avvisiToast: null,
      recapiti: JSON.parse(localStorage.getItem("RecapitiAby")),
    };
  },
  mounted() {
    this.get_avvisiToast();
    // this.meteo();
    this.$forceUpdate();
  },
  methods: {                
    // attiva/disattiva il loader, emettendo un evento
    // che viene ascoltato da TheContainer
    // se specificato un timeout, il loader torna allo stato precedente
    setLoading(is_loading, timeout_ms = null) {
      this.$emit("set-loading", is_loading, timeout_ms);
    },

    async abyNext2() {
      // =================== ACCESSO PER ABYNEXT 2 ===============================
      let baseUrlNext2 = this.$custom_json.ep_api.baseUrlNext2;
      try {
        let userID = localStorage.getItem("userID");
        var paramNext2 = {
          id: userID,
          user: "sdfghblzs",
          pwd: "lkdfasvdfg"
        };
        var response = await axios
          .post(
            this.$custom_json.base_url +
            this.$custom_json.api_url +
            this.$custom_json.ep_api.getUrlNext2,
            paramNext2
          );

        localStorage.setItem(
          "urlRamiNext2",
          baseUrlNext2 + "?token=" + response.data.token
        );
      } catch (error) {
        console.log("impossibile recuperare jwt rami " + error);
      }
    },
    async set_aua() {
      // console.log("Accesso Aua");
      // console.log("valore di AUA" + localStorage.getItem("AUA"));
      if (localStorage.getItem("AUA")) {
        // console.log("registro");
        let params = {
          utente: localStorage.getItem("userID"),
          piattaforma: "AUA",
        };
        try {
          await axios.post(
            this.$custom_json.base_url +
            this.$custom_json.api_url +
            this.$custom_json.ep_api.set_accesso,
            { params }
          );
        } catch (error) {
          console.log(error);
        }
      }
    },
    async conta_accesso(settore) {
      let params = {
        utente: localStorage.getItem("userID"),
        piattaforma: settore,
      };
      try {
        this.set_aua();
        await axios
          .post(
            this.$custom_json.base_url +
            this.$custom_json.api_url +
            this.$custom_json.ep_api.set_accesso,
            { params }
          )
          .then(async (response) => {
            switch (settore) {
              case "broker":
                window.location.href = this.$custom_json.broker_veicoli;
                break;
              case "energy":
                this.loginEnergy();
                break;
              case "rami":
                if (this.urlRami) {
                  window.location.href = this.urlRami;
                } else {
                  window.location.href = localStorage.getItem("urlRami");
                }
                break;
              case "ramiNext":
                this.setLoading(false, 10 * 1000);

                await this.abyNext2();

                if (this.urlRamiNext2) {
                  window.location.href = this.urlRamiNext2;
                } else {
                  window.location.href = localStorage.getItem("urlRamiNext2");
                }
                
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

  },
};
</script>
