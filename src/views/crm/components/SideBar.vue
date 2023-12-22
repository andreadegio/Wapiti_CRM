<template>
  <div class="sidebar-container">
    <div class="toggle_side">
      <button @click="toggleSidebar" class="btn_sidebar">
        <span v-show="sidebarHidden"><i class="fas fa-bars"></i></span>
        <span v-show="!sidebarHidden"
          ><i class="fas fa-angle-double-left"></i
        ></span>
      </button>
    </div>

    <CNav vertical class="sidebar" v-if="userCRMInfo.idRuolo == 6">
      <CNavItem>
        <div class="side_btn" @click="buttonClicked('new_segnalatore')">
          <div
            class="side_btn_ico"
            v-c-tooltip="{
              content: 'Aggiungi candidature',
              placement: 'right',
            }"
          >
            <i class="fas fa-user-plus"></i>
          </div>
          <span :class="{ 'd-none': sidebarHidden }" class="side_desc"
            >Aggiungi candidato</span
          >
        </div>
      </CNavItem>
      <CNavItem>
        <div class="side_btn" @click="buttonClicked('utenti_attivi')">
          <div
            class="side_btn_ico"
            v-c-tooltip="{
              content: 'Utenti attivi',
              placement: 'right',
            }"
          >
            <i class="fas fa-users"></i>
          </div>
          <span :class="{ 'd-none': sidebarHidden }" class="side_desc"
            >Utenti attivati</span
          >
        </div>
      </CNavItem>
      <CNavItem>
        <div class="side_btn" @click="buttonClicked('ricerca')">
          <div
            class="side_btn_ico"
            v-c-tooltip="{
              content: 'Utenti attivi',
              placement: 'right',
            }"
          >
            <i class="fas fa-search"></i>
          </div>
          <span :class="{ 'd-none': sidebarHidden }" class="side_desc"
            >Ricerca</span
          >
        </div>
      </CNavItem>
      <CNavItem>
        <div class="side_btn_deleted" @click="buttonClicked('eliminati')">
          <div
            class="side_btn_ico_deleted"
            v-c-tooltip="{
              content: 'Eliminati',
              placement: 'right',
            }"
          >
            <i class="far fa-trash-alt"></i>
          </div>
          <span :class="{ 'd-none': sidebarHidden }" class="side_desc"
            >Rifiutati</span
          >
        </div>
      </CNavItem>
    </CNav>
    <CNav vertical class="sidebar" v-if="userCRMInfo.idRuolo != 6">
      <CNavItem>
        <div class="side_btn" @click="buttonClicked('new')">
          <div
            class="side_btn_ico"
            v-c-tooltip="{
              content: 'Aggiungi candidature',
              placement: 'right',
            }"
          >
            <i class="fas fa-user-plus"></i>
          </div>
          <span :class="{ 'd-none': sidebarHidden }" class="side_desc"
            >Aggiungi candidato</span
          >
        </div>
      </CNavItem>
      <CNavItem>
        <div class="side_btn" @click="buttonClicked('primo_contatto')">
          <div
            class="side_btn_ico"
            v-c-tooltip="{
              content: 'Primo contatto',
              placement: 'right',
            }"
          >
            <i class="fas fa-people-arrows"></i>
          </div>
          <span :class="{ 'd-none': sidebarHidden }" class="side_desc"
            >Primo contatto</span
          >
        </div>
      </CNavItem>
      <CNavItem>
        <div class="side_btn" @click="buttonClicked('social')">
          <div
            class="side_btn_ico"
            v-c-tooltip="{
              content: 'Social / Email',
              placement: 'right',
            }"
          >
            <i class="fas fa-share-alt"></i>
          </div>
          <span :class="{ 'd-none': sidebarHidden }" class="side_desc"
            >Social / Email</span
          >
        </div>
      </CNavItem>
      <CNavItem>
        <div class="side_btn" @click="buttonClicked('webinar')">
          <div
            class="side_btn_ico"
            v-c-tooltip="{
              content: 'Mini webinar',
              placement: 'right',
            }"
          >
            <i class="fas fa-desktop"></i>
          </div>
          <span :class="{ 'd-none': sidebarHidden }" class="side_desc"
            >Mini webinar</span
          >
        </div>
      </CNavItem>
      <CNavItem>
        <div class="side_btn" @click="buttonClicked('solleciti')">
          <div
            class="side_btn_ico"
            v-c-tooltip="{
              content: 'Chiamate di cortesia',
              placement: 'right',
            }"
          >
            <i class="fas fa-phone-volume"></i>
          </div>
          <span :class="{ 'd-none': sidebarHidden }" class="side_desc"
            >Chiamate di cortesia</span
          >
        </div>
      </CNavItem>

      <CNavItem>
        <div
          class="side_btn"
          @click="buttonClicked('registrazione_documentazione')"
        >
          <div
            class="side_btn_ico"
            v-c-tooltip="{
              content: 'Registrazione documenti',
              placement: 'right',
            }"
          >
            <i class="fas fa-file-signature"></i>
          </div>
          <span :class="{ 'd-none': sidebarHidden }" class="side_desc"
            >Registrazione documenti</span
          >
        </div>
      </CNavItem>
      <CNavItem>
        <div class="side_btn" @click="buttonClicked('formazione')">
          <div
            class="side_btn_ico"
            v-c-tooltip="{
              content: 'Formazione',
              placement: 'right',
            }"
          >
            <i class="fas fa-chalkboard-teacher"></i>
          </div>
          <span :class="{ 'd-none': sidebarHidden }" class="side_desc"
            >Formazione</span
          >
        </div>
      </CNavItem>

      <CNavItem>
        <div class="side_btn" @click="buttonClicked('attivazione_account')">
          <div
            class="side_btn_ico"
            v-c-tooltip="{
              content: 'Attivazione account',
              placement: 'right',
            }"
          >
            <i class="fas fa-user-check"></i>
          </div>
          <span :class="{ 'd-none': sidebarHidden }" class="side_desc"
            >Attivazione account</span
          >
        </div>
      </CNavItem>
      <!-- <CNavItem>
        <div class="side_btn" @click="buttonClicked('follow_up')">
          <div
            class="side_btn_ico"
            v-c-tooltip="{
              content: 'Follow-up',
              placement: 'right',
            }"
          >
            <i class="fas fa-headset"></i>
          </div>
          <span :class="{ 'd-none': sidebarHidden }" class="side_desc"
            >Follow-up</span
          >
        </div>
      </CNavItem> -->
      <CNavItem>
        <div class="side_btn" @click="buttonClicked('utenti_attivi')">
          <div
            class="side_btn_ico"
            v-c-tooltip="{
              content: 'Utenti attivi',
              placement: 'right',
            }"
          >
            <i class="fas fa-users"></i>
          </div>
          <span :class="{ 'd-none': sidebarHidden }" class="side_desc"
            >Utenti attivati</span
          >
        </div>
      </CNavItem>
      <CNavItem>
        <div class="side_btn" @click="buttonClicked('ricerca')">
          <div
            class="side_btn_ico"
            v-c-tooltip="{
              content: 'Utenti attivi',
              placement: 'right',
            }"
          >
            <i class="fas fa-search"></i>
          </div>
          <span :class="{ 'd-none': sidebarHidden }" class="side_desc"
            >Ricerca</span
          >
        </div>
      </CNavItem>
      <CNavItem>
        <div class="side_btn_deleted" @click="buttonClicked('eliminati')">
          <div
            class="side_btn_ico_deleted"
            v-c-tooltip="{
              content: 'Eliminati',
              placement: 'right',
            }"
          >
            <i class="far fa-trash-alt"></i>
          </div>
          <span :class="{ 'd-none': sidebarHidden }" class="side_desc"
            >Rifiutati</span
          >
        </div>
      </CNavItem>
    </CNav>
  </div>
