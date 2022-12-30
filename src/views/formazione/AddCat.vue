<template>
  <div>
    <CModal :show="showModaleUpload" centered>
      <template #header>
        <span class="h4 text-uppercase" style="color: white">
          <strong>Salva</strong>
        </span>

        <CButton class="close" @click="chiudi()">
          <span aria-hidden="true">&times;</span>
        </CButton>
      </template>
      <template>
        <div id="saveCat" class="h3 text-center pb-2">
          Salvataggio categoria in corso, attendere:
        </div>
      </template>
      <template #footer-wrapper>
        <span></span>
      </template>
    </CModal>
    <CModal :show="true" centered>
      <template #header>
        <span class="h4 text-uppercase" style="color: white">
          <strong
            >{{ action == "add" ? "Aggiungi" : "Modifica" }} Categoria</strong
          >
        </span>

        <CButton class="close" style="color: white" @click="chiudi()">
          <span aria-hidden="true">&times;</span>
        </CButton>
      </template>

      <template>
        <div>
          <div class="cover_box mb-3">
            <span><strong>Descrizione:</strong></span>
            <CInput
              type="text"
              v-model="descrizione"
              placeholder="Descrizione della categoria"
              maxlength="100"
            />
          </div>
          <div class="cover_box mb-3">
            <span><strong>Assegna un colore:</strong></span>
            <div class="py-2" align="center">
              <sketch-picker v-model="colors" />
            </div>
          </div>
          <div class="mb-3">
            <CButton
              style="color: white"
              color="primary"
              class="ml-2"
              @click="salva()"
              ><i class="far fa-save"></i> Salva</CButton
            >
            <CButton
              color="primary"
              class="ml-2"
              variant="outline"
              @click="chiudi()"
              ><i class="fas fa-times"></i> Annulla</CButton
            >
          </div>
        </div>
      </template>

      <template #footer-wrapper>
        <span></span>
      </template>
    </CModal>
  </div>
</template>
<script>
import { cilX } from "@coreui/icons";
import axios from "axios";
import sketch from "vue-color/src/components/Sketch.vue";
var colors = "#1f4b6b";
export default {
  name: "AddCategory",
  icon_close: cilX,
  props: {
    action: {
      type: String,
      required: true,
      default: "add",
    },
    id_old: {
      type: String,
      required: true,
      default: "",
    },
    desc_old: {
      type: String,
      required: false,
      default: "",
    },
    color_old: {
      type: String,
      required: false,
      default: "",
    },
  },
  components: {
    "sketch-picker": sketch,
  },
  data() {
    return {
      showModaleUpload: false,
      idcat:"",
      colors,
      descrizione: "",
    };
  },
  mounted() {
    if (this.action == "edit") {
      this.descrizione = this.desc_old;
      this.colors = this.color_old;
      this.idcat = this.id_old;

    }
  },
  methods: {
    salva: async function () {
      if (this.descrizione == "" || this.colors.hex == "") {
        this.$alert(
          "Verifica di aver compilato correttamente tutti i campi",
          "Dati incompleti",
          "warning"
        );
        return;
      }
      if (this.action == "add") {
        let url =
          this.$custom_json.base_url +
          this.$custom_json.api_url +
          this.$custom_json.ep_api.add_cat_formazione;
        let params = JSON.stringify({
          descrizione: this.descrizione,
          color: this.colors.hex,
        });
        await axios
          .post(url, params, {
            headers: {
              "Content-Type": "multipart/form-data",
            },
          })
          .then((response) => {
            if (response.data.status == "OK") {
              this.showModaleUpload = true;
              this.$alert(
                "Categoria inserita correttamente",
                "Completato",
                "success"
              ).then(this.chiudi());
            } else {
              this.$alert(
                "Si è verificato un'errore:",
                response.data.message,
                "warning"
              );
              return;
            }
          });
      }else{
        let url =
          this.$custom_json.base_url +
          this.$custom_json.api_url +
          this.$custom_json.ep_api.edit_cat_formazione;
        let params = JSON.stringify({
          id: this.idcat,
          descrizione: this.descrizione,
          color: this.colors.hex,
        });
        await axios
          .post(url, params, {
            headers: {
              "Content-Type": "multipart/form-data",
            },
          })
          .then((response) => {
            if (response.data.status == "OK") {
              this.showModaleUpload = true;
              this.$alert(
                "Categoria inserita correttamente",
                "Completato",
                "success"
              ).then(this.chiudi());
            } else {
              this.$alert(
                "Si è verificato un'errore:",
                response.data.message,
                "warning"
              );
              return;
            }
          });
      }
    },
    chiudi() {
      this.$emit("closeModalClick");
    },
  },
};
</script>
<style scoped>
@media (min-width: 420px) {
  .double-wide {
    display: flex;
  }
  .double-wide .formulate-input {
    flex-grow: 1;
    width: calc(50% - 0.5em);
  }
  .double-wide .formulate-input:first-child {
    margin-right: 0.5em;
  }
  .double-wide .formulate-input:last-child {
    margin-left: 0.5em;
  }
}
</style>