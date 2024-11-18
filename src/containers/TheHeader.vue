<template>
  <div class="theheader">
    <!-- <CHeader fixed with-subheader light class="d-flex justify-content-between fixed-nav"> -->
    <CHeader class="c-header c-header-light c-header-fixed c-header-with-subheader">
      <CHeaderNav class="d-md-down-none mr-auto">
        <CHeaderNavItem class="px-3" target="_self">
          <a href="/dashboard">
            <img src="/img/logo_abyway.png" width="200px" /></a>
        </CHeaderNavItem>
      </CHeaderNav>
      <CHeaderNav v-show="city" class="d-md-down-none mr-auto">
        <CHeaderNavItem class="px-3">
          <h4>
            <em style="font-size: 1rem">{{ city }} {{ temp }}°C </em>
            <img style="margin-left: 5px; max-width: 42px" :src="ico_meteo"
              v-c-tooltip="{ content: desc_meteo, placement: 'bottom-end' }" />
          </h4>
        </CHeaderNavItem>
      </CHeaderNav>
      <CHeaderNav class="mr-4">
        <TheHeaderDropdownAccnt @set-loading="setLoading" />
      </CHeaderNav>
    </CHeader>
    <CRow id="nav-menu">
      <CCol md="1"></CCol>
      <CCol md="10">
        <CNav variant="pills" justified fill class="c-header-light secondary-menu my-1" id="new_menu">
          <CNavItem :class="$route.path == '/dashboard' ? 'active' : ''" class="grow" :to="{ path: '/dashboard' }"
            target="_self"><i class="fas fa-home"></i> Dashboard</CNavItem>
          <CNavItem :class="$route.path == '/StatistichePortali' ? 'active' : ''" class="grow"
            v-if="isEnergy && idUtenteEnergy != '-1'" :to="{ path: '/StatistichePortali' }" target="_self"><i
              class="far fa-chart-bar"></i> Statistiche</CNavItem>
          <CNavItem :class="$route.path == '/Statistiche/broker' ? 'active' : ''" class="grow" v-else
            :to="{ path: '/Statistiche/broker' }" target="_self"><i class="far fa-chart-bar"></i> Statistiche</CNavItem>
          <CNavItem :class="$route.path == '/Commerciale' ? 'active' : ''" class="grow" :to="{ path: '/Commerciale' }"
            target="_self"><i class="fas fa-user-tie"></i> Area Commerciale
            <CBadge v-show="notificheCommerciale > 0" color="danger" class="badgeNotifiche">{{ notificheCommerciale }}
            </CBadge>
          </CNavItem>
          <CNavItem :class="$route.path == '/Formazione' ? 'active' : ''" class="grow" :to="{ path: '/Formazione' }"
            target="_self"><i class="fas fa-user-graduate"></i> Formazione
            <CBadge v-show="notificheFormazione > 0" color="danger" class="badgeNotifiche">{{ notificheFormazione }}
            </CBadge>
          </CNavItem>
          <CNavItem :class="$route.path == '/Comingsoon' ? 'active' : ''" class="grow"
            :to="{ path: '/Amministrazione' }" target="_self"><i class="fas fa-calculator"></i> Amministrazione
          </CNavItem>
          <CNavItem :class="$route.path == '/Documentale'
            ? $route.path == '/Documentale/Intermediario'
              ? 'active'
              : 'active'
            : ''
            " class="grow" :to="{ path: '/Documentale' }" target="_self"><i class="fas fa-file-signature"></i>
            Documentale</CNavItem>
        </CNav>
      </CCol>
      <CCol md="1"></CCol>
    </CRow>
  </div>
</template>

<script>
import { cilArrowCircleLeft } from "@coreui/icons";
import TheHeaderDropdownAccnt from "./TheHeaderDropdownAccnt";
import axios from "axios";

