<template>
  <div>
    <v-dialog v-model="editMode">
      <v-card>
        <v-card-title>Modifica Contatto</v-card-title>
        <v-card-text>
          <v-container>
            <v-row v-for="(value, key) in editedCandidato" :key="key">
              <v-col cols="6">
                <v-text-field
                  outlined
                  v-if="key !== 'id_anagrafica'"
                  v-model="editedCandidato[key]"
                  :label="key"
                ></v-text-field>
              </v-col>
            </v-row>
          </v-container>
        </v-card-text>
        <v-card-actions>
          <v-btn color="primary" @click="saveChanges">Salva</v-btn>
          <v-btn @click="closeEditModal">Annulla</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <v-list three-line subheader>
      <v-subheader class="display-1"
        >{{ candidato.candidato }}
        <!-- <v-btn color="warning" fab x-small dark class="ml-2">
          <v-icon>mdi-alarm</v-icon>
        </v-btn> -->
        <p style="margin-bottom: 0px !important; margin-left: 1rem">
          <v-tooltip bottom color="#1f4b6b">
            <template v-slot:activator="{ on, attrs }">
              <v-btn
                small
                icon
                outlined
                color="#1f4b6b"
                v-bind="attrs"
                v-on="on"
                @click="openEditModal"
              >
                <i class="fas fa-pencil-alt"></i>
              </v-btn>
            </template>
            <span>Modifica contatto</span>
          </v-tooltip>
        </p>
      </v-subheader>
      <v-row
        class="mt-2"
        style="background-color: #b2dfdb; border-radius: 10px"
      >
        <v-col v-if="candidato.tipologia === 'PG'"
          ><v-list-item>
            <v-list-item-content>
              <v-list-item-title>Referente</v-list-item-title>
              <v-list-item-subtitle>{{
                candidato.referente
              }}</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </v-col>
        <v-col>
          <v-list-item>
            <v-list-item-content>
              <v-list-item-title>Telefono</v-list-item-title>
              <v-list-item-subtitle>{{ candidato.tel }}</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </v-col>
        <v-col>
          <v-list-item>
            <v-list-item-content>
              <v-list-item-title>Cellulare</v-list-item-title>
              <v-list-item-subtitle>{{ candidato.cell }}</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </v-col>
        <v-col>
          <v-list-item>
            <v-list-item-content>
              <v-list-item-title>Mail</v-list-item-title>
              <v-list-item-subtitle>{{ candidato.mail }}</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </v-col>
      </v-row>

      <v-row>
        <v-col>
          <v-list-item>
            <v-list-item-content>
              <v-list-item-title>Tipologia</v-list-item-title>

              <v-list-item-subtitle v-if="candidato.tipologia === 'PF'"
                ><i class="far fa-user"></i>
                Persona Fisica
              </v-list-item-subtitle>
              <v-list-item-subtitle v-else-if="candidato.tipologia === 'PG'"
                ><i class="far fa-building"></i> Persona
                Giuridica</v-list-item-subtitle
              >
            </v-list-item-content>
          </v-list-item>
        </v-col>
        <v-col>
          <v-list-item>
            <v-list-item-content v-if="candidato.tipologia === 'PF'">
              <v-list-item-title>Codice Fiscale</v-list-item-title>
              <v-list-item-subtitle>{{ candidato.cf }}</v-list-item-subtitle>
            </v-list-item-content>
            <v-list-item-content v-else-if="candidato.tipologia === 'PG'">
              <v-list-item-title>Partita IVA</v-list-item-title>
              <v-list-item-subtitle>{{ candidato.piva }}</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </v-col>
        <v-col>
          <v-list-item>
            <v-list-item-content>
              <v-list-item-title>Iscrizione RUI</v-list-item-title>
              <v-list-item-subtitle>{{ candidato.type }}</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </v-col>
        <v-col>
          <v-list-item>
            <v-list-item-content>
              <v-list-item-title>Provenienza</v-list-item-title>
              <v-list-item-subtitle>{{
                candidato.contact_origin
              }}</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </v-col>
      </v-row>
      <v-row>
        <v-col>
          <v-list-item>
            <v-list-item-content>
              <v-list-item-title>Regione</v-list-item-title>
              <v-list-item-subtitle>{{
                candidato.region
              }}</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </v-col>
        <v-col>
          <v-list-item>
            <v-list-item-content>
              <v-list-item-title>Provincia</v-list-item-title>
              <v-list-item-subtitle>{{
                candidato.provincia
              }}</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </v-col>
        <v-col>
          <v-list-item>
            <v-list-item-content>
              <v-list-item-title>Cap e Comune</v-list-item-title>
              <v-list-item-subtitle>{{
                candidato.cap != 0
                  ? candidato.cap + " " + candidato.comune
                  : "" + " " + candidato.comune
              }}</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </v-col>
        <v-col>
          <v-list-item>
            <v-list-item-content>
              <v-list-item-title>Indirizzo</v-list-item-title>
              <v-list-item-subtitle
                >{{ candidato.via + " " + candidato.civico }}
                <span
                  v-if="indirizzo_completo(candidato)"
                  v-show="!showMaps"
                  style="
                    margin-bottom: 0px !important;
                    margin-left: 1rem;
                    cursor: pointer;
                    color: #1f4b6b;
                  "
                  @click="toggleMapDisplay"
                >
                  <v-tooltip bottom color="#1f4b6b">
                    <template v-slot:activator="{ on, attrs }">
                      <v-btn
                        small
                        icon
                        outlined
                        color="#1f4b6b"
                        v-bind="attrs"
                        v-on="on"
                      >
                        <i class="fas fa-map-marker-alt"></i>
                      </v-btn>
                    </template>
                    <span
                      >{{ showMaps ? "Nascondi Maps" : "Localizza su Maps" }}
                    </span>
                  </v-tooltip>
                </span>
                <span
                  v-if="indirizzo_completo(candidato) && showMaps"
                  style="
                    margin-bottom: 0px !important;
                    margin-left: 1rem;
                    cursor: pointer;
                    color: #1f4b6b;
                  "
                  @click="toggleMapDisplay"
                >
                  <v-tooltip bottom v-if="showMaps" color="#1f4b6b">
                    <template v-slot:activator="{ on, attrs }">
                      <v-btn
                        small
                        icon
                        outlined
                        color="#1f4b6b"
                        v-bind="attrs"
                        v-on="on"
                      >
                        <i class="fas fa-eye-slash"></i>
                      </v-btn>
                    </template>
                    <span
                      >{{ showMaps ? "Nascondi Maps" : "Localizza su Maps" }}
                    </span>
                  </v-tooltip>
                </span>
              </v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </v-col>
      </v-row>
    </v-list>
    <div v-if="showMaps">
      <gmap-map
        :center="mapCenter"
        :zoom="12"
        style="width: 100%; height: 400px"
      >
        <!-- Aggiungi marker personalizzati dai dati GeoJSON -->
        <gmap-marker
          v-for="(feature, index) in geojsonData.features"
          :key="index"
          :position="getCoordinates(feature.geometry)"
          :icon="getCustomMarkerIcon(feature.properties)"
          :title="feature.properties.DESCRIZIONE"
        />
        <gmap-marker :position="mapCenter" :title="candidato.candidato" />
      </gmap-map>
    </div>
  </div>
