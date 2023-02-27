<template>
  <div>
    <v-col class="d-flex" cols="12" sm="6">
      <v-select :items="settori" label="Settore" item-value="text" outlined>
      </v-select>
    </v-col>
    <v-col class="d-flex" cols="12" sm="6">
      <v-text-field
        v-model="oggetto"
        label="Oggetto della riunione"
        placeholder="Inserisci l'oggetto della riunione"
        outlined
      ></v-text-field>
    </v-col>
    <v-row>
      <v-col class="d-flex" cols="6" sm="3"
        ><v-menu
          v-model="menuData"
          :close-on-content-click="false"
          :nudge-right="40"
          transition="scale-transition"
          offset-y
          min-width="auto"
        >
          <template v-slot:activator="{ on, attrs }">
            <v-text-field
              v-model="formattedDataInizio"
              label="Data di inizio"
              prepend-icon="mdi-calendar"
              outlined
              v-bind="attrs"
              v-on="on"
              :value="formattedDataInizio"
            ></v-text-field>
          </template>
          <v-date-picker
            v-model="dataInizio"
            no-title
            locale="it-it"
            format="dd/MM/yyyy"
            @input="menuData = false"
          ></v-date-picker> </v-menu
      ></v-col>
      <v-col class="d-flex" cols="6" sm="3">
        <v-menu
          ref="menu"
          v-model="menuOra"
          :close-on-content-click="false"
          :nudge-right="40"
          :return-value.sync="time"
          transition="scale-transition"
          offset-y
          max-width="290px"
          min-width="290px"
        >
          <template v-slot:activator="{ on, attrs }">
            <v-text-field
              v-model="oraInizio"
              label="Orario di inizio"
              prepend-icon="mdi-clock-time-four-outline"
              outlined
              v-bind="attrs"
              v-on="on"
            ></v-text-field>
          </template>
          <v-time-picker
            v-if="menuOra"
            v-model="oraInizio"
            min="8:00"
            max="19:00"
            :allowed-minutes="slotMinuti"
            format="24hr"
            full-width
            @click:minute="$refs.menu.save(time)"
          ></v-time-picker>
        </v-menu>
      </v-col>
    </v-row>
    <!-- data e ora fine -->
    <v-row>
      <v-col class="d-flex" cols="6" sm="3"
        ><v-menu
          v-model="menuData2"
          :close-on-content-click="false"
          :nudge-right="40"
          transition="scale-transition"
          offset-y
          min-width="auto"
        >
          <template v-slot:activator="{ on, attrs }">
            <v-text-field
              v-model="formattedDataFine"
              label="Data di fine"
              prepend-icon="mdi-calendar"
              outlined
              v-bind="attrs"
              v-on="on"
              :value="formattedDataFine"
            ></v-text-field>
          </template>
          <v-date-picker
            v-model="dataFine"
            no-title
            locale="it-it"
            format="dd/MM/yyyy"
            @input="menuData2 = false"
          ></v-date-picker> </v-menu
      ></v-col>
      <v-col class="d-flex" cols="6" sm="3">
        <v-menu
          ref="menu"
          v-model="menuOra2"
          :close-on-content-click="false"
          :nudge-right="40"
          :return-value.sync="time2"
          transition="scale-transition"
          offset-y
          max-width="290px"
          min-width="290px"
        >
          <template v-slot:activator="{ on, attrs }">
            <v-text-field
              v-model="oraFine"
              label="Orario fine"
              prepend-icon="mdi-clock-time-four-outline"
              outlined
              v-bind="attrs"
              v-on="on"
            ></v-text-field>
          </template>
          <v-time-picker
            v-if="menuOra2"
            v-model="oraFine"
            min="8:00"
            max="19:00"
            :allowed-minutes="slotMinuti"
            format="24hr"
            full-width
            @click:minute="$refs.menu.save(time2)"
          ></v-time-picker>
        </v-menu>
      </v-col>
    </v-row>

    <div>
      <v-icon class="mr-2"> mdi-account-group </v-icon>
      <strong>Partecipanti</strong> ({{
        partecipanti.length > 0 ? partecipanti.length + 1 : "1"
      }})
    </div>
    <div>
      <v-list-item>
        <v-list-item-avatar
          ><v-btn class="mx-2" x-small disabled elevation="2" fab color="red">
            <v-icon dark> mdi-minus </v-icon>
          </v-btn></v-list-item-avatar
        >
        <v-list-item-content>
          <v-list-item-title class="text-capitalize">
            <strong> {{ user.Nominativo }}</strong>
            <!-- <span class="partecipazione"
              ><small><i> - Confermato -</i></small></span
            > -->
          </v-list-item-title>
          <v-list-item-subtitle> Organizzatore </v-list-item-subtitle>
        </v-list-item-content>
      </v-list-item>
      <div v-if="partecipanti.length + 1 > 1">
        <v-list-item
          three-line
          v-for="partecipante in partecipanti"
          :key="partecipante.id"
        >
          <v-list-item-avatar
            ><v-btn
              class="mx-2"
              fab
              dark
              x-small
              color="red"
              @click="rimuoviPartecipante(partecipante.id)"
            >
              <v-icon dark> mdi-minus </v-icon>
            </v-btn></v-list-item-avatar
          >
          <v-list-item-content>
            <v-list-item-title
              ><strong> {{ partecipante.nome }}</strong>
            </v-list-item-title>
            <v-list-item-subtitle>
              {{ partecipante.UO }}
            </v-list-item-subtitle>
            <v-list-item-subtitle>
              <small>{{ partecipante.email }}</small>
            </v-list-item-subtitle>
          </v-list-item-content>
        </v-list-item>
      </div>
      <v-btn color="primary" dark class="ma-2" @click="mostraModale">
        Aggiungi partecipante
      </v-btn>
    </div>

    <div class="my-4">
      <v-icon class="mr-2"> mdi-bell-ring </v-icon> <strong>Notifiche</strong>
      <div>
        <v-checkbox id="checkMail" v-model="mailCheck"
          ><template  v-slot:label style="margin-bottom: 0 !important;">
            <div class="mb-0">
              <v-icon class="mr-2"> mdi-email-fast </v-icon>Mail
            </div></template
          ></v-checkbox
        >

        <v-checkbox v-model="smsCheck"
          ><template v-slot:label style="margin-bottom: 0 !important;">
            <div>
              <v-icon class="mr-2"> mdi-message-processing </v-icon>SMS
            </div></template
          ></v-checkbox
        >
      </div>
    </div>

    <v-dialog
      persistent
      scrollable
      v-model="mostraModalePartecipanti"
      max-width="500px"
    >
      <v-card>
        <v-card-title class="text-center"> Aggiungi partecipanti</v-card-title>
        <v-card-text>
          <div class="mb-2">
            Elenco degli utenti disponibili, utilizza il filtro "unità
            operativa" oppure ricerca per nome/cognome
          </div>
          <v-row class="mt-2">
            <v-col cols="12" sm="6" md="6">
              <v-text-field
                v-model="filtroPartecipanti"
                outlined
                prepend-inner-icon="mdi-magnify"
                clearable
                
              ></v-text-field>
            </v-col>
            <v-col cols="12" sm="6" md="6">
              <v-select
                clearable
                v-model="UO"
                :items="filtroUO"
                item-value="id"
                item-text="label"
                outlined
                label="Unità operativa"
              ></v-select>
            </v-col>
          </v-row>
          <div>
            <v-list-item
              two-line
              v-for="partecipante in utentiFiltrati"
              :key="partecipante.id"
            >
              <v-list-item-avatar>
                <v-btn
                  v-if="partecipante.disponibile"
                  class="mx-2"
                  fab
                  dark
                  x-small
                  color="green"
                  @click="aggiungiPartecipante(partecipante)"
                >
                  <v-icon dark> mdi-plus </v-icon>
                </v-btn>
                <v-btn
                  v-if="!partecipante.disponibile"
                  class="mx-2"
                  fab
                  dark
                  x-small
                  color="red"
                  @click="rimuoviPartecipante(partecipante.id)"
                >
                  <v-icon dark> mdi-minus </v-icon>
                </v-btn>
              </v-list-item-avatar>
              <v-list-item-content>
                <v-list-item-title> {{ partecipante.nome }}</v-list-item-title>
                <v-list-item-subtitle
                  >({{ partecipante.UO }})</v-list-item-subtitle
                >
              </v-list-item-content>
            </v-list-item>
          </div>
        </v-card-text>
        <v-card-actions>
          <v-btn color="primary" text @click="mostraModalePartecipanti = false">
            FINE
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <v-col class="d-flex" cols="12" sm="6">
      <v-textarea
        outlined
        v-model="descrizione"
        name="input-7-4"
        label="Descrizione"
        placeholder="Descrizione dell'evento"
      ></v-textarea>
    </v-col>
  </div>
