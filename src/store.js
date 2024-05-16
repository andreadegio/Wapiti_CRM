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
  userId: null, //e-learning
  loggedInUser: null, //e-learning
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

  // e-learning
  setUserId(state, id) {
    state.userId = id;
  },
  setLoggedInUser(state, user) {
    state.loggedInUser = user;
  },
  clearUserId(state) {
    state.userId = null;
  },
  clearLoggedInUser(state) {
    state.loggedInUser = null;
  },
};
const actions = {
  login({ commit }, url) {
    // Esegui la richiesta di login e ottieni i dati dell'utente
    axios.post(url).then((response) => {
      // Chiamata al server per ottenere i dati dell'utente
      const userData = response.data; // Supponendo che response.data contenga i dati dell'utente
      commit("setUser", userData); // Aggiorna lo stato dell'utente nello store
      localStorage.setItem("utente", JSON.stringify(userData)); // Salva i dati dell'utente nel localStorage
    });
  },
  logout({ commit }) {
    // Esegui il logout
    commit("clearUser"); // Pulisci i dati dell'utente nello store
    localStorage.removeItem("utente"); // Rimuovi i dati dell'utente dal localStorage
  },
};

export default new Vuex.Store({
  state,
  mutations,
  actions,
});
