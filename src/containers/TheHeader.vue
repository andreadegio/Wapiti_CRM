<template>
  <div style="background-color: white">
    <!-- <CHeader fixed with-subheader light class="d-flex justify-content-between fixed-nav"> -->
    <CHeader
      fixed
      with-subheader
      light
      class="c-header c-header-light c-header-fixed c-header-with-subheader"
    >
      <CHeaderNav class="d-md-down-none mr-auto">
        <CHeaderNavItem class="px-3">
          <img src="/img/logo_abyway.png" width="200px" />
        </CHeaderNavItem>
      </CHeaderNav>
      <!-- <CHeaderNav v-show="city" class="d-md-down-none mr-auto">
        <CHeaderNavItem class="px-3">
          <h4>
            <em style="font-size: 1rem">{{ city }} {{ temp }}°C </em>
            <img
              style="margin-left: 5px; max-width: 42px"
              :src="ico_meteo"
              v-c-tooltip="{ content: desc_meteo, placement: 'bottom-end' }"
            />
          </h4>
        </CHeaderNavItem>
      </CHeaderNav> -->
      <CHeaderNav class="mr-4">
        <TheHeaderDropdownAccnt />
      </CHeaderNav>
    </CHeader>
    <CRow>
      <CCol md="1"></CCol>
      <CCol md="10">
        <CNav
          variant="pills"
          justified
          fill
          class="c-header-light secondary-menu my-1"
          id="new_menu"
        >
          <CNavItem
            active
            class="grow"
            :to="{ path: '/dashboard' }"
            target="_self"
            ><i class="fas fa-home"></i> Dashboard</CNavItem
          >
          <CNavItem
            class="grow"
            v-if="isEnergy && idUtenteEnergy != '-1'"
            :to="{ path: '/StatistichePortali' }"
            target="_self"
            ><i class="far fa-chart-bar"></i> Statistiche</CNavItem
          >
          <CNavItem
            class="grow"
            v-else
            :to="{ path: '/Statistiche', params: { portale: 'broker'}}"
            target="_self"
            ><i class="far fa-chart-bar"></i> Statistiche</CNavItem
          >
          <CNavItem class="grow" :to="{ path: '/Commerciale' }" target="_self"
            ><i class="fas fa-user-tie"></i> Area Commerciale
            <CBadge
              v-show="notificheCommerciale > 0"
              color="danger"
              class="badgeNotifiche"
              >{{ notificheCommerciale }}</CBadge
            ></CNavItem
          >
          <CNavItem class="grow" :to="{ path: '/Formazione' }" target="_self"
            ><i class="fas fa-user-graduate"></i> Formazione
            <CBadge
              v-show="notificheFormazione > 0"
              color="danger"
              class="badgeNotifiche"
              >{{ notificheFormazione }}</CBadge
            ></CNavItem
          >
          <CNavItem class="grow" :to="{ path: '/Comingsoon' }" target="_self"
            ><i class="fas fa-calculator"></i> Amministrazione</CNavItem
          >
          <CNavItem class="grow" :to="{ path: '/Documentale' }" target="_self"
            ><i class="fas fa-file-signature"></i> Documentale</CNavItem
          >
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
    }, 3000);
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
          console.log("logout_forzato");
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
<style>
.grow {
  transition: all 0.2s ease-in-out;
}
.grow:hover {
  transform: scale(1.2);
}
#new_menu li:hover {
  /* background-color: #ecac75; */
  background-color: #ef7a13;

  border-radius: 10px;
}
#new_menu li a:hover {
  /* background-color: #ecac75; */
  /* background-color: #ef7a13;

  border-radius: 10px; */
  color: white !important;
}
.nav-item {
  margin-top: auto;
  margin-bottom: auto;
  /* border-right: 1px solid lightgray; */
}


.nav-pills .nav-link {
  font-size: 1.3rem !important;
  font-weight: 500 !important;
}

a.active {
  background-color: #ef7a13 !important;
}

.badgeNotifiche {
  position: absolute;
  z-index: 99999;
  box-shadow: 0 3px 5px -1px rgba(0, 0, 0, 0.2),
    0 6px 10px 0 rgba(0, 0, 0, 0.55), 0 1px 18px 0 rgba(223, 78, 78, 0.83) !important;
  font-size: 100% !important;
  border-radius: 1rem;
  margin-top: -0.5rem;
}
#header {
  -webkit-box-shadow: -1px 7px 9px 1px #a3a3a3;
  -moz-box-shadow: -1px 7px 9px 1px #a3a3a3;
  -o-box-shadow: -1px 7px 9px 1px #a3a3a3;
  box-shadow: -1px 7px 9px 1px #a3a3a3;
  z-index: 1;
}
</style>

