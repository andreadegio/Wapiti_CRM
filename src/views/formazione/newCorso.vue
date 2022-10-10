<template>
  <div>
    <CModal :show="showModaleUpload" centered>
      <template #header>
        <span class="h4 text-uppercase" style="color: white">
          <strong>Upload</strong>
        </span>

        <CButton class="close" @click="chiudi()">
          <span aria-hidden="true">&times;</span>
        </CButton>
      </template>
      <template>
        <div id="uploadInCorso" class="h3 text-center pb-2">
          Caricamento in corso, attendere:
        </div>
      </template>
      <template #footer-wrapper>
        <span></span>
      </template>
    </CModal>
    <CModal
      :show.sync="selezionaImmagini"
      color="dark"
      centered
      style="z-index: 30"
      size="lg"
    >
      <template #header>
        <span class="text-uppercase">
          <strong>Ricerca immagini</strong>
        </span>

        <CButton class="close" @click="chiudi()">
          <span aria-hidden="true">&times;</span>
        </CButton>
      </template>

      <div class="row" style="min-height: 20rem">
        <div v-if="searchResult != null">
          {{ searchResult }}
        </div>
        <div
          v-if="loader == true"
          style="position: relative; width: 100%; top: 50%; left: 50%"
        >
          <img
            src="img/loader.gif"
            style="
              position: fixed;
              top: 50%;
              left: 50%;
              -webkit-transform: translate(-50%, -50%);
              -moz-transform: translate(-50%, -50%);
              -ms-transform: translate(-50%, -50%);
              -o-transform: translate(-50%, -50%);
              transform: translate(-50%, -50%);
            "
          />
        </div>
        <div
          class="m-3 col-lg-3 col-sm-6"
          v-for="(immagine, id) in elencoImg"
          :key="id"
        >
          <img
            class="selImg"
            :src="immagine.urls.thumb"
            :alt="immagine.id"
            @click="selectImg(immagine.id, immagine.urls.thumb)"
          />
        </div>
      </div>

      <template #footer>
        <em><small>Fonte immagini Unsplash.com </small></em>
      </template>
    </CModal>
    <div
      style="background-color: white; border-radius: 0.3rem"
      class="container mt-2 card_post"
    >
      <div class="breadcrumbs">
        <CLink @click="back()" class="breadcrumbs_link">Gestione Corsi</CLink>
        > Nuovo Corso
      </div>
      <div class="row justify-content-center">
        <h2 class="pl-2 text-center">Inserimento di un nuovo corso</h2>
        <div class="p-3 rounded col-10">
          <div class="cover_box mb-3">
            <span><strong>Titolo:</strong></span>
            <CInput
              type="text"
              v-model="titolo_corso"
              placeholder="Assegna un titolo a questo caricamento Es. Set Informativo ABC"
              maxlength="100"
            />
          </div>
          <div class="cover_box mb-3">
            <span><strong>Sottotitolo:</strong></span>
            <CInput
              type="text"
              v-model="subtitle_corso"
              placeholder="Assegna un sottotitolo"
              maxlength="200"
            />
          </div>
          <div class="row">
            <div class="col-sm-6">
              <div class="row cover_box">
                <span class="mb-2"
                  ><strong
                    >Carica o cerca un'immagine per la copertina:</strong
                  ></span
                >
                <div class="row m-0">
                  <div
                    class="col-sm-4 justify-content-center"
                    style="background-color: #f0f0f0; border-radius: 0.3rem"
                  >
                    <img v-if="thumb" :src="thumb" class="p-0 m-0 thumbImg" />
                    <img v-if="thumb2" :src="thumb2" class="p-0 m-0 thumbImg" />
                  </div>
                  <div id="carica_cover" class="col-sm-8">
                    <input type="file" @change="previewFiles" ref="file" />
                    <div class="input-group mt-2">
                      <input
                        type="text"
                        class="form-control"
                        placeholder="Che immagine vuoi cercare?"
                        ref="query"
                        v-on:keyup.enter="searchImg($refs.query.value)"
                      />
                      <div class="input-group-append">
                        <button
                          class="btn btn-secondary"
                          type="button"
                          @click="searchImg($refs.query.value)"
                        >
                          <i class="fa fa-search"></i>
                        </button>
                      </div>
                    </div>
                  </div>
                </div>
                <button
                  v-if="thumb || thumb2"
                  @click="resetCover"
                  style="color: darkred; margin-right: auto; margin-left: 50%"
                >
                  <i class="far fa-trash-alt fa-2x"></i>
                </button>
              </div>
            </div>
            <div class="col-sm-6">
              <div class="row cover_box">
                <span class="mb-2"
                  ><strong>Chi può accedere a questi contenuti?</strong></span
                >
                <div class="control">
                  <treeselect
                    v-model="permessi"
                    :multiple="true"
                    :always-open="false"
                    :options="options"
                    :max-height="300"
                    placeholder="Seleziona la tipologia di rapporto"
                  />
                </div>
              </div>
            </div>
          </div>
          <div class="cover_box mb-3">
            <span><strong>Durata (minuti):</strong></span>
            <CInput
              type="text"
              v-model="durata_corso"
              placeholder="Durata indicativa del corso"
              maxlength="4"
            />
          </div>

          <div class="cover_box mb-3">
            <span><strong>Obiettivi:</strong></span>
            <CInput
              type="text"
              v-model="obiettivi_corso"
              placeholder="Indica gli obiettivi del corso"
            />
          </div>

          <div class="cover_box mb-3">
            <span><strong>Descrizione:</strong></span>
            <vue-editor v-model="descrizione_corso" class="pb-3"></vue-editor>
          </div>

          <div class="row cover_box">
            <span class="mb-2"><strong>Aggiungi allegati:</strong></span>
            <div>
              <VueFileAgent
                class="mx-5"
                ref="vueFileAgent"
                :editable="true"
                :theme="'list'"
                :multiple="true"
                :deletable="true"
                :meta="true"
                :accept="'image/*,.zip,.pdf,.doc,.xls,.xlsx,.docx,.ppt,.pptx,video/*'"
                :maxSize="'200MB'"
                :maxFiles="14"
                :helpText="'Seleziona o trascina qui i file'"
                :errorText="{
                  type: 'Tipo di file non consentito',
                  size: 'La dimensione dei file non può superare i 10MB',
                }"
                @select="filesSelected($event)"
                @beforedelete="onBeforeDelete($event)"
                @delete="fileDeleted($event)"
                v-model="fileRecords"
              ></VueFileAgent>
            </div>
          </div>
          <div class="container">
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
              @click="back()"
              ><i class="fas fa-times"></i> Annulla</CButton
            >
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Treeselect from "@riophae/vue-treeselect";
import { VueEditor } from "vue2-editor";
import axios from "axios";

