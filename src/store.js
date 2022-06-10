import Vue from "vue";
import Vuex from "vuex";
Vue.use(Vuex);

const state = {
  sidebarShow: "responsive",
  sidebarMinimize: false,
  utente: null,
  versione:null,
  aree:[],
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
  user_login() {
    state.utente = "ok";
    state.versione=1;
    localStorage.setItem("utente", state.utente);
    localStorage.setItem("versione", state.versione);
  },
  user_logout() {
    state.utente = "ko";
    localStorage.setItem("utente", state.utente);
    localStorage.clear();
  },
  lista_aree(state, payload){
      state.aree= payload
  }
};

export default new Vuex.Store({
  state,
  mutations,
});
