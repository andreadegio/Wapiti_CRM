<template>
  <CModal v-bind="$attrs" v-on="$listeners" :show="true">
    <template #header>
      <span class="h4 text-uppercase">
        <strong v-if="$parent.add_edit == 'edit'">Modifica News</strong>
        <strong v-else>Aggiungi News</strong>
      </span>

      <CButton class="close" @click="chiudi()">
        <span aria-hidden="true">&times;</span>
      </CButton>
    </template>

    <template>
      <div v-show="add">
        <div v-show="$parent.add_edit == 'edit'">
          <div class="row justify-content-center">
            <CImg
              :src="$custom_json.img_news_url + news_originale.immagine"
              block
              class="pb-2"
              width="20%"
              align="right"
            />
          </div>
          <div class="row justify-content-center">
            <strong>Immagine attuale</strong>
          </div>
        </div>
        <FormulateForm
          v-if="vuole_modificare"
          name="add_news"
          class="add-news-form"
          v-model="formValues"
          :schema="schema_news"
          @submit="salva()"
        >
          <vue-editor v-model="content" :editorToolbar="customToolbar" class="pb-3"></vue-editor>
          <div style="display: flex">
            <FormulateInput
              id="reset-btn"
              type="button"
              label="Reset"
              data-ghost
              @click="reset()"
            />
            <FormulateInput
              type="submit"
              label="Salva"
              name="salva"
              @click="salva()"
            />

            <CButton
              v-if="$parent.add_edit == 'edit'"
              id="elimina_btn"
              color="danger"
              @click="ask_elimina()"
            >
              Elimina
            </CButton>
          </div>
        </FormulateForm>
      </div>
      <div v-show="loading" class="text-center">
        <div v-if="messaggio_esito == ''" class="text-center">
          <span class="h3"
            ><img src="img/loading-circle.gif" style="width: 50px" />
            Salvataggio news in corso ...</span
          >
        </div>
        <div v-else class="text-center">
          <span class="h3"
            ><img
              v-if="esito_add_edit == 'OK'"
              src="img/ok.gif"
              style="width: 50px"
            />
            <img v-else src="img/ko.gif" style="width: 50px" />
            {{ messaggio_esito }}</span
          ><br />
          <CButton @click="chiudi()" color="secondary" variant="outline">
            <CIcon :content="$options.icon_close" />&nbsp;Chiudi
          </CButton>
        </div>
      </div>
      <div v-show="ask_delete">
        <div class="modal-mask">
          <div class="modal-wrapper">
            <div class="modal-dialog" role="document">
              <div class="modal-content delete">
                <div class="modal-header delete justify-content-center">
                  <h3 class="modal-title" style="text-align: center">
                    Attenzione
                  </h3>
                  <button
                    type="button"
                    class="close"
                    data-dismiss="modal"
                    aria-label="Close"
                  >
                    <span aria-hidden="true" @click="ask_delete = false"
                      >&times;</span
                    >
                  </button>
                </div>
                <div class="modal-body text-center">
                  <h3><strong>Vuoi davvero eliminare la news ?</strong></h3>
                </div>
                <div class="modal-footer">
                  <button
                    type="button"
                    class="btn btn-secondary"
                    @click="
                      ask_delete = false;
                      add = true;
                    "
                  >
                    Annulla
                  </button>
                  <button
                    type="button"
                    class="btn btn-danger delete"
                    @click="elimina()"
                  >
                    <i class="far fa-trash-alt"></i>Elimina
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </template>

    <template #footer-wrapper>
      <span></span>
    </template>
  </CModal>
</template>
<script>
import { cilX } from "@coreui/icons";
import axios from "../../node_modules/axios";
import { VueEditor } from "vue2-editor";