</template>
  
  <script>
export default {
  name: "nuovoAppuntamento",
  filters: {
    formatDate: function (value) {
      if (value) {
        return new Intl.DateTimeFormat("it-it", {
          year: "numeric",
          month: "2-digit",
          day: "2-digit",
        }).format(new Date(value));
      }
    },
  },
  computed: {
    formattedDataInizio: function () {
      //   console.log(this.$options.filters.formatDate(this.dataInizio));
      return this.$options.filters.formatDate(this.dataInizio);
    },
    formattedDataFine: function () {
      //   console.log(this.$options.filters.formatDate(this.dataFine));
      return this.$options.filters.formatDate(this.dataFine);
    },
    utentiFiltrati() {
      let tempUtenti = this.listaUtenti;
      //Filtro campo testuale
      if (this.filtroPartecipanti != "" && this.filtroPartecipanti) {
        tempUtenti = tempUtenti.filter((utente) =>
          utente.nome
            .toLowerCase()
            .includes(this.filtroPartecipanti.toLowerCase())
        );
      }
      //Filtro campo UO

      if (this.UO != "" && this.UO) {
        tempUtenti = tempUtenti.filter((a) => a.UO == this.UO);
      }

      return tempUtenti;
    },
  },
  data() {
    return {
      settori: [
        { text: "Veicoli" },
        { text: "Altri Rami" },
        {
          text: "Gas & Luce",
        },
      ],
      user: JSON.parse(localStorage.getItem("chisono_data")),
      oggetto: "",
      dataInizio: "",
      oraInizio: "",
      dataFine: "",
      oraFine: "",
      time: null,
      time2: null,
      menuData: false,
      menuData2: false,
      menuOra: false,
      menuOra2: false,
      partecipanti: [],
      descrizione: "",
      minDate: new Date(),
      mostraModalePartecipanti: false,
      listaUtenti: [
        {
          id: 1,
          nome: "Mario Rossi",
          email: "mario.rossi@example.com",
          UO: "Aby Point Aulla",
          disponibile: true,
        },
        {
          id: 2,
          nome: "Paolo Verdi",
          email: "paolo.verdi@example.com",
          UO: "Aby Point La Spezia",
          disponibile: true,
        },
        {
          id: 3,
          nome: "Marco Bianchi",
          email: "marco.bianchi@example.com",
          UO: "Aby Point La Spezia",
          disponibile: true,
        },
        {
          id: 4,
          nome: "Simona Neri",
          email: "simona.neri@example.com",
          UO: "Aby Point Genova",
          disponibile: true,
        },
        {
          id: 5,
          nome: "Giovanni Marrone",
          email: "giovanni.marrone@example.com",
          UO: "Aby Point La Spezia",
          disponibile: true,
        },
        {
          id: 6,
          nome: "Francesca Bianco",
          email: "francesca.bianco@example.com",
          UO: "Aby Point Sarzana",
          disponibile: true,
        },
        {
          id: 7,
          nome: "Antonio Neri",
          email: "antonio.neri@example.com",
          UO: "Aby Point Carrara",
          disponibile: true,
        },
        {
          id: 8,
          nome: "Pippo Baudo",
          email: "francesca.bianco@example.com",
          UO: "Aby Point Sarzana",
          disponibile: true,
        },
        {
          id: 9,
          nome: "Aieie Brasow",
          email: "antonio.neri@example.com",
          UO: "Aby Point Carrara",
          disponibile: true,
        },
      ],
      smsCheck: false,
      mailCheck: false,
      filtroPartecipanti: "",
      filtroUO: [],
      UO: "",
    };
  },
  methods: {
    fasciaOraria: (v) => v % 2,
    slotMinuti: (m) => m % 5 === 0,
    mostraModale() {
      this.mostraModalePartecipanti = true;
    },
    uoSelect() {
      // Utilizzato per popolare una lista univoca delle unità operative
      this.listaUtenti.forEach((element) => {
        this.filtroUO.push({ id: element.UO, label: element.UO });
      });
    },
    aggiungiPartecipante(partecipante) {
      // Imposta il parametro "disponibile" a "false" del partecipante appena aggiunto
      const partecipanteAggiunto = { ...partecipante, disponibile: false };

      // Aggiunge il partecipante alla lista dei partecipanti
      this.partecipanti.push(partecipanteAggiunto);

      // Cerca il partecipante nella lista dei partecipanti disponibili e modifica il parametro "disponibile" a "false"
      const indice = this.listaUtenti.findIndex(
        (p) => p.id === partecipante.id
      );
      if (indice !== -1) {
        this.listaUtenti[indice].disponibile = false;
      }
      //   this.mostraModalePartecipanti = false;
    },
    rimuoviPartecipante(id) {
      // Rimuove il partecipante con l'id specificato dalla lista dei partecipanti
      this.partecipanti = this.partecipanti.filter((p) => p.id !== id);

      // Cerca il partecipante nella lista dei partecipanti disponibili e modifica il parametro "disponibile" a "true"
      const indice = this.listaUtenti.findIndex((p) => p.id === id);
      if (indice !== -1) {
        this.listaUtenti[indice].disponibile = true;
      }
    },
  },
  mounted() {
    this.uoSelect();
  },
};
</script>
<style scoped>
.partecipazione {
  color: dimgrey;
}
</style>