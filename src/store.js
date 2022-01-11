import Vue from "vue";
import Vuex from "vuex";
Vue.use(Vuex);

const state = {
  sidebarShow: "responsive",
  sidebarMinimize: false,
  utente: null,
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
    localStorage.setItem("utente", state.utente);
  },
  user_logout() {
    state.utente = "ko";
    localStorage.setItem("utente", state.utente);
    localStorage.clear();
  },
};

export default new Vuex.Store({
  state,
  mutations,
});
