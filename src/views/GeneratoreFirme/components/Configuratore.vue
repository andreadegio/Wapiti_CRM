<template>
  <div style="margin: 20px">
    <div><b>SELEZIONA L'AZIENDA</b></div>
    <v-radio-group
      v-model="azienda"
      row
      @change="$emit('switchAzienda', azienda)"
    >
      <v-radio label="ABY" color="red" value="ABY"></v-radio>
      <v-radio label="NAVERT" color="red darken-3" value="NAV"></v-radio>
    </v-radio-group>
    <div class="py-2" v-show="azienda != ''">
      <b>COMPILA CON I DATI DELL'UTENTE PER GENERARE LA FIRMA</b>
    </div>
    <v-row v-show="azienda != ''">
      <v-col cols="12" sm="6" md="3" class="p-1">
        <v-text-field
          label="Nome e Cognome"
          placeholder="Nome e Cognome"
          v-model="recapiti.nome"
          @change="$emit('changeRecapiti', recapiti)"
        ></v-text-field>
      </v-col>
    </v-row>
    <v-row v-show="azienda != ''">
      <v-col cols="12" sm="6" md="3" class="p-1">
        <v-checkbox
          v-model="recapiti.mostra_ruolo"
          label="Mostra Ruolo Aziendale"
          @change="$emit('changeRecapiti', recapiti)"
        />
      </v-col>
      <v-col cols="12" sm="6" md="3" v-show="recapiti.mostra_ruolo" class="p-1">
        <v-text-field
          label="Ruolo Aziendale (riga 1)"
          placeholder="Ruolo Aziendale"
          v-model="recapiti.ruolo"
          @change="$emit('changeRecapiti', recapiti)"
        ></v-text-field>
      </v-col>
      <v-col cols="12" sm="6" md="3" v-show="recapiti.mostra_ruolo" class="p-1">
        <v-text-field
          label="Ruolo Aziendale (riga 2)"
          placeholder="Ruolo Aziendale"
          v-model="recapiti.ruolo2"
          @change="$emit('changeRecapiti', recapiti)"
        ></v-text-field>
      </v-col>
    </v-row>
    <v-row v-show="azienda != ''">
      <v-col cols="12" sm="6" md="3" class="p-1">
        <v-checkbox
          v-model="recapiti.sel_telefono"
          label="Cambia numero fisso"
          @change="$emit('changeRecapiti', recapiti)"
        />
        <v-text-field
          v-if="recapiti.sel_telefono"
          label="Numero di Telefono"
          placeholder="+39 02 86882871"
          v-model="recapiti.telefono"
          @change="$emit('changeRecapiti', recapiti)"
        ></v-text-field>
      </v-col>
      <v-col cols="12" sm="6" md="3" class="p-1">
        <v-checkbox
          v-model="recapiti.sel_interno"
          label="Mostra Interno"
          @change="$emit('changeRecapiti', recapiti)"
        />
        <v-text-field
          v-if="recapiti.sel_interno"
          label="Numero interno"
          placeholder="300"
          v-model="recapiti.interno"
          @change="$emit('changeRecapiti', recapiti)"
        ></v-text-field>
      </v-col>
      <v-col cols="12" sm="6" md="3" class="p-1">
        <v-checkbox
          v-model="recapiti.sel_cell"
          label="Mostra Cellulare"
          @change="$emit('changeRecapiti', recapiti)"
        />
        <v-text-field
          v-if="recapiti.sel_cell"
          label="Numero di Cellulare"
          placeholder="+39 333 3333333"
          v-model="recapiti.cellulare"
          @change="$emit('changeRecapiti', recapiti)"
        ></v-text-field>
      </v-col>
      <v-col cols="12" sm="6" md="3" class="p-1">
        <v-checkbox
          v-model="recapiti.sel_mail"
          label="Mostra Mail"
          @change="$emit('changeRecapiti', recapiti)"
        />
        <v-text-field
          v-if="recapiti.sel_mail"
          label="Mail"
          placeholder="Mail"
          v-model="recapiti.mail"
          @change="$emit('changeRecapiti', recapiti)"
        ></v-text-field>
      </v-col>
      <v-col cols="12" sm="6" md="3" class="p-1">
        <v-checkbox
          v-model="recapiti.sel_indirizzo"
          label="Cambia Sede Legale"
          @change="$emit('changeRecapiti', recapiti)"
        />
        <v-text-field
          v-if="recapiti.sel_indirizzo"
          label="Indirizzo Sede Legale"
          placeholder="Via Monte Napoleone 8, 20121 Milano (MI)"
          v-model="recapiti.indirizzo"
          @change="$emit('changeRecapiti', recapiti)"
        ></v-text-field>
      </v-col>
      <v-col cols="12" sm="6" md="3" class="p-1">
        <v-checkbox
          v-model="recapiti.sel_operativa"
          label="Mostra Sede Operativa"
          @change="$emit('changeRecapiti', recapiti)"
        />
        <v-text-field
          v-if="recapiti.sel_operativa"
          label="Indirizzo Sede Operativa"
           placeholder="Via Monte Napoleone 8, 20121 Milano (MI)"
          v-model="recapiti.operativa"
          @change="$emit('changeRecapiti', recapiti)"
        ></v-text-field>
      </v-col>
    </v-row>
  </div>
</template>

<script>
export default {
  name: "Configuratore",
  emits: [
    "switchAzienda",
    "changeNome",
    "changeMostraRuolo",
    "changeRuolo",
    "changeRuolo2",
    "changeRecapiti",
  ],
  props:["recapiti"],
  data() {
    return {
      azienda: "",
      // nome: "",
      // ruolo: "",
      // ruolo2: "",
      // mostra_ruolo: false,
      // recapiti: {
      //   sel_telefono: false,
      //   telefono: "",
      //   sel_interno: false,
      //   interno: "",
      //   sel_cell: false,
      //   cellulare: "",
      //   sel_mail: true,
      //   mail: "Mail",
      //   sel_indirizzo: false,
      //   indirizzo: "",
      // },
    };
  },
};
</script>

<style scoped>
</style>