export default {
  name: "AddNewsModale",
  icon_close: cilX,
  components: {
    VueEditor,
  },
  props: {
    news_originale: {
      type: Object,
      required: false,
      default: () => {
        return {
          id: -1,
          titolo: "",
          contenuto: "",
          immagine: "",
        };
      },
    },
  },
  data() {
    return {
      add: true,
      content: "",
      // ToolBar personalizzata per l'editor di testo
      customToolbar: [
        [{ header: [false, 1, 2, 3, 4, 5, 6] }],
        ["bold", "italic", "underline"],
        [{ color: [] }, { background: [] }],
        [
          { align: "" },
          { align: "center" },
          { align: "right" },
          { align: "justify" },
        ],
        [{ list: "ordered" }, { list: "bullet" }, { list: "check" }],
        [{ indent: "-1" }, { indent: "+1" }],
        ["link"],
      ],
      ask_delete: false,
      loading: false,
      messaggio_esito: "",
      esito_add_edit: "",
      formValues: {},
      schema_news: [
        {
          type: "image",
          name: "immagine",
          label: "Modifica Immagine di copertina",

          validation: "required|mime:image/jpeg,image/png,image/gif",
          "validation-messages": {
            required: "Immagine obbligatoria",
            mime: "Formato errato si accetta solo jpg, png o gif ",
          },
          help:
            "Clicca o trascina qui l'immagine da caricare - Formati accettati png, jpg o gif",
        },
        {
          type: "text",
          name: "titolo",
          label: "Titolo della News",
          validation: "required",
          "validation-messages": {
            required: "Titolo obbligatorio",
          },
          placeholder: "Inserirsci il titolo",
          // value: this.items.titolo,
        },
        // {
        //   type: "textarea",
        //   name: "contenuto",
        //   label: "Contenuto della News",
        //   validation: "required",
        //   "validation-messages": {
        //     required: "Contenuto obbligatorio",
        //   },
        //   placeholder: "Contenuto della news",
        //   style: "height: 200px",
        //   // value: this.items.contenuto,
        // },
      ],
    };
  },
  computed: {
    vuole_modificare() {
      // eslint-disable-next-line vue/no-side-effects-in-computed-properties
      this.content = this.news_originale.contenuto;
      return this.news_originale !== -1;
    },
    vuole_aggiungere() {
      // eslint-disable-next-line vue/no-side-effects-in-computed-properties
      this.content = this.news_originale.contenuto;
      return this.news_originale === -1;
    },
  },
  methods: {
    reset() {
      this.formValues = this.news_originale;
    },
    salva() {
      /* Controllo se devo inserire o modificare, */
      if (this.$parent.add_edit == "add") {
        /* AGGIUNGO NEWS */

        if (
          this.formValues.titolo == "" ||
          this.content == "" ||
          this.formValues.immagine.files[0] == null ||
          this.formValues.immagine.files[0]["previewData"] == false
        ) {
          /* se mancano parametri non procedo */
          console.log("dati incompleti");
        } else {
          /* AGGIUNGO LA NEWS INVIANDO I DATI AI SERVIZI PHP*/
          this.add = false;
          this.loading = true;
          this.messaggio_esito = "";
          try {
            axios
              .post(
                this.$custom_json.api_url + "addnews",
                {
                  params: {
                    titolo: this.formValues.titolo,
                    contenuto: this.content,
                    file: this.formValues.immagine.files[0],
                    utente: JSON.parse(localStorage.getItem("chisono_data"))
                      .Nominativo,
                    idUtente: JSON.parse(localStorage.getItem("chisono_data"))
                      .idUtente,
                  },
                },
                {
                  header: {
                    "Content-Type": "multipart/form-data",
                  },
                }
              )
              .then((response) => {
                this.formValues = this.news_originale;
                this.messaggio_esito = response.data.message;
                this.esito_add_edit = response.data.status;
              });
          } catch {
            console.log("Impossibile comunicare con il server");
          }
        }
      } else {
        /* MODIFICO NEWS */
        this.add = false;
        this.loading = true;
        this.messaggio_esito = "";
        var immagine_edit;
        var stessa_img;
        var params;
        if (typeof this.formValues.immagine === "object") {
          /* Immagine modificata, carico la nuova */
          immagine_edit = this.formValues.immagine.files[0];
          stessa_img = false;
          params = {
            titolo: this.formValues.titolo,
            contenuto: this.content,
            file: this.formValues.immagine.files[0],
            immagine: immagine_edit,
            id_news: this.$parent.news_da_modificare.id_db_news,
            cambio: stessa_img,
            utente: JSON.parse(localStorage.getItem("chisono_data")).Nominativo,
            idUtente: JSON.parse(localStorage.getItem("chisono_data")).idUtente,
          };
        } else {
          /* Stessa immagine non carico niente di nuovo*/
          immagine_edit = this.news_originale.immagine;
          stessa_img = true;
          params = {
            titolo: this.formValues.titolo,
            contenuto: this.content,
            file: [],
            immagine: immagine_edit,
            id_news: this.$parent.news_da_modificare.id_db_news,
            cambio: stessa_img,
            utente: JSON.parse(localStorage.getItem("chisono_data")).Nominativo,
            idUtente: JSON.parse(localStorage.getItem("chisono_data")).idUtente,
          };
        }

        try {
          axios
            .post(
              this.$custom_json.api_url + "editnews",
              { params },
              {
                header: {
                  "Content-Type": "multipart/form-data",
                },
              }
            )
            .then((response) => {
              this.del_btn = false;
              this.formValues = this.news_originale;
              this.messaggio_esito = response.data.message;
              this.esito_add_edit = response.data.status;
            });
        } catch {
          console.log("Impossibile comunicare con il server");
        }
      }
    },
    ask_elimina() {
      this.add = false;
      this.ask_delete = true;
    },
    elimina() {
      this.ask_delete = false;
      this.add = false;
      this.loading = true;
      this.messaggio_esito = "";
      let params = {
        id_news: this.$parent.news_da_modificare.id_db_news,
        utente: JSON.parse(localStorage.getItem("chisono_data")).Nominativo,
      };
      try {
        axios
          .post(
            this.$custom_json.api_url + "delete",
            { params },
            {
              header: {
                "Content-Type": "multipart/form-data",
              },
            }
          )
          .then((response) => {
            this.messaggio_esito = response.data.message;
            this.esito_add_edit = response.data.status;
          });
      } catch {
        console.log("Impossibile comunicare con il server");
      }
    },
    chiudi() {
      this.add = true;
      this.loading = false;
      this.messaggio_esito = "";
      this.$emit("closeModalClick");
    },
    invio_news() {
      // alert("inviato");
    },
    popolaModale() {
      this.formValues = this.news_originale;
    },
  },
  activated() {
    this.popolaModale();
  },
  mounted() {},
};
</script>
<style scoped>
.add-news-form {
  padding: 2em;
  background-color: white;
  max-width: 800px;
  box-sizing: border-box;
}
.form-title {
  margin-top: 0;
}
.add-news-form::v-deep .formulate-input .formulate-input-element {
  max-width: none;
}
#elimina_btn {
  background-color: red !important;
  border-color: red !important;
  position: absolute;
  right: 4em;
  color: white;
}

.modal-header.delete {
  background-color: red;
  border-color: red;
}
.modal-content.delete {
  border-color: red;
}
.btn.btn-danger.delete {
  color: white;
}

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