export default {
  name: "TheHeader",
  back_ico: cilArrowCircleLeft,
  components: {
    TheHeaderDropdownAccnt,
  },
  data() {
    return {
      city: null,
      temp: null,
      desc_meteo: null,
      ico_meteo: null,
      notificheCommerciale: 0,
      notificheFormazione: 0,
      isEnergy: JSON.parse(localStorage.getItem("chisono_data"))
        .Abilitato_Energy,
      idUtenteEnergy: "",
      interval: null,
      check_ver: null,
    };
  },
  mounted() {
    this.meteo();
    this.get_notifiche_formazione();
    this.get_notifiche_commerciale();
    this.chisono_energy();
  },
  created() {
    let last_version = null;
    this.interval = setInterval(() => {
      this.get_notifiche_formazione();
      this.get_notifiche_commerciale();
    }, 30000);
    // Controllo se dev'essere aggiornato e forzato il logout di tutti gli utenti ogni 10 minuti
    this.check_ver = setInterval(() => {
      let url =
        this.$custom_json.base_url +
        this.$custom_json.api_url +
        this.$custom_json.ep_api.get_version;

      axios.post(url).then((response) => {
        // console.log("Versione recuperata " + response.data);
        // localStorage.setItem("versione", response.data);
        last_version = response.data;

        if (localStorage.getItem("versione") !== last_version) {
          // console.log(
          //   "comparo " +
          //     localStorage.getItem("versione") +
          //     " con " +
          //     last_version
          // );
          // console.log("logout_forzato");
          this.$router.push("login");

          return;
        }
      });
    }, 600000);
  },
  destroyed() {
    clearInterval(this.interval);
  },
  methods: {
    // attiva/disattiva il loader, emettendo un evento
    // che viene ascoltato da TheContainer
    // se specificato un timeout, il loader torna allo stato precedente
    setLoading(is_loading, timeout_ms = null) {
      this.$emit("set-loading", is_loading, timeout_ms);
    },

    async chisono_energy() {
      if (!localStorage.getItem("idUtenteEnergy")) {
        // console.log("chiamo il servizio energy");
        try {
          var config = {
            method: "post",
            url: this.$custom_json.servizi_energy + "chisono",
            headers: {
              utente: localStorage.getItem("user"),
              password: localStorage.getItem("pwd"),
            },
          };
          const risposta_chisono_energy = await axios(config);
          localStorage.setItem(
            "chisono_energy_data",
            JSON.stringify(risposta_chisono_energy.data)
          );
          localStorage.setItem(
            "idUtenteEnergy",
            JSON.stringify(risposta_chisono_energy.data.idUtente)
          );
          this.idUtenteEnergy = localStorage.getItem("idUtenteEnergy");
        } catch (error) {
          console.log("errore");
          this.idUtenteEnergy = "-1";
          localStorage.setItem("idUtenteEnergy", "-1");
        }
      } else {
        this.idUtenteEnergy = localStorage.getItem("idUtenteEnergy");
      }
    },
    meteo() {
      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(this.showPosition);
      } else {
        console.log("Geolocation is not supported by this browser.");
      }
    },
    showPosition(position) {
      // console.log("Latitudine: " + position.coords.latitude);
      // console.log("Longitudine: " + position.coords.longitude);
      let latitude = position.coords.latitude;
      let longitude = position.coords.longitude;
      // console.log("url meteo " + this.$custom_json.url_meteo);
      let url =
        this.$custom_json.url_meteo +
        "?appid=" +
        this.$custom_json.token_meteo +
        "&lat=" +
        latitude +
        "&lon=" +
        longitude +
        "&units=metric&lang=it";

      try {
        axios.get(url).then((response) => {
          // console.log("Dati meteo: " + JSON.stringify(response.data.name));
          this.city = response.data.name;
          this.temp = response.data.main.temp.toString().split(".")[0];
          this.desc_meteo = response.data.weather[0].description;
          this.ico_meteo =
            "/img/meteo/" + response.data.weather[0].icon + ".png";
        });
      } catch (error) {
        console.log("impossibile recuperare i dati meteo" + error);
      }
    },
    async get_notifiche_formazione() {
      // console.log("AGGIORNAMENTO NOTIFICHE FORMAZIONE");
      let params = {
        categoria: "Corso",
        utente: localStorage.getItem("userID"),
        tipo_uo: JSON.parse(localStorage.getItem("chisono_data"))
          .UnitaOperativa_Tipo_ID,
      };
      try {
        await axios
          .post(
            this.$custom_json.base_url +
            this.$custom_json.api_url +
            this.$custom_json.ep_api.get_notifiche,
            { params }
          )
          .then((response) => {
            this.notificheFormazione = response.data;
          });
      } catch (error) {
        console.log("errore: " + error);
      }
    },
    async get_notifiche_commerciale() {
      // console.log("AGGIORNAMENTO NOTIFICHE COMMERCIALE");
      let params = {
        categoria: "Post",
        utente: localStorage.getItem("userID"),
        tipo_uo: JSON.parse(localStorage.getItem("chisono_data"))
          .UnitaOperativa_Tipo_ID,
      };
      try {
        await axios
          .post(
            this.$custom_json.base_url +
            this.$custom_json.api_url +
            this.$custom_json.ep_api.get_notifiche,
            { params }
          )
          .then((response) => {
            this.notificheCommerciale = response.data;
          });
      } catch (error) {
        console.log("errore: " + error);
      }
    },
  },
};
</script>
