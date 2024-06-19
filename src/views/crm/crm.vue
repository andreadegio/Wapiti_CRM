<template>
  <v-app>
    <div class="container">
      <SideBar @showgrid="showGrid" />
      <div id="main" class="main">
        <!-- Contenuto principale della pagina -->
        <Stats v-if="gridType === 'default'" />
        <Grid
          v-if="
            gridType !== 'default' &&
            gridType !== 'new' &&
            gridType !== 'new_segnalatore'
          "
          :gridType="gridType"
        />
        <AddContact v-if="gridType === 'new'" @showgrid="showGrid" />
        <AddSegnalatore
          v-if="gridType === 'new_segnalatore'"
          @showgrid="showGrid"
        />
      </div>
    </div>
  </v-app>
</template>
<script>
import SideBar from "./components/SideBar.vue";
import Stats from "./components/stats.vue";
import Grid from "./components/Grid.vue";
import AddContact from "./components/Inserimento.vue";
import AddSegnalatore from "./components/Insert_segnalatore.vue";

export default {
  name: "Crm_home",
  components: {
    SideBar,
    Stats,
    Grid,
    AddContact,
    AddSegnalatore,
  },
  data() {
    return {
      gridType: "default",
    };
  },
  methods: {
    showGrid(pulsante) {
      // console.log(pulsante);
      this.gridType = pulsante;
    },
  },
};
</script>

<style scoped>
.container {
  display: flex;
  flex-direction: row;
  width: 100%;
  height: 100%;
  max-width: 100% !important;
}

.main {
  flex: 1;
  margin-left: 1rem;
  /* Stili per il contenuto principale della pagina */
}
</style>
