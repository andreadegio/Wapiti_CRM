<template>
  <CContainer
    id="cover_archivio"
    :style="{ '--urlImg': urlImgSettore }"
    class="align-items-center min-vh-100"
  >
    <div
      class="container mt-3"
      style="background-color: white; border-radius: 5px"
    >
      <Visualizzatore
        :showDoc="showDoc"
        :file="file"
        :ext="ext"
        :nome_file="nome_file"
        @aggiorna_modale="aggiorna_modale"
      />
      <div v-if="editPost.categoria == 'Materiale'">
        <h1>MODIFICA - {{ editPost.titolo }}</h1>
        <span>
          <cite>
            - Si può modificare il titolo, i permessi e la descrizione del
            contenuto. Per eliminare/modificare file, si deve procedere con
            l'eliminazione del post e crearne uno nuovo -</cite
          >
        </span>
        <div class="cover_box mb-3">
          <span><strong>Titolo:</strong></span>
          <CInput
            type="text"
            v-model="editPost.titolo"
            placeholder="Inserisci un titolo"
            maxlength="100"
          />
        </div>

        <div class="row cover_box mb-3">
          <span class="mb-2"
            ><strong>Modifica chi può accedere a questi contenuti</strong></span
          >

          <div class="control">
            <treeselect
              v-model="permessi"
              :multiple="true"
              :options="options"
              :max-height="300"
              placeholder="Seleziona per tipologia di rapporto"
            />
          </div>
        </div>

        <div class="cover_box mb-3">
          <label class="label"><strong>Contenuto:</strong></label>
          <div class="control">
            <CTextarea
              placeholder="Descrivi il contenuto di ciò che andrai a caricare"
              v-model="editPost.contenuto"
            />
          </div>
        </div>

        <div class="row cover_box">
          <div class="mb-2"><strong>Materiale allegato</strong></div>
          <div class="listaFile text-center">
            <div
              class="file"
              v-for="allegato in editPost.files"
              :key="allegato.nome_file"
            >
              <div
                class="cloud"
                @click="
                  (showDoc = true),
                    (file =
                      $custom_json.base_url +
                      allegato.percorso_file +
                      '/' +
                      allegato.nome_file),
                    (ext = allegato.ext_file.toUpperCase()),
                    (nome_file = allegato.nome_file)
                "
              >
                <div :class="allegato.ext_file.toUpperCase()">
                  <div class="desc_elemento mx-3">
                    {{ allegato.nome_file }}
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div>
          <CButton
            style="color: white"
            color="primary"
            class="ml-2"
            @click="updatePost"
            ><i class="far fa-save"></i> Salva</CButton
          >
          <CButton
            color="primary"
            class="ml-2"
            variant="outline"
            @click="back()"
            ><i class="fas fa-times"></i> Annulla</CButton
          ><CButton
            color="danger"
            class="ml-2"
            variant="ghost"
            @click="askDeletePost"
          >
            <i class="far fa-trash-alt"></i> Elimina</CButton
          >
        </div>

        <br />
      </div>
      <div v-else>
        <div class="p-3 rounded">
          <h1>MODIFICA - {{ editPost.titolo }}</h1>
          <span>
            <cite>
              - Per eliminare/modificare file, si deve procedere con
              l'eliminazione del post e crearne uno nuovo -</cite
            >
          </span>
          <div class="row cover_box mb-3">
            <span class="mb-2"><strong>Area di competenza:</strong></span>
            <div class="control">
              <treeselect
                :multiple="false"
                :always-open="false"
                :options="$attrs.lista_aree"
                :max-height="300"
                placeholder="Seleziona l'area"
                v-model="editPost.id_area"
              />
            </div>
          </div>

          <div class="cover_box mb-3">
            <span><strong>Titolo:</strong></span>
            <CInput
              type="text"
              v-model="editPost.titolo"
              placeholder="Assegna un titolo a questo caricamento Es. Set Informativo ABC"
              maxlength="100"
            />
          </div>

          <div class="cover_box mb-3">
            <span><strong>Sottotitolo:</strong></span>
            <CInput
              type="text"
              v-model="editPost.sottotitolo"
              placeholder="Assegna un sottotitolo"
              maxlength="200"
            />
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

          <div class="cover_box mb-3">
            <span><strong>Contenuto:</strong></span>
            <vue-editor v-model="editPost.contenuto" class="pb-3"></vue-editor>
          </div>

          <div class="row cover_box">
            <span class="mb-2"
              ><strong>Allegati presenti nella comunicazione:</strong></span
            >
            <div class="listaFile text-center">
              <div
                class="file"
                v-for="allegato in editPost.files"
                :key="allegato.nome_file"
              >
                <div
                  class="cloud"
                  @click="
                    (showDoc = true),
                      (file =
                        $custom_json.base_url +
                        allegato.percorso_file +
                        '/' +
                        allegato.nome_file),
                      (ext = allegato.ext_file.toUpperCase()),
                      (nome_file = allegato.nome_file)
                  "
                >
                  <div :class="allegato.ext_file.toUpperCase()">
                    <div class="desc_elemento mx-3">
                      {{ allegato.nome_file }}
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div>
            <CButton
              style="color: white"
              color="primary"
              class="ml-2"
              @click="updatePostComunicazione"
              ><i class="far fa-save"></i> Salva</CButton
            >
            <CButton
              color="primary"
              class="ml-2"
              variant="outline"
              @click="back()"
              ><i class="fas fa-times"></i> Annulla</CButton
            ><CButton
              color="danger"
              class="ml-2"
              variant="ghost"
              @click="askDeletePostComunicazione"
            >
              <i class="far fa-trash-alt"></i> Elimina</CButton
            >
          </div>
        </div>
      </div>
    </div>
  </CContainer>
