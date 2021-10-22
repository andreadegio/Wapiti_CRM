<template>
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
    <div v-show="editPost.categoria == 'Materiale'">
      <h1>MODIFICA - {{ editPost.titolo }}</h1>

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
      {{ JSON.stringify(editPost) }}
      <br />
    </div>
    <div v-show="editPost.categoria == 'Comunicazione Commerciale'">
      controllo i file allegati
    </div>
  </div>
</template>

<script >
import Treeselect from "@riophae/vue-treeselect";
import axios from "axios";
import Visualizzatore from "../../components/visualizzaDocumenti.vue";

export default {
  name: "ModificaContenuti",
  components: {
    Treeselect,
    Visualizzatore: Visualizzatore,
  },
  props: ["post", "editPost"],
  data() {
    return {
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
    };
  },
  mounted() {
    this.getPermessiPost(this.editPost.id_post);
  },
  methods: {
    aggiorna_modale(value) {
      this.showDoc = value;
    },
    async getPermessiPost(id_post) {
      let params = {
        idPost: id_post,
      };
      console.log(id_post);
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

            console.log(
              "Permessi per questo post: " + JSON.stringify(response.data)
            );
            this.permessi = response.data;
          });
      } catch (error) {
        console.log("impossibile recuperare i permessi del post");
      }
    },
  },
};
</script>

<style scoped>
</style>