</template>
<script>
export default {
  name: "SideBar",

  data() {
    return {
      sidebarHidden: false,
      sidebarDisplay: "lg",
      userCRMInfo: JSON.parse(localStorage.getItem("userCRMInfo")),
    };
  },
  methods: {
    toggleSidebar() {
      this.sidebarHidden = !this.sidebarHidden;
    },
    buttonClicked(pulsante) {
      this.$emit("showgrid", pulsante);
    },
  },
};
</script>

<style scoped>
.btn_sidebar {
  background-color: transparent;
  border: none;
  cursor: pointer;
  padding: 0 0.5rem 0 1rem;
}

.toggle_side {
  text-align: right;
  margin-right: 1rem;
  font-size: 1rem;
}
.side_btn {
  display: flex;
  border: 1px solid #1f4b6b;
  background-color: #1f4b6b7a;
}
.side_btn_deleted {
  display: flex;
  border: 1px solid darkred;
  background-color: rgb(123, 83, 83);
}
.side_btn_ico {
  background-color: #1f4b6b;
  padding: 5px;
  color: white;
  font-size: 1.3rem;
  min-width: 40px;
  min-height: 40px;
  text-align: center;
}
.side_btn_ico_deleted {
  background-color: darkred;
  padding: 5px;
  color: white;
  font-size: 1.3rem;
  min-width: 40px;
  min-height: 40px;
  text-align: center;
}
.side_desc {
  margin: auto;
  padding: 5px;
  color: white;
  font-weight: 600;
  font-size: 0.9rem;
}
.sidebar-container {
  width: max-content;
  height: 100%;
}
</style>