</template>

<script >
import { VueEditor } from "vue2-editor";
import Treeselect from "@riophae/vue-treeselect";
import axios from "axios";
import Visualizzatore from "../../components/visualizzaDocumenti.vue";

export default {
  name: "ModificaContenuti",
  components: {
    VueEditor,
    Treeselect,
    Visualizzatore: Visualizzatore,
  },
  props: ["post", "editPost", "settore"],
  data() {
    return {
      urlImgSettore: "",
      showDoc: false,
      nome_file: "",
      file: "",
      ext: "",
      permessi: null,
      options: [
        {
          id: "999",
          label: "TUTTI",
          isDefaultExpanded: true,
          children: JSON.parse(localStorage.getItem("tipologie")),
        },
      ],
      titolo_post: "",
      contenuto_post: "",
    };
  },
  created() {
    this.set_background();
  },
  mounted() {
    this.getPermessiPost(this.editPost.id_post);
  },
  methods: {
    back() {
      this.$router.push({
        name: "AdminCommerciale_settore",
        params: { reference: "elenco" },
      });
    },
    set_background() {
      if (this.settore == "Assicurazioni") {
        this.urlImgSettore =
          'url("http://localhost:8080/img/filigranaAuto.png")';
      }
      if (this.settore == "Energy") {
        this.urlImgSettore =
          'url("http://localhost:8080/img/filigranaGas.png")';
      }
    },
    aggiorna_modale(value) {
      this.showDoc = value;
    },
    async getPermessiPost(id_post) {
      let params = {
        idPost: id_post,
      };
      // console.log(id_post);
      try {
        await axios
          .post(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.ep_api.permessi_post,
            { params }
          )
          .then((response) => {
            // la risposta con l'elenco delle categorie  la salvo nello storage
            // console.log(
            //   "Permessi per questo post: " + JSON.stringify(response.data)
            // );
            this.permessi = response.data;
          });
      } catch (error) {
        console.log("impossibile recuperare i permessi del post");
      }
    },

    async updatePost() {
      let params = {
        permessi: this.permessi,
        edit_post: this.editPost,
        utente: JSON.parse(localStorage.getItem("chisono_data")).Nominativo,
        idUtente: JSON.parse(localStorage.getItem("chisono_data")).idUtente,
      };
      try {
        await axios
          .post(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.ep_api.update_post,
            { params }
          )
          .then((response) => {
            // console.log(JSON.stringify(response.data));
            if (response.data.status == "OK") {
              this.$alert(
                "Modifica effettuata correttamente",
                "Update completo",
                "success"
              ).then(
                // eslint-disable-next-line no-unused-vars
                (result) => {
                  this.back();
                }
              );
              return;
            }
          });
      } catch {
        console.log("errore");
      }
    },

    async updatePostComunicazione() {
      let params = {
        permessi: this.permessi,
        edit_post: this.editPost,
        utente: JSON.parse(localStorage.getItem("chisono_data")).Nominativo,
        idUtente: JSON.parse(localStorage.getItem("chisono_data")).idUtente,
      };
      try {
        await axios
          .post(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.ep_api.update_post,
            { params }
          )
          .then((response) => {
            // console.log(JSON.stringify(response.data));
            if (response.data.status == "OK") {
              this.$alert(
                "Modifica effettuata correttamente",
                "Update completo",
                "success"
              ).then(
                // eslint-disable-next-line no-unused-vars
                (result) => {
                  this.back();
                }
              );
              return;
            }
          });
      } catch {
        console.log("errore");
      }
    },

    askDeletePost() {
      this.$confirm(
        "Vuoi davvero eliminare " + this.editPost.titolo + "?"
      ).then(() => {
        this.deletePost();
        // console.log("Cancellato");
        return;
      });
    },
    askDeletePostComunicazione() {
      this.$confirm(
        "Vuoi davvero eliminare " + this.editPost.titolo + "?"
      ).then(() => {
        this.deletePost();
        // console.log("Cancellato");
        return;
      });
    },
    async deletePost() {
      //Premuto OK -> procedo con la cancellazione
      let params = {
        edit_post: this.editPost,
        utente: JSON.parse(localStorage.getItem("chisono_data")).Nominativo,
        idUtente: JSON.parse(localStorage.getItem("chisono_data")).idUtente,
      };
      try {
        await axios
          .post(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.ep_api.delete_post,
            { params }
          )
          .then((response) => {
            // console.log(JSON.stringify(response.data));
            if (response.data.status == "OK") {
              this.$alert(
                "Cancellato correttamente",
                "Eliminato",
                "success"
              ).then(
                // eslint-disable-next-line no-unused-vars
                (result) => {
                  this.back();
                }
              );
              return;
            } else {
              this.$alert(
                "Impossibile procedere con la cancellazione",
                "Errore",
                "warning"
              );
            }
          });
      } catch {
        console.log("errore");
      }
    },
  },
};
</script>

<style scoped>
#cover_archivio {
  background-size: cover !important;
  background-position: right !important;
  max-width: none !important;

  background-image: var(--urlImg);
}
</style>

