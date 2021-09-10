<template>
  <div>
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

      <div class="row">
        <div v-show="elencoImg.length == 0">
          Non è stata trovata nessuna immagine, cambia il termine di ricerca
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
      class="container mt-2"
    >
      <div class="row">
        <div class="p-3 rounded col-8">
          <h2 class="pl-2">Inserimento di una nuova comunicazione</h2>
          <span><strong>Titolo:</strong></span>
          <CInput
            type="text"
            v-model="titolo_post"
            placeholder="Assegna un titolo"
          />
          <span><strong>Sottotitolo:</strong></span>
          <CInput
            type="text"
            v-model="subtitle_post"
            placeholder="Assegna un sottotitolo"
          />
          <span><strong>Contenuto:</strong></span>
          <vue-editor v-model="contenuto_post" class="pb-3"></vue-editor>
        </div>
        <div class="col-4">
          <div class="row cover_box">
            <span class="mb-2"
              ><strong
                >Carica o cerca un'immagine per la copertina:</strong
              ></span
            >
            <div
              class="col-4 justify-content-center"
              style="background-color: #f0f0f0; border-radius: 0.3rem"
            >
              <img v-if="thumb" :src="thumb" class="p-0 m-0 thumbImg" />
              <img v-if="thumb2" :src="thumb2" class="p-0 m-0 thumbImg" />
            </div>
            <div id="carica_cover" class="col-8">
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
            <button
              v-if="thumb || thumb2"
              @click="resetCover"
              style="color: darkred; margin-right: auto; margin-left: 50%"
            >
              <i class="far fa-trash-alt fa-2x"></i>
            </button>
          </div>
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
                placeholder="Seleziona per tipologia di rapporto"
              />
            </div>
          </div>
          <div class="row cover_box">
            <span class="mb-2"><strong>Seleziona la categoria:</strong></span>
            <div class="control">
              <treeselect
                :multiple="false"
                :always-open="false"
                :options="lista_categorie"
                :max-height="300"
                placeholder="Seleziona la categoria"
                v-model="categoria_post"
              />
            </div>
          </div>
          <div class="row cover_box">
            <span class="mb-2"><strong>Aggiungi allegati:</strong></span>
            <div class="control">
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
        </div>
      </div>
      <div class="row">
        <FormulateInput
          class="text-center m-3"
          style="margin-left: 50% !important; margin-right: auto !important"
          type="submit"
          label="Salva"
          name="salva"
          @click="salva()"
        />
      </div>
    </div>
  </div>
</template>

<script>
import { VueEditor } from "vue2-editor";
import axios from "axios";
import Treeselect from "@riophae/vue-treeselect";

export default {
  name: "nuovaComunicazione",
  components: {
    VueEditor,
    Treeselect,
  },
  data() {
    return {
      contenuto_post: "",
      titolo_post: "",
      subtitle_post: "",
      categoria_post: null,
      thumb: "",
      thumb2: "", //utilizzato per l'anteprima della ricerca
      idUnsplash: null, // utilizzato per poi recuperare il download link
      elencoImg: [],
      selezionaImmagini: false,
      permessi: [],
      lista_categorie: JSON.parse(localStorage.getItem("categorie")),
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
  mounted() {
    this.get_categorie();
  },
  methods: {
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
        // queued file, not yet uploaded. Just remove from the arrays
        this.fileRecordsForUpload.splice(i, 1);
        var k = this.fileRecords.indexOf(fileRecord);
        if (k !== -1) this.fileRecords.splice(k, 1);
      } else {
        if (confirm("Sicuro di voler rimuovere il file?")) {
          this.$refs.vueFileAgent.deleteFileRecord(fileRecord); // will trigger 'delete' event
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
    async get_categorie() {
      // Chiamata per recuperare le categorie
      try {
        await axios
          .post(this.$custom_json.api_url + this.$custom_json.ep_api.categorie)
          .then((response) => {
            // la risposta con l'elenco delle categorie  la salvo nello storage
            localStorage.setItem("categorie", JSON.stringify(response.data));
            // console.log(JSON.stringify(response.data));
          });
      } catch (error) {
        console.log("impossibile accedere al cloud");
      }
    },

    previewFiles(event) {
      // console.log(event.target.files);
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
            this.$custom_json.api_url + this.$custom_json.ep_api.searchImg,
            param
          )
          .then((response) => {
            array_img = response.data.results;
            this.elencoImg = array_img;
          });
      } catch (error) {
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
      let file = this.$refs.file.files[0];
      var formData = new FormData();
      formData.append("file", file);
      /*
     Effettuo l'upload dei record del post, rispondo con l'id utilizzato per l'inserimento del post da utilizzare per l'upload dei file
     */
      let preUploadPostUrl =
        this.$custom_json.api_url + this.$custom_json.ep_api.pre_upload_post;

      let uploadUrl =
        this.$custom_json.api_url + this.$custom_json.ep_api.upload_post;

      let params = JSON.stringify({
        settore: this.$route.params.settore,
        titolo: this.titolo_post,
        subtitle: this.subtitle_post,
        contenuto: this.contenuto_post,
        permessi: this.permessi,
        utente: JSON.parse(localStorage.getItem("chisono_data")).Nominativo,
        idUtente: JSON.parse(localStorage.getItem("chisono_data")).idUtente,
        categoria: this.categoria_post,
        copertinaUnsplash: this.idUnsplash,
        numeroAllegati: this.fileRecordsForUpload.length,
      });

      formData.append("params", params);
      await axios
        .post(preUploadPostUrl, formData, {
          header: {
            "Content-Type": "multipart/form-data",
          },
        })
        .then((response) => {
          // console.log(response.data);
          if (response.data.status == "OK") {
            // se ok allora carico gli allegati (se esistono) passandogli l'id del post
            if (this.fileRecordsForUpload.length > 0) {
              let params_allegati = {
                settore: this.$route.params.settore,
                percorso: response.data.post_id + "_Com",
                permessi: this.permessi,
                post_id: response.data.post_id,
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
                  console.log(response);
                });
            }
          } else {
            console.log(response);
          }
        });
    },
  },
};
</script>

<style>
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
}
.ql-container.ql-snow {
  border-radius: 0 0 0.5rem 0.5rem !important;
}
.ql-toolbar.ql-snow {
  border-radius: 0.5rem 0.5rem 0 0 !important;
}
</style>