export default {
  name: "NuovoCorso",
  components: {
    VueEditor,
    Treeselect,
  },

  data() {
    return {
      descrizione_corso: "",
      titolo_corso: "",
      subtitle_corso: "",
      categoria_corso: null,
      durata_corso: null,
      obiettivi_corso: "",
      thumb: "",
      thumb2: "", //utilizzato per l'anteprima della ricerca
      idUnsplash: null, // utilizzato per poi recuperare il download link
      elencoImg: [],
      selezionaImmagini: false,
      searchResult: null,
      showModaleUpload: false,
      loader: false,
      permessi: null,

      options: [
        {
          id: "999",
          label: "TUTTI",
          isDefaultExpanded: true,
          children: JSON.parse(localStorage.getItem("tipologie")),
        },
      ],
      //Parametri per l'upload degli allegati
      fileRecords: [],
      fileRecordsForUpload: [],
      uploadHeaders: {},
    };
  },
  methods: {
    back() {
      this.$emit("back");
    },
    filesSelected: function (fileRecordsNewlySelected) {
      var validFileRecords = fileRecordsNewlySelected.filter(
        (fileRecord) => !fileRecord.error
      );
      this.fileRecordsForUpload =
        this.fileRecordsForUpload.concat(validFileRecords);
    },
    onBeforeDelete: function (fileRecord) {
      var i = this.fileRecordsForUpload.indexOf(fileRecord);
      if (i !== -1) {
        // coda di file, non ancora uploaded. Viene rimosso solo dall'array
        this.fileRecordsForUpload.splice(i, 1);
        var k = this.fileRecords.indexOf(fileRecord);
        if (k !== -1) this.fileRecords.splice(k, 1);
      } else {
        if (confirm("Sicuro di voler rimuovere il file?")) {
          this.$refs.vueFileAgent.deleteFileRecord(fileRecord); //trigger 'delete' event
        }
      }
    },
    fileDeleted: function (fileRecord) {
      var i = this.fileRecordsForUpload.indexOf(fileRecord);
      if (i !== -1) {
        this.fileRecordsForUpload.splice(i, 1);
      } else {
        this.deleteUploadedFile(fileRecord);
      }
    },

    previewFiles(event) {
      this.thumb = null;
      this.thumb2 = null;
      this.idUnsplash = null;
      this.thumb = URL.createObjectURL(event.target.files[0]);
    },

    resetCover() {
      this.$refs.file.value = null;
      this.$refs.query.value = "";
      this.thumb = null;
      this.thumb2 = null;
      this.idUnsplash = null;
    },

    async searchImg(query) {
      if (!query) {
        this.$alert(
          "Non hai inserito nessuna parola da cercare",
          "Inserisci un termine di ricerca",
          "warning"
        );
        return;
      }
      this.loader = true;
      var array_img = [];
      this.elencoImg = [];
      this.selezionaImmagini = true;
      // INSERIRE IL LOADING
      try {
        var param = {
          query_string: query,
        };
        await axios
          .post(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.ep_api.searchImg,
            param
          )
          .then((response) => {
            this.loader = false;
            array_img = response.data.results;
            this.elencoImg = array_img;
          });
      } catch (error) {
        this.loader = false;
        this.searchResult =
          "Non è stata trovata nessuna immagine, prova a cambiare il termine di ricerca";
        console.log("Impossibile recuperare le immagini " + error);
      }
    },
    selectImg(id, urlImg) {
      // console.log(id,urlImg);
      this.$refs.file.value = null;
      this.thumb = null;
      this.thumb2 = null;
      this.thumb2 = urlImg;
      this.selezionaImmagini = false;
      this.idUnsplash = id;
    },
    chiudi() {
      this.selezionaImmagini = false;
    },
    salva: async function () {
      /*controllo inserimento campi*/
      if (
        this.titolo_corso == "" ||
        this.subtitle_corso == "" ||
        this.descrizione_corso == "" ||
        this.durata_corso == null ||
        this.obiettivi_corso == null ||
        this.permessi == null
      ) {
        this.$alert(
          "Verifica di aver compilato correttamente tutti i campi",
          "Dati incompleti",
          "warning"
        );
        return;
      }
      if (this.thumb == "" && this.thumb2 == "") {
        this.$alert(
          "Verifica di aver scelto o caricato una copertina per il corso",
          "Copertina mancante",
          "warning"
        );
        return;
      }
      this.showModaleUpload = true;
      let file = this.$refs.file.files[0];
      var formData = new FormData();
      formData.append("file", file);
      /*
     Effettuo l'upload dei record del corso, rispondo con l'id utilizzato per l'inserimento del corso da utilizzare per l'upload dei file
     */
      let preUploadcorsoUrl =
        this.$custom_json.base_url +
        this.$custom_json.api_url +
        this.$custom_json.ep_api.pre_upload_corso;

      let uploadUrl =
        this.$custom_json.base_url +
        this.$custom_json.api_url +
        this.$custom_json.ep_api.upload_corso;

      let params = JSON.stringify({
        durata: this.durata_corso,
        obiettivi: this.obiettivi_corso,
        titolo: this.titolo_corso,
        subtitle: this.subtitle_corso,
        descrizione: this.descrizione_corso,
        permessi: this.permessi,
        utente: JSON.parse(localStorage.getItem("chisono_data")).Nominativo,
        idUtente: JSON.parse(localStorage.getItem("chisono_data")).idUtente,
        copertinaUnsplash: this.idUnsplash,
        numeroAllegati: this.fileRecordsForUpload.length,
      });

      formData.append("params", params);
      await axios
        .post(preUploadcorsoUrl, formData, {
          header: {
            "Content-Type": "multipart/form-data",
          },
        })
        .then((response2) => {
          // console.log(response2.data.status);
          if (response2.data.status == "OK") {
            // se ok allora carico gli allegati (se esistono) passandogli l'id del corso
            if (this.fileRecordsForUpload.length > 0) {
              let params_allegati = {
                percorso: response2.data.corso_id + "_Corso",
                permessi: this.permessi,
                corso_id: response2.data.corso_id,
                utente: JSON.parse(localStorage.getItem("chisono_data"))
                  .Nominativo,
                idUtente: JSON.parse(localStorage.getItem("chisono_data"))
                  .idUtente,
              };
              this.$refs.vueFileAgent
                .upload(
                  uploadUrl,
                  this.uploadHeaders,
                  this.fileRecordsForUpload,
                  params_allegati
                )
                .then((response) => {
                  console.log(response.data);
                  this.$alert(
                    "Corso pubblicato correttamente",
                    "Completato",
                    "success"
                  ).then(
                    // eslint-disable-next-line no-unused-vars
                    (result) => {
                      this.$router.go(-1);
                      this.showModaleUpload = false;
                    }
                  );
                  return;
                });
            } else {
              /* Non ci sono allegati -> ritorno */
              this.$alert(
                "Corso pubblicato correttamente",
                "Completato",
                "success"
              ).then(
                // eslint-disable-next-line no-unused-vars
                (result) => {
                  this.$router.go(-1);
                  this.showModaleUpload = false;
                }
              );
              return;
            }
          } else {
            /*
             IMPOSSIBILE PROCEDERE AL CARICAMENTO
            */
            console.log("Caricamento non riuscito");
            //visualizzo il messaggio di errore
            this.$alert(
              "Caricamento non riuscito",
              "Attenzione",
              "warning"
            ).then(
              // eslint-disable-next-line no-unused-vars
              (result) => {
                this.showModaleUpload = false;
              }
            );
            return;
          }
        });
    },
  },
};
</script>

