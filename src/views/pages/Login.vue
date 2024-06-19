<template>
  <div class="flex-row align-items-center sfondo">
    <img class="login_sx" src="img/login/login_sx.png" />
    <img class="login_dx" src="img/login/login_dx.png" />

    <CContainer class="pt-5" style="height: 100vh;">
      <CRow class="justify-content-center">
        <CCol md="4" sm="1"> </CCol>
        <CCol md="4" sm="10">
          <CRow class="pt-3 pb-3 text-center m-0" align-horizontal="center">
            <img class="login-img" src="img/logo_abyway.png" />
            <span class="testo_login">
              Una serie di strumenti indispensabili, sviluppati per
              semplificarti il lavoro e fornire<br />un servizio professionale
              al Cliente. <br /> </span><span class="payoff"><i>Tutto questo è AbyWay!</i></span>
          </CRow>
          <CRow align-horizontal="center" class="m-0">
            <div>
              <CRow align-horizontal="center" class="pt-2 text-center m-0">
                <span class="h1 login-txt"><strong>Login</strong></span>
              </CRow>
              <CRow align-horizontal="center" class="m-0">
                <form id="formLogin" @submit="getUserValue" :action="login_url" method="post">
                  <CRow align-horizontal="center" class="m-0 pt-3 pb-3 text-center">
                    <CInput id="user" class="col-sm-10 pl-0 pr-0 mb-0" placeholder="Username" name="user" size="lg">
                      <template #prepend-content>
                        <i class="fas fa-user"></i>
                        <!-- <CIcon name="cil-user"/> -->
                      </template>
                    </CInput>

                    <CInput id="password" class="col-sm-10 pl-0 pr-0 mb-0" placeholder="Password" type="password"
                      autocomplete="current-password" name="password" size="lg">
                      <template #prepend-content>
                        <i class="fas fa-unlock-alt"></i>
                        <!-- <CIcon name="cil-shield-alt"/> -->
                      </template>
                    </CInput>
                    <input name="72aeb0fc-7bd8-11e5-b78d-00505693441e" type="hidden" value="securetoken" />
                    <div v-show="messaggio_errore" style="color: darkred; font-weight: bold">
                      <CAlert color="danger" closeButton>
                        Credenziali errate
                      </CAlert>
                    </div>
                    <CInput id="accedi_btn" type="submit" color="primary" class="col-sm-10 mt-0 mb-0 px-0"
                      value="Accedi">
                    </CInput>
                  </CRow>
                </form>
              </CRow>
            </div>
          </CRow>
        </CCol>
        <CCol md="4" sm="1" style="text-align: right"> </CCol>
      </CRow>
    </CContainer>
    <CFooter style="color: white; background: none; border: none">
      <div class="mfs-auto">
        <span class="mr-1" style="color: #768192"><em>Powered by Navert S.r.l.</em></span>
      </div>
    </CFooter>
  </div>
</template>

<script>
import store from "../../store";

export default {
  name: "Login",
  data() {
    return {
      jsonUtente: [],
      data_login: "",
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
    printDate: function () {
      return new Date();
    },
    getUserValue(submitEvent) {
      this.data_login = this.printDate();
      localStorage.setItem("user", submitEvent.target.elements.user.value);
      localStorage.setItem("pwd", submitEvent.target.elements.password.value);
      localStorage.setItem("lastLogin", this.data_login);
      return true;
    },
  },
};
</script>
<style scoped>
/* @import url("https://fonts.googleapis.com/css2?family=Indie+Flower&display=swap"); */
@font-face {
  font-family: Shadows;
  src: url("/img/fonts/Shadows.ttf");
}

.sfondo {
  /* background: url("/img/slide_1_bg.jpg") bottom right,
    linear-gradient(to right bottom, #1cc7d0, #013ca6, #013ca6, #1cc7d0) !important; */
  background-color: white;
  background-attachment: fixed;
  background-position: center;
  background-size: cover;
  font-family: "Montserrat", sans-serif;
  height: 100vh;
}

.login-img {
  /* position: absolute; */
  z-index: 10;

  padding-bottom: 2.5rem;
  /* margin: auto; */
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

.payoff {
  color: #ef7918;
  font-family: "Shadows";
  font-size: 2rem;
  line-height: 3rem;
}

.entra_btn {
  border-radius: 3px;
  font-weight: 400;
  width: 30%;
  background: #1f4b6b;
  border: none;
  margin: 1.5em 0 1.5em;
  outline: none;
  letter-spacing: 1px;
  font-size: 1.25em;
  padding: 14px 0;
  color: #fff;
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
  /* border: solid 1px #d8dbe07d; */
}
</style>
