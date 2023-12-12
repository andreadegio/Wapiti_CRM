<template>
  <div>
    <v-tooltip bottom color="#1f4b6b">
      <template v-slot:activator="{ on, attrs }">
        <v-btn
          color="primary"
          fab
          x-small
          class="ml-2"
          v-bind="attrs"
          v-on="on"
          @click="openNoteModal"
        >
          <i class="far fa-edit fa-2x"></i>
        </v-btn>
      </template>
      <span>Visualizza Note</span>
    </v-tooltip>
    <v-dialog v-model="noteMode" width="600px">
      <v-card>
        <v-card-title> </v-card-title>
        <v-card-text>
          <span class="text-h5"
            >Aggiungi una nota per {{ candidato.candidato }}</span
          >
          <v-container>
            <v-textarea rows="4" outlined v-model="nota"></v-textarea>
            <v-card-actions
              ><v-spacer></v-spacer>
              <v-btn
                outlined
                color="blue-grey"
                text
                @click="
                  noteMode = !noteMode;
                  nota = '';
                "
              >
                <i class="fas fa-times"></i>&nbsp; chiudi
              </v-btn>

              <v-btn
                align-end
                color="#1f4b6b"
                dark
                @click="saveNote"
                :class="{ disabled_input: isSaveButtonDisabled }"
                ><i class="far fa-save"></i> &nbsp; Salva
              </v-btn>
            </v-card-actions>
          </v-container>
          <v-divider> </v-divider>
          <span class="text-h5">Storico delle note inserite:</span>
          <v-timeline align-top dense>
            <v-timeline-item
              :color="getItemColor(item)"
              small
              v-for="item in noteData"
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
                    <br /><cite
                      style="font-size: 0.6rem; color: #1f4b6b !important"
                      >{{ item.id_user_name }}</cite
                    >
                  </div>
                </v-col>
              </v-row>
            </v-timeline-item>
          </v-timeline>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import axios from "axios";
export default {
  props: {
    candidato: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      noteMode: false,
      noteData: [],
      nota: "",
    };
  },
  computed: {
    isSaveButtonDisabled() {
      if (this.nota) {
        return false;
      }
      return true;
    },
  },
  methods: {
    resetNote() {
      this.nota = "";
    },
    async saveNote() {
      let params = {
        note: this.nota,
        fase: "Inserimento Manuale",
        idAnagrafica: this.candidato.id_anagrafica,
        utente: JSON.parse(localStorage.getItem("chisono_data")),
      };
      try {
        await axios
          .post(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.crm.insertNota,
            params
          )
          .then((response) => {
            var message = response.data.message;
            switch (response.data.esito) {
              case "OK":
                this.$alert(message, "OK", "success");
                this.openNoteModal();
                this.resetNote();
                break;
              case "KO":
                this.$alert(message, "Attenzione", "warning");
                break;
            }
          });
      } catch (error) {
        console.log(error);
      }
      this.dialog = false;
    },
    async openNoteModal() {
      let params = {
        idAnagrafica: this.candidato.id_anagrafica,
      };
      try {
        const response = await axios.post(
          this.$custom_json.base_url +
            this.$custom_json.api_url +
            this.$custom_json.crm.getNoteByIdAnagrafica,
          params
        );
        this.noteData = response.data;
        this.noteMode = true;
      } catch (error) {
        console.error("Errore durante il recupero dei log:", error);
      }
    },
    getItemColor(item) {
      return item.fase === "NUOVO INSERIMENTO"
        ? "green"
        : item.fase === "ELIMINATO"
        ? "red"
        : this.getTimelineColor(item);
    },
    getTimelineColor(item) {
      return this.noteData.indexOf(item) % 2 === 0
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
