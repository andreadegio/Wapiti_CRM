<template>
  <v-timeline align-top dense>
    <v-timeline-item
      :color="getItemColor(item)"
      small
      v-for="item in listaNote"
      :key="item.id_note"
    >
      <v-row class="pt-1">
        <v-col cols="3">
          <strong>{{ item.data_ins | formatDate }}</strong>
        </v-col>
        <v-col>
          <strong>{{ item.fase }}</strong>
          <div class="text-caption">
            {{ item.testo }}
            <br /><cite style="font-size: 0.6rem; color: #1f4b6b !important">{{
              item.id_user_name
            }}</cite>
          </div>
        </v-col>
      </v-row>
    </v-timeline-item>
  </v-timeline>
</template>

<script>
export default {
  props: {
    candidato: {
      type: Object,
      required: true,
    },
    listaNote: {
      type: Array,
      default: () => [],
    },
  },
  data() {
    return {};
  },
  methods: {
    getItemColor(item) {
      return item.fase === "NUOVO INSERIMENTO"
        ? "green"
        : item.fase === "ELIMINATO"
        ? "red"
        : this.getTimelineColor(item);
    },
    getTimelineColor(item) {
      return this.listaNote.indexOf(item) % 2 === 0
        ? "#1f4b6b"
        : "teal lighten-3";
    },
  },
};
</script>
<style scoped>
.iscrittoRui {
  margin-top: 0px !important;
  padding-top: 0px !important;
}
.disabled_input {
  pointer-events: none;
  opacity: 0.5;
}
.nuova_origine {
  cursor: pointer;
  color: #1976d2;
  display: flex;
  vertical-align: middle;
  top: -1rem;
  position: relative;
  font-size: 1rem;
  font-weight: 500;
  /* border: 1px solid #1976d2; */
  /* border-radius: 5px; */
  padding: 0.5rem;
  padding-bottom: 0.5rem;
  padding-bottom: 0.1rem !important;
  width: fit-content;
}
</style>
