<template>
  <div style="margin: 20px">
    <div><b>SELEZIONA L'AZIENDA</b></div>
    <v-radio-group v-model="azienda" row @change="$emit('switchAzienda', azienda)">
      <v-radio label="Aby Broker" color="red" value="ABY"></v-radio>
      <v-radio label="Aby Point" color="red" value="POINT"></v-radio>
      <v-radio label="Aby Store" color="red" value="STORE"></v-radio>
      <v-radio label="Aby Servizi" color="red" value="SERVIZI"></v-radio>
      <v-radio label="Aby Energy" color="red" value="ENERGY"></v-radio>
      <v-radio label="Aby Power" color="red" value="POWER"></v-radio>
      <v-radio label="Wapiti" color="red" value="WAPITI"></v-radio>
      <v-radio label="Navèrt" color="red darken-3" value="NAV"></v-radio>
      <v-radio label="Patrocinium" color="red darken-3" value="PAT"></v-radio>
    </v-radio-group>
    <div class="py-2" v-show="azienda != ''">
      <b>COMPILA CON I DATI DELL'UTENTE PER GENERARE LA FIRMA</b>
    </div>
    <v-row v-show="azienda != ''">
      <v-col cols="12" sm="6" md="3" class="p-1">
        <v-text-field label="Nome e Cognome" placeholder="Nome e Cognome" v-model="recapiti.nome"
          @change="$emit('changeRecapiti', recapiti)"></v-text-field>
      </v-col>
    </v-row>
    <v-row v-show="azienda != ''">
      <v-col cols="12" sm="6" md="3" class="p-1">
        <v-checkbox v-model="recapiti.mostra_ruolo" label="Mostra Ruolo Aziendale"
          @change="$emit('changeRecapiti', recapiti)" />
      </v-col>
      <v-col cols="12" sm="6" md="3" v-show="recapiti.mostra_ruolo" class="p-1">
        <v-text-field label="Ruolo Aziendale (riga 1)" placeholder="Ruolo Aziendale" v-model="recapiti.ruolo"
          @change="$emit('changeRecapiti', recapiti)"></v-text-field>
      </v-col>
      <v-col cols="12" sm="6" md="3" v-show="recapiti.mostra_ruolo" class="p-1">
        <v-text-field label="Ruolo Aziendale (riga 2)" placeholder="Ruolo Aziendale" v-model="recapiti.ruolo2"
          @change="$emit('changeRecapiti', recapiti)"></v-text-field>
      </v-col>
    </v-row>
    <v-row v-show="azienda != ''">
      <v-col cols="12" sm="6" md="3" class="p-1">
        <v-checkbox v-model="recapiti.sel_telefono" label="Cambia numero fisso"
          @change="$emit('changeRecapiti', recapiti)" />
        <v-text-field v-if="recapiti.sel_telefono" label="Numero di Telefono" placeholder="+39 02 86882871"
          v-model="recapiti.telefono" @change="$emit('changeRecapiti', recapiti)"></v-text-field>
      </v-col>
      <v-col cols="12" sm="6" md="3" class="p-1">
        <v-checkbox v-model="recapiti.sel_interno" label="Mostra Interno" @change="$emit('changeRecapiti', recapiti)" />
        <v-text-field v-if="recapiti.sel_interno" label="Numero interno" placeholder="300" v-model="recapiti.interno"
          @change="$emit('changeRecapiti', recapiti)"></v-text-field>
      </v-col>
      <v-col cols="12" sm="6" md="3" class="p-1">
        <v-checkbox v-model="recapiti.sel_cell" label="Mostra Cellulare" @change="$emit('changeRecapiti', recapiti)" />
        <v-text-field v-if="recapiti.sel_cell" label="Numero di Cellulare" placeholder="+39 333 3333333"
          v-model="recapiti.cellulare" @change="$emit('changeRecapiti', recapiti)"></v-text-field>
      </v-col>
      <v-col cols="12" sm="6" md="3" class="p-1">
        <v-checkbox v-model="recapiti.sel_mail" label="Mostra Mail" @change="$emit('changeRecapiti', recapiti)" />
        <v-text-field v-if="recapiti.sel_mail" label="Mail" placeholder="Mail" v-model="recapiti.mail"
          @change="$emit('changeRecapiti', recapiti)"></v-text-field>
      </v-col>
      <v-col cols="12" sm="6" md="3" class="p-1" v-if="azienda != 'POINT' || azienda != 'STORE'">
        <v-checkbox v-model="recapiti.sel_indirizzo" label="Cambia Sede Legale"
          @change="$emit('changeRecapiti', recapiti)" />
        <v-text-field v-if="recapiti.sel_indirizzo" label="Indirizzo Sede Legale"
          placeholder="Via Monte Napoleone 8, 20121 Milano (MI)" v-model="recapiti.indirizzo"
          @change="$emit('changeRecapiti', recapiti)"></v-text-field>
      </v-col>
      <v-col cols="12" sm="6" md="3" class="p-1">
        <v-checkbox v-model="recapiti.sel_operativa" label="Mostra Sede Operativa"
          @change="$emit('changeRecapiti', recapiti)" />
        <v-text-field v-if="recapiti.sel_operativa" label="Indirizzo Sede Operativa"
          placeholder="Via Monte Napoleone 8, 20121 Milano (MI)" v-model="recapiti.operativa"
          @change="$emit('changeRecapiti', recapiti)"></v-text-field>
      </v-col>
      <v-col cols="12" sm="6" md="3" class="p-1" v-if="azienda == 'POINT' || azienda == 'STORE'">
        <v-checkbox v-model="recapiti.sel_datiSoc" label="Cambia dati societari"
          @change="$emit('changeRecapiti', recapiti)" />
        <v-text-field v-if="recapiti.sel_datiSoc" label="Dati Societari"
          placeholder="Aby Broker Srl. - Partita IVA e Codice Fiscale: 00803170141 - Numero REA: MI-2057530 - Iscrizione RUI: B00137063"
          v-model="recapiti.datiSoc" @change="$emit('changeRecapiti', recapiti)"></v-text-field>
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
  props: ["recapiti"],
  data() {
    return {
      azienda: "",
    };
  },
};
</script>

<style scoped></style>
