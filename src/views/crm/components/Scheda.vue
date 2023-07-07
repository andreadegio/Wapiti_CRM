<template>
  <div>
    <v-list three-line subheader>
      <v-subheader class="display-1"
        >Candidato {{ candidato.candidate }}</v-subheader
      >
      <v-list-item>
        <v-list-item-content>
          <v-list-item-title>Provenienza</v-list-item-title>
          <v-list-item-subtitle>{{
            candidato.contact_origin
          }}</v-list-item-subtitle>
        </v-list-item-content>
      </v-list-item>
      <v-list-item>
        <v-list-item-content>
          <v-list-item-title>Tipologia</v-list-item-title>
          <v-list-item-subtitle>{{ candidato.type }}</v-list-item-subtitle>
        </v-list-item-content>
      </v-list-item>
    </v-list>
  </div>
</template>
<script>
export default {
  name: "scheda",
  props: {
    candidato: {
      type: Object,
      required: true,
    },
  },
};
</script>
<style scoped>
</style>