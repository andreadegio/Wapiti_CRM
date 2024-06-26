<template>
  <div id="elenco_pulsanti">
    <CCardLink v-if="isEnergy && idUtenteEnergy != '-1'" to="StatistichePortali" target="_self">
      <CCard class="text-center elevation-6 pulsanti-azioni" body-wrapper
        style="background-image: url('img/buttons/statistiche.png')">
        <CCardTitle>
          <h1>STATISTICHE</h1>
        </CCardTitle>
      </CCard>
    </CCardLink>
    <CCardLink v-else to="Statistiche/broker" target="_self">
      <CCard class="text-center elevation-6 pulsanti-azioni" body-wrapper
        style="background-image: url('img/buttons/statistiche.png')">
        <CCardTitle>
          <h1>STATISTICHE</h1>
        </CCardTitle>
      </CCard>
    </CCardLink>
    <CCardLink to="Commerciale" target="_self">
      <CBadge v-show="notificheCommerciale > 0" color="danger" class="badgeNotifiche">{{ notificheCommerciale }}
      </CBadge>
      <CCard class="text-center elevation-6 pulsanti-azioni" body-wrapper
        style="background-image: url('img/buttons/marketing.png')">
        <CCardTitle>
          <h1>AREA COMMERCIALE</h1>
        </CCardTitle>
      </CCard>
    </CCardLink>

    <CCardLink to="Comingsoon" target="_self">
      <CCard class="text-center elevation-6 pulsanti-azioni" body-wrapper
        style="background-image: url('img/buttons/amministrazione.png')">
        <CCardTitle>
          <h1>AMMINISTRAZIONE</h1>
        </CCardTitle>
      </CCard>
    </CCardLink>
    <CCardLink to="Formazione" target="_self">
      <CBadge v-show="notificheFormazione > 0" color="danger" class="badgeNotifiche">{{ notificheFormazione }}</CBadge>
      <CCard class="text-center elevation-6 pulsanti-azioni" body-wrapper
        style="background-image: url('img/buttons/formazione.png')">
        <CCardTitle>
          <h1>FORMAZIONE</h1>
        </CCardTitle>
      </CCard>
    </CCardLink>
    <CCardLink to="Documentale" target="_self">
      <CCard class="text-center elevation-6 pulsanti-azioni" body-wrapper style="
          background-image: url('img/buttons/documentale.png');
          z-index: 10;
        ">
        <CCardTitle>
          <h1>DOCUMENTALE</h1>
        </CCardTitle>
      </CCard>
    </CCardLink>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "PulsantiSx",
  data() {
    return {
      notificheCommerciale: 0,
      notificheFormazione: 0,
      isEnergy: JSON.parse(localStorage.getItem("chisono_data"))
        .Abilitato_Energy,
      idUtenteEnergy: "",
    };
  },
  created() {
    this.get_notifiche_formazione();
    this.get_notifiche_commerciale();
    this.chisono_energy();
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
    async get_notifiche_formazione() {
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

<style scoped>
#elenco_pulsanti {
  display: flex;
  flex-direction: column;
  justify-content: space-around;
  width: 100%;
  padding-left: 0px !important;
  padding-right: 0px !important;
}

.card-link {
  margin-left: 0px !important;
  text-align: right;
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

.pulsanti-azioni {
  background-position: center center;
  background-size: cover;
  max-width: 290px;
  -webkit-filter: grayscale(100%);
  /* Safari 6.0 - 9.0 */
  filter: grayscale(0%);
  word-wrap: initial !important;
}

.pulsanti-azioni:hover {
  -webkit-filter: grayscale(0%);
  /* Safari 6.0 - 9.0 */
  filter: grayscale(100%);
}

.pulsanti-azioni h1 {
  color: white;
  font-weight: 800;
  text-shadow: 1px 1px midnightblue;
  font-size: 1.5rem;
  margin-bottom: 0 !important;
}

.pulsanti-azioni .card-body {
  padding-left: 0.25em;
  padding-right: 0.25em;
}

.pulsanti-azioni h4 {
  margin-bottom: 0px !important;
}

.badgeNotifiche {
  position: absolute;
  z-index: 99999;
  box-shadow: 0 3px 5px -1px rgba(0, 0, 0, 0.2),
    0 6px 10px 0 rgba(0, 0, 0, 0.55), 0 1px 18px 0 rgba(223, 78, 78, 0.83) !important;
  font-size: 100% !important;
  border-radius: 1rem;
  margin-left: -0.5rem;
}
</style>