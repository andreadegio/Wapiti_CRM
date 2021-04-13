<template>
  <div class="c-app flex-row align-items-center sfondo_gradiente">
    <CContainer>
      <h1 class="display-3 text-center" style="color: white">
        Benvenuti in
        <img class="login-img" src="img/abyway_logo.png" />
      </h1>
      <br />
      <div id="scritta"><hr /></div>
      <CRow class="justify-content-center">
        <CCol md="1"> </CCol>
        <CCol md="4">
          <CCardGroup class="pt-5">
            <CCard
              id="gruppo_card"
              class="p-4"
              style="
                background-color: #012f82;
                color: white;
                color: white;
                box-shadow: 5px 5px 7px 0px rgba(0, 0, 0, 0.4);
              "
            >
              <CCardBody
                style="
                  background-color: #012f82;
                  color: white;
                  border-color: #3c74d0;
                "
              >
                <div
                  v-show="messaggio_errore"
                  style="color: darkred; font-weight: bold"
                >
                  <CAlert color="danger" closeButton>
                    Credenziali errate
                  </CAlert>
                </div>
               
                <form
                  @submit="getUserValue"
                  :action="login_url"
                  method="post"
                >
                  <CRow align-horizontal="center" class="pb-3">
                    <span class="h2"> ACCEDI</span>
                  </CRow>
                  <CRow align-horizontal="center">
                    <CInput
                      id="user"
                      class="col-sm-10 pl-0 pr-0"
                      placeholder="Username"
                      name="user"
                      size="lg"
                    >
                      <template #prepend-content
                        ><CIcon name="cil-user"
                      /></template>
                    </CInput>
                  </CRow>
                  <CRow align-horizontal="center">
                    <CInput
                      id="password"
                      class="col-sm-10 pl-0 pr-0"
                      placeholder="Password"
                      type="password"
                      autocomplete="current-password"
                      name="password"
                      size="lg"
                    >
                      <template #prepend-content
                        ><CIcon name="cil-shield-alt"
                      /></template>
                    </CInput>
                    <input
                      name="72aeb0fc-7bd8-11e5-b78d-00505693441e"
                      type="hidden"
                      value="securetoken"
                    />
                  </CRow>
                  <CRow align-horizontal="center">
                    <input
                      class="entra_btn col-sm-10"
                      type="submit"
                      value="Entra"
                    />
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
import { config_data } from "../../../public/config/config";
// import axios from "axios";

export default {
  name: "Login",
  data() {
    return {
      jsonUtente: [],
      messaggio_errore: false,
      login_url: config_data.login_url,
    };
  },
  created() {
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
@import url("https://fonts.googleapis.com/css2?family=Indie+Flower&display=swap");
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
  font-size: 2em;
  position: relative;
  left: -0.5em;
  font-family: "Indie Flower", cursive;
  padding-top: 5px;
  padding-left: 1em;
  padding-right: 1em;
}

.entra_btn {
  border-radius: 3px;
  font-weight: bold;
  width: 30%;
  background: #19b9cc;
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
  background: #00e5ff;
}
</style>