<template>
  <div>
    <v-dialog v-model="editMode">
      <v-card>
        <v-card-title>Modifica {{ candidato.candidato }}</v-card-title>
        <v-card-text>
          <v-container>
            <editContatto
              :candidato="editedCandidato"
              @saveChanges="saveChanges"
              @annulla="editMode = !editMode"
            ></editContatto>
          </v-container>
        </v-card-text>
      </v-card>
    </v-dialog>

    <v-list three-line subheader>
      <v-subheader class="display-1"
        >{{ candidato.candidato }}
        <p style="margin-bottom: 0px !important; margin-left: 1rem">
          <logCandidato
            :candidato="candidato"
            @annulla="logMode = !logMode"
          ></logCandidato>
        </p>
        <p style="margin-bottom: 0px !important; margin-left: 1rem">
          <noteCandidato
            :candidato="candidato"
            @annulla="noteMode = !noteMode"
          ></noteCandidato>
        </p>
        <p style="margin-bottom: 0px !important; margin-left: 1rem">
          <v-tooltip bottom color="#1f4b6b">
            <template v-slot:activator="{ on, attrs }">
              <v-btn
                :disabled="
                  candidato.id_segnalatore &&
                  candidato.id_referente != user.idUtente
                "
                fab
                x-small
                color="white"
                v-bind="attrs"
                v-on="on"
                @click="openEditModal"
              >
                <i class="fas fa-pencil-alt fa-2x"></i>
              </v-btn>
            </template>
            <span>Modifica contatto</span>
          </v-tooltip>
        </p>
      </v-subheader>
      <v-row
        dense
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
              <v-list-item-subtitle>{{
                candidato.telefono
              }}</v-list-item-subtitle>
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
              <v-list-item-subtitle
                >{{ candidato.RUI }} (n°{{
                  candidato.numRui
                }})</v-list-item-subtitle
              >
            </v-list-item-content>
          </v-list-item>
        </v-col>
        <v-col>
          <v-list-item>
            <v-list-item-content>
              <v-list-item-title>Provenienza</v-list-item-title>
              <v-list-item-subtitle>{{
                candidato.origine
              }}</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </v-col>
      </v-row>
      <v-row>
        <v-col v-if="candidato.nome_segnalatore">
          <v-list-item>
            <v-list-item-content>
              <v-list-item-title>Segnalatore</v-list-item-title>
              <v-list-item-subtitle>{{
                candidato.nome_segnalatore
              }}</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </v-col>
        <v-col v-if="candidato.nome_segnalatore">
          <v-list-item>
            <v-list-item-content>
              <v-list-item-title>Referente Aby</v-list-item-title>
              <v-list-item-subtitle
                >{{ abyRef ? abyRef.nome : "" }}&nbsp;{{
                  abyRef ? abyRef.cognome : ""
                }}</v-list-item-subtitle
              >
            </v-list-item-content>
          </v-list-item>
        </v-col>
        <v-col v-if="candidato.facebook">
          <v-list-item>
            <v-list-item-content>
              <v-list-item-title>Profilo Facebook</v-list-item-title>
              <v-list-item-subtitle>{{
                candidato.facebook
              }}</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </v-col>
        <v-col v-if="candidato.linkedin">
          <v-list-item>
            <v-list-item-content>
              <v-list-item-title>Profilo LinkedIn</v-list-item-title>
              <v-list-item-subtitle>{{
                candidato.linkedin
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
                candidato.regione
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
import axios from "axios";
import geojson from "/public/geojson/geojson.json";
import Vue from "vue";
import * as VueGoogleMaps from "vue2-google-maps";
Vue.use(VueGoogleMaps, {
  load: {
    key: "AIzaSyDAxBrymzm6Z2HpLjSEIaVcboL42Rv2Sqs",
    libraries: "places",
  },
  installComponents: true,
});
import editContatto from "./edit.vue";
import logCandidato from "./logCandidato.vue";
import noteCandidato from "./noteCandidato.vue";
export default {
  components: {
    editContatto,
    logCandidato,
    noteCandidato,
  },
  name: "scheda",
  props: {
    candidato: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      user: JSON.parse(localStorage.getItem("chisono_data")),
      showMaps: false,
      mapCenter: { lat: 44.478214183349834, lng: 10.533467586367085 }, // Coordinatacentrale iniziale
      geojsonData: geojson,
      selectedCandidato: {},
      infoWindowOptions: { pixelOffset: { width: 0, height: -30 } },
      infoWindowOpen: false,
      editMode: false,
      editedCandidato: { ...this.candidato }, // Clonare il candidato originale
      abyRef: [],
    };
  },
  mounted() {
    this.geocodeCenter(); // Chiamata alla funzione di geocodifica
    this.getAbyRef();
  },

  methods: {
    async getAbyRef() {
      if (this.candidato["id_segnalatore"]) {
        let param = {
          idAbyRef: this.candidato["id_referente"],
        };
        try {
          await axios
            .post(
              this.$custom_json.base_url +
                this.$custom_json.api_url +
                this.$custom_json.crm.getAbyRef,
              param
            )
            .then((response) => {
              this.abyRef = response.data[0];
            });
        } catch (error) {
          console.error(error);
        }
      }
    },
    openEditModal() {
      this.editMode = true;
    },

    closeEditModal() {
      // Chiudi la modale e annulla le modifiche
      this.editMode = false;
    },

    saveChanges() {
      // Salvataggio delle modifiche
      // Esempio: Aggiorna i dati del candidato originale con i nuovi dati modificati

      this.$emit("updateCandidato");
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
