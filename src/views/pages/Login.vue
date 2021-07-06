<template>
  <div class="c-app flex-row align-items-center sfondo_gradiente">
    <CContainer>
      <CRow class="justify-content-center">
        <span class="display-3" style="color: white; font-weight: bold">
          Benvenuto in</span
        >
        <img class="login-img ml-2" src="img/logo_abyway.png" />
      </CRow>

      <br />
      <div id="scritta"><hr /></div>
      <CRow class="justify-content-center">
        <CCol md="1"> </CCol>
        <CCol md="5">
          <CCardGroup class="pt-5" style="padding-top: 15% !important">
            <CCard
              id="gruppo_card"
              class="p-4"
              style="
                background-color: rgba(249, 249, 249, 0.42);
                color: white;
                box-shadow: 5px 5px 7px 0px rgba(0, 0, 0, 0.4);
                border: 0;
              "
            >
              <CCardBody style="color: #1f2f55; border-color: #3c74d0">
                <div
                  v-show="messaggio_errore"
                  style="color: darkred; font-weight: bold"
                >
                  <CAlert color="danger" closeButton>
                    Credenziali errate
                  </CAlert>
                </div>
                <CRow align-horizontal="center" class="pb-3 text-center">
                  <span class="h1"><strong> Benvenuto</strong></span>
                </CRow>
                <CRow class="pb-3 text-center" align-horizontal="center">
                  <span
                    >Inserisci username e password per accedere ai servizi
                    online di AbyWay.it</span
                  >
                </CRow>
                <form
                  id="formLogin"
                  @submit="getUserValue"
                  :action="login_url"
                  method="post"
                >
                  <CRow align-horizontal="center" class="pt-3 pb-3 text-center">
                    <CInput
                      id="user"
                      class="col-sm-10 pl-0 pr-0 mb-0"
                      placeholder="Username"
                      name="user"
                      size="lg"
                    >
                      <template #prepend-content>
                        <i class="fas fa-user"></i>
                        <!-- <CIcon name="cil-user"/> -->
                      </template>
                    </CInput>

                    <CInput
                      id="password"
                      class="col-sm-10 pl-0 pr-0 mb-0"
                      placeholder="Password"
                      type="password"
                      autocomplete="current-password"
                      name="password"
                      size="lg"
                    >
                      <template #prepend-content>
                        <i class="fas fa-unlock-alt"></i>
                        <!-- <CIcon name="cil-shield-alt"/> -->
                      </template>
                    </CInput>
                    <input
                      name="72aeb0fc-7bd8-11e5-b78d-00505693441e"
                      type="hidden"
                      value="securetoken"
                    />
                    <CInput
                      id="accedi_btn"
                      type="submit"
                      color="primary"
                      class="col-sm-10 mt-0 mb-0 px-0"
                      value="Accedi"
                    >
                      <!-- <input
                      class="entra_btn col-sm-10 mt-0 mb-0"
                      type="submit"
                      value="Accedi"
                    /> -->
                    </CInput>
                  </CRow>
                </form>
              </CCardBody>
            </CCard>
          </CCardGroup>
        </CCol>

        <CCol md="6" style="text-align: right">
          <img class="pt-5 mt-5 ml-5" src="img/slide_1_el1.png" />
        </CCol>
      </CRow>
    </CContainer>
    <CFooter style="color: white; background: none; border: none">
      <div class="mfs-auto">
        <span class="mr-1"><em>Powered by Navert S.r.l.</em></span>
      </div>
    </CFooter>
  </div>
</template>

<script>
import store from "../../store";

export default {
  // components: { CoreUIIcons },
  name: "Login",
  data() {
    return {
      jsonUtente: [],
      messaggio_errore: false,
      login_url: this.$custom_json.login_url,
    };
  },
  created() {
    // Al caricamento della login controllo: se arrivo con un errore di autenticazione lo mostro altrimenti svuoto il local storage chiamando la funzione "user_logout"
    if (this.$route.query.errore) {
      this.messaggio_errore = true;
      this.$router.push("login");
    }

    store.commit("user_logout");
  },

  methods: {
    getUserValue(submitEvent) {
      localStorage.setItem("user", submitEvent.target.elements.user.value);
      localStorage.setItem("pwd", submitEvent.target.elements.password.value);
      return true;
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
.sfondo_gradiente {
  background: url("/img/slide_1_bg.jpg") bottom right,
    linear-gradient(to right bottom, #1cc7d0, #013ca6, #013ca6, #1cc7d0) !important;
  background-attachment: fixed;
  background-position: center;
  background-size: cover;
  font-family: "Montserrat", sans-serif;
}
.login-img {
  vertical-align: baseline !important;
}
hr {
  border-width: 0;
  color: rgb(255, 255, 255);
  height: 1px;
  line-height: 0;
  margin: 0.5em 0;
  text-align: center;
  padding-top: 10px;
}
hr:after {
  content: "La nuova piattaforma operativa";
  font-size: 3.5em;
  position: relative;
  left: -0.5em;
  /* font-family: "Indie Flower", cursive; */
  font-family: "FreeStyle", cursive;

  padding-top: 5px;
  padding-left: 1em;
  padding-right: 1em;
}

.entra_btn {
  border-radius: 3px;
  font-weight: bold;
  width: 30%;
  background: #1f2f55;
  border: none;
  margin: 1.5em 0 1.5em;
  outline: none;
  letter-spacing: 1px;
  font-size: 1.25em;
  padding: 14px 0;
  color: #fff;
  text-transform: uppercase;
  transition: 0.5s ease-in;
  -webkit-transition: 0.5s ease-in;
  -moz-transition: 0.5s ease-in;
  -o-transition: 0.5s ease-in;
  -ms-transition: 0.5s ease-in;
  cursor: pointer;
}

.entra_btn:hover {
  background: #1255a6;
}

#formLogin {
  margin-top: 10px;
  border-radius: 5px;
  padding-top: 10px;
  padding-bottom: 10px;
  border: solid 1px #d8dbe07d;
}
</style>