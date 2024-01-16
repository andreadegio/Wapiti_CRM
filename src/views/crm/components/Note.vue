<template>
  <v-dialog v-model="dialog" persistent max-width="600px">
    <template v-slot:activator="{ on, attrs }">
      <v-btn color="blue-grey" dark v-bind="attrs" v-on="on" class="ml-2">
        <i class="far fa-edit"></i>&nbsp;Note
      </v-btn>
    </template>
    <v-card>
      <v-card-title>
        <span class="text-h5">Aggiungi una nota per {{ candidato }}</span>
      </v-card-title>
      <v-card-text>
        <v-container>
          <v-textarea rows="4" outlined v-model="nota"></v-textarea>
        </v-container>
      </v-card-text>
      <v-card-actions>
        <v-spacer></v-spacer>
        <CButton
          class="mx-2"
          color="danger"
          @click="
            dialog = false;
            resetNote();
          "
          variant="ghost"
          ><i class="fas fa-times"></i>&nbsp; Annulla
        </CButton>
        <v-btn
          color="#1f4b6b"
          dark
          @click="saveNote"
          :class="{ disabled_input: isSaveButtonDisabled }"
          ><i class="far fa-save"></i> &nbsp; Salva
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script>
import axios from "axios";
export default {
  name: "Note",

  props: {
    itemId: {
      type: Number,
      required: true,
    },
    candidato: {
      type: String,
      required: true,
    },
  },
  computed: {
    isSaveButtonDisabled() {
      if (this.nota) {
        return false;
      }
      return true;
    },
  },
  data() {
    return {
      dialog: false,
      nota: "",
    };
  },
  methods: {
    resetNote() {
      this.nota = "";
    },
    async saveNote() {
      let params = {
        note: this.nota,
        fase: "Inserimento Manuale",
        idAnagrafica: this.itemId,
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
  },
};
</script>
<style scoped>
.disabled_input {
  pointer-events: none;
  opacity: 0.5;
}
</style>