</template>
<script>
import geojson from "./../../../../public/geojson/geojson.json";
import Vue from "vue";
import * as VueGoogleMaps from "vue2-google-maps";
Vue.use(VueGoogleMaps, {
  load: {
    key: "AIzaSyDAxBrymzm6Z2HpLjSEIaVcboL42Rv2Sqs",
    libraries: "places",
  },
  installComponents: true,
});
export default {
  name: "scheda",
  props: {
    candidato: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      showMaps: false,
      mapCenter: { lat: 44.478214183349834, lng: 10.533467586367085 }, // Coordinatacentrale iniziale
      geojsonData: geojson,
      selectedCandidato: {},
      infoWindowOptions: { pixelOffset: { width: 0, height: -30 } },
      infoWindowOpen: false,
      editMode: false,
      editedCandidato: { ...this.candidato }, // Clonare il candidato originale
    };
  },
  mounted() {
    this.geocodeCenter(); // Chiamata alla funzione di geocodifica
  },

  methods: {
    openEditModal() {
      this.editMode = true;
    },
    closeEditModal() {
      // Chiudi la modale e annulla le modifiche
      this.editMode = false;
      this.editedCandidato = { ...this.candidato }; // Reimposta i dati modificati ai valori originali
    },
    saveChanges() {
      // Salvataggio delle modifiche
      // Esempio: Aggiorna i dati del candidato originale con i nuovi dati modificati
      this.candidato = { ...this.editedCandidato };
      this.editMode = false; // Chiudi la modale dopo il salvataggio
    },
    indirizzo_completo(candidato) {
      if (candidato.via || candidato.comune || candidato.provincia) {
        return true;
      } else {
        return false;
      }
    },
    toggleMapDisplay() {
      this.showMaps = !this.showMaps; // Cambia lo stato di visualizzazione della mappa
    },
    geocodeCenter() {
      const addressStr = `${this.candidato.via} ${this.candidato.civico}, ${this.candidato.cap} ${this.candidato.comune}`;
      // console.log(addressStr);
      this.$gmapApiPromiseLazy().then(() => {
        const geocoder = new window.google.maps.Geocoder();
        geocoder.geocode({ address: addressStr }, (results, status) => {
          if (status === "OK" && results[0].geometry) {
            this.mapCenter = results[0].geometry.location.toJSON();
          }
        });
      });
    },
    getCoordinates(geometry) {
      return {
        lat: geometry.coordinates[1],
        lng: geometry.coordinates[0],
      };
    },
    getCustomMarkerIcon(properties) {
      const tipologiaDiRapporto = properties["TIPOLOGIA DI RAPPORTO"];

      if (tipologiaDiRapporto === "AbyPoint") {
        // Restituisci l'immagine personalizzata per "AbyPoint"
        return {
          url: "/img/maps/marker_aby.png",
          // size: new google.maps.Size(30, 30),
        };
      } else if (tipologiaDiRapporto === "AbyPartner") {
        // Restituisci l'immagine personalizzata per "AbyPartner"
        return {
          url: "/img/maps/marker_partner.png",
          // size: new google.maps.Size(30, 30),
        };
      } else {
        // Icona di fallback se il valore non corrisponde a nessuna delle opzioni sopra
        return {
          url: "/img/maps/marker_aby.png",
          // size: new google.maps.Size(30, 30),
        };
      }
    },
    showInfo(candidato) {
      this.selectedCandidato = candidato;
      this.infoWindowOpen = true;
    },
  },
};
</script>
<style scoped>
.col {
  padding: 0 !important;
}
.gmap-marker img {
  width: 30px !important;
  height: 30px !important;
}
.disabled_input {
  pointer-events: none;
  opacity: 0.5;
}
</style>
