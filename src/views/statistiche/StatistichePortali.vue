<template>
  <CContainer
  id="statistiche_portali"
    class="text-center d-flex min-vh-100 pt-5"
    style="
      background: rgb(255, 255, 255) url('img/statistiche.jpg') no-repeat scroll
        0% 0%;
    "
  >
    <CRow class="w-100 justify-content-center">
      <CCol col="12" sm="3">
        <CCardLink to="Statistiche/broker" target="_self">
         <CWidgetSimple class="bg-broker">
            <span class="py-3" style="color: white">
              <i class="fas fa-car-alt fa-3x"></i>
              <br />
              Statistiche Assicurazioni
            </span>
          </CWidgetSimple>
        </CCardLink>
      </CCol>
      <CCol col="12" sm="3" v-if="idUtenteEnergy != -1">
        <CCardLink to="Statistiche/energy" target="_self">
          <CWidgetSimple class="bg-energy">
            <span class="py-3" style="color: white">
              <i class="far fa-lightbulb fa-3x"></i>
              <br />
              Statistiche Gas & Luce
            </span>
          </CWidgetSimple>
        </CCardLink>
      </CCol>
      <CCol col="12" sm="3" v-else>
        <CCardLink @click="loginEnergy()" target="_self">
          <CWidgetSimple class="bg-energy">
            <span class="py-3" style="color: white">
              <i class="far fa-lightbulb fa-3x"></i>
              <br />
              Statistiche Gas & Luce
            </span>
          </CWidgetSimple>
        </CCardLink>
      </CCol>
    </CRow>
  </CContainer>
</template>
<script>
import axios from "axios";

export default {
  name: "StatistichePortali",
  data: function () {
    return {
      idUtenteEnergy: -1,
    };
  },
  methods: {
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
    async chisono_energy() {
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
        this.$router.push("login");
      }
    },
  },
  mounted() {
    this.chisono_energy();
  },
  beforeDestroy() {
    window.removeEventListener("resize", this.getWindowHeight);
    document.documentElement.style.overflow = "auto";
  },
};
</script>
<style scoped>
.bg-broker {
  background-color: #1f4b6b !important;
}
.bg-rami {
  background-color: #607d8b !important;
}
.bg-energy {
  background-color: green !important;
}
.portali-btn {
  -webkit-filter: grayscale(0%); /* Safari 6.0 - 9.0 */
  filter: grayscale(0%);
}

#statistiche_portali{
  background-size: cover !important;
  background-position: right !important;
  max-width: none !important;
}
</style>