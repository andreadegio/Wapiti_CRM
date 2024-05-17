import Vue from "vue";
import Vuex from "vuex";
import axios from "axios";

Vue.use(Vuex);

const state = {
  sidebarShow: "responsive",
  sidebarMinimize: false,
  utente: null,
  aree: [],
  url_versione: "",
};

const mutations = {
  toggleSidebarDesktop(state) {
    const sidebarOpened = [true, "responsive"].includes(state.sidebarShow);
    state.sidebarShow = sidebarOpened ? false : "responsive";
  },
  toggleSidebarMobile(state) {
    const sidebarClosed = [false, "responsive"].includes(state.sidebarShow);
    state.sidebarShow = sidebarClosed ? true : "responsive";
  },
  set(state, [variable, value]) {
    state[variable] = value;
  },
  user_login(state, url) {
    state.utente = "ok";
    axios.post(url).then((response) => {
      // console.log("versione " + response.data);
      localStorage.setItem("versione", response.data);
    });
    localStorage.setItem("utente", state.utente);
  },
  user_logout() {
    state.utente = "ko";
    localStorage.setItem("utente", state.utente);
    localStorage.clear();
  },
  lista_aree(state, payload) {
    state.aree = payload;
  },
};

export default new Vuex.Store({
  state,
  mutations,
});