<style>
/* Forzo caricamento css del modulo treeselect */
@import "~@riophae/vue-treeselect/dist/vue-treeselect.css";
@import "~vue-file-agent/dist/vue-file-agent.css";
.thumbImg {
  max-width: 100%;
  max-height: 100%;
}
.selImg {
  cursor: pointer;
}
.cover_box {
  border: 1px solid rgb(218, 218, 218);
  padding: 0.4rem;
  margin: 0.4rem;
  border-radius: 0.3rem;
  background-color: #ebedef;
}
.ql-container.ql-snow {
  border-radius: 0 0 0.5rem 0.5rem !important;
  background-color: white;
}
.ql-toolbar.ql-snow {
  border-radius: 0.5rem 0.5rem 0 0 !important;
}
.breadcrumbs_link {
  text-decoration: underline;
  font-size: 14px;
  line-height: 19px;
  text-transform: uppercase;
  margin-bottom: 5px;
  margin-left: 0.8rem;
  padding-top: 0.5rem;
  padding-bottom: 1.5rem;
  font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
  font-weight: 600;
}
.breadcrumbs {
  font-size: 14px;
  line-height: 19px;
  text-transform: uppercase;
  margin-bottom: 5px;
  margin-left: 0.8rem;
  padding-top: 0.5rem;
  padding-bottom: 1.5rem;
  font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
  font-weight: 600;
}
.modal-body {
  overflow-y: scroll;
  max-height: 50vh;
}
</style>