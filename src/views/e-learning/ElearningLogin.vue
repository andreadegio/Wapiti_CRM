<template>
  <v-app>
    <div class="flex-row align-items-center sfondo">
      <img class="login_sx" src="img/login/login_sx.png" />
      <img class="login_dx" src="img/login/login_dx.png" />
      <CContainer class="pt-5">
        <CRow class="justify-content-center">
          <CCol md="4" sm="1"> </CCol>
          <CCol md="4" sm="10">
            <CRow class="pt-3 pb-3 text-center m-0" align-horizontal="center">
              <img class="login-img" src="img/Aby-Accademy_small.png" />
            </CRow>
            <CRow align-horizontal="center" class="m-0">
              <div class="testo_login">
                <CRow align-horizontal="center" class="pt-2 text-center m-0">
                  <span class="h1 login-txt"><strong>Login</strong></span>
                </CRow>
                <CRow align-horizontal="center" class="m-0">
                  <v-card-title class="text-center">Inserisci il PIN ricevuto tramite email</v-card-title>
                  <v-card-text>
                    <form @submit.prevent="login">
                      <v-otp-input v-model="otp" length="8" required></v-otp-input>
                      <div v-show="messaggio_errore" style="color: darkred; font-weight: bold">
                        <CAlert color="danger" closeButton>
                          {{ testo_errore }}
                        </CAlert>
                      </div>
                      <v-btn type="submit" block color="#1f4b6b" class="entra_btn" :loading="loading"
                        elevation="5">Accedi</v-btn>
                    </form>
                  </v-card-text>
                </CRow>
              </div>
            </CRow>
          </CCol>
          <CCol md="4" sm="1" style="text-align: right"> </CCol>
        </CRow>
      </CContainer>
    </div>
  </v-app>
</template>

<script>
// import store from "../../store";
import axios from 'axios';

export default {
  name: "LoginAccademy",
  data() {
    return {
      messaggio_errore: false,
      testo_errore: "",
      otp: null,
      queryParams: {},
      loading: false,

    };
  },
  created() {
    // Al caricamento della login controllo: se arrivo con un errore 
    if (this.$route.query.errore) {
      this.messaggio_errore = true;
      this.testo_errore = "Errore, eseguire l'accesso con il link originale"
      this.$router.push("e-learning-login");
    }
    // Se ci sono parametri nella query string, rimuovili e aggiornali
    if (Object.keys(this.$route.query).length > 0) {
      // salvo i parametri arrivati da query string nell'oggetto queryParams
      this.queryParams = { ...this.$route.query };
      this.$router.replace({ ...this.$route, query: {} }); // Rimuovi i parametri dalla query string
    }
    // console.log(this.queryParams.user);
  },

  methods: {
    login() {
      this.loading = true; // Mostra il loader sul pulsante


      axios.post(this.$custom_json.base_url +
        this.$custom_json.api_url +
        this.$custom_json.accademy.loginBypin, {
        pin: this.otp,
        id: this.queryParams.id
      })
        .then(response => {
          if (response.data.message == 'OK') {
            this.$store.commit('setUserId', this.queryParams.id);
            this.$store.commit('setLoggedInUser', this.queryParams.utente);
            localStorage.setItem("tokenElearning", "SLKJDO20300SLXPA...A38902");
            this.$router.push({
              path: '/e-learning'
            });
          }
          else {
            this.testo_errore = response.data.message;
            this.messaggio_errore = true;
          }

          // Esempio: reindirizza l'utente a una nuova pagina dopo il successo


        })
        .catch(error => {
          // Gestisci gli errori
          console.error('Errore durante la richiesta:', error);
          // Esempio: visualizza un messaggio di errore all'utente
          alert('Si è verificato un errore durante la richiesta.');
        })
        .finally(() => {
          this.loading = false; // Nascondi il loader sul pulsante
        });
    }
  },
};
</script>
<style scoped>
@font-face {
  font-family: Shadows;
  src: url("/img/fonts/Shadows.ttf");
}

.sfondo {
  background-color: white;
  background-attachment: fixed;
  background-position: center;
  background-size: cover;
  font-family: "Montserrat", sans-serif;
  height: 100vh;
}


.login-txt {
  font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
}

.login_sx {
  position: absolute;
  bottom: 0;
  left: 0;
  max-height: 60%;
  z-index: 0;
}

.login_dx {
  position: absolute;
  top: 0;
  right: 0;
  max-height: 30%;
  z-index: 0;
}

.testo_login {
  color: #1f4b6b !important;
  font-size: 1rem;
  font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
  font-weight: 500;
  margin-bottom: 1rem;
  line-height: 1.7rem;
}

.entra_btn {
  border-radius: 3px;
  font-weight: 400;
  border: none;
  font-size: 1.6em !important;
  padding: 1.5rem 0 !important;
  text-transform: capitalize !important;
  color: #fff !important;
  transition: 0.5s ease-in;
  -webkit-transition: 0.5s ease-in;
  -moz-transition: 0.5s ease-in;
  -o-transition: 0.5s ease-in;
  -ms-transition: 0.5s ease-in;

}

.entra_btn:hover {
  background: #EF7918 !important;
}
</style>
