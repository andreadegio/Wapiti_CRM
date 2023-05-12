<template>
  <div class="sidebar-container">
    <div class="toggle_side">
      <button @click="toggleSidebar" class="btn_sidebar">
        <span v-show="sidebarHidden"><i class="fas fa-bars"></i></span>
        <span v-show="!sidebarHidden"><i class="fas fa-times"></i></span>
      </button>
    </div>

    <!-- Contenuto della sidebar -->
    <CNav vertical class="sidebar">
      <CNavItem>
        <div class="side_btn" @click="buttonClicked('aggiungi_candidature')">
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
            >Aggiungi candidature</span
          >
        </div>
      </CNavItem>
      <CNavItem>
        <div class="side_btn" @click="buttonClicked('primi_contatti')">
          <div
            class="side_btn_ico"
            v-c-tooltip="{
              content: 'Primi contatti',
              placement: 'right',
            }"
          >
            <i class="fas fa-people-arrows"></i>
          </div>
          <span :class="{ 'd-none': sidebarHidden }" class="side_desc"
            >Primi contatti</span
          >
        </div>
      </CNavItem>
      <CNavItem>
        <div class="side_btn" @click="buttonClicked('richiesta_documentazione')">
          <div
            class="side_btn_ico"
            v-c-tooltip="{
              content: 'Richiesta documentazione',
              placement: 'right',
            }"
          >
            <i class="fas fa-file-upload"></i>
          </div>
          <span :class="{ 'd-none': sidebarHidden }" class="side_desc"
            >Richiesta documentazione</span
          >
        </div>
      </CNavItem>
      <CNavItem>
        <div class="side_btn" @click="buttonClicked('formazione')">
          <div
            class="side_btn_ico"
            v-c-tooltip="{
              content: 'Sessioni di formazione',
              placement: 'right',
            }"
          >
            <i class="fas fa-chalkboard-teacher"></i>
          </div>
          <span :class="{ 'd-none': sidebarHidden }" class="side_desc"
            >Sessioni di formazione</span
          >
        </div>
      </CNavItem>
      <CNavItem>
        <div class="side_btn" @click="buttonClicked('registrazione_documentazione')">
          <div
            class="side_btn_ico"
            v-c-tooltip="{
              content: 'Registrazione documentazione',
              placement: 'right',
            }"
          >
            <i class="fas fa-file-download"></i>
          </div>
          <span :class="{ 'd-none': sidebarHidden }" class="side_desc"
            >Registrazione documentazione</span
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
            <i class="far fa-id-badge"></i>
          </div>
          <span :class="{ 'd-none': sidebarHidden }" class="side_desc"
            >Attivazione account operativi</span
          >
        </div>
      </CNavItem>
      <CNavItem>
        <div class="side_btn" @click="buttonClicked('follow_up')">
          <div
            class="side_btn_ico"
            v-c-tooltip="{
              content: 'Follow-up candidature',
              placement: 'right',
            }"
          >
            <i class="fas fa-headset"></i>
          </div>
          <span :class="{ 'd-none': sidebarHidden }" class="side_desc"
            >Follow-up candidature</span
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
    };
  },
  methods: {
    toggleSidebar() {
      this.sidebarHidden = !this.sidebarHidden;
    },
    buttonClicked(pulsante){
      this.$emit('showgrid', pulsante)
    }
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
.side_btn_ico {
  background-color: #1f4b6b;
  padding: 5px;
  color: white;
  font-size: 2rem;
  min-width: 50px;
  min-height: 53px;
  text-align: center;
}
.side_desc {
  margin: auto;
  padding: 5px;
  color: white;
  font-weight: 600;
}
.sidebar-container {
  width: max-content;
  height: 100%;
}
</style>