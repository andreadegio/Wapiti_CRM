<template>
  <div style="background-color: white">
    <div class="container">
      <div class="area">{{ lista_post[id].settore }}</div>
      <div class="data">{{ lista_post[id].data_ins | formatDate }}</div>
      <div class="titolo">{{ lista_post[id].titolo }}</div>
      <div class="sottotitolo">
        {{ lista_post[id].categoria }} - {{ lista_post[id].sottotitolo }}
      </div>
    </div>
    <div class="copertina">
      <CImg :src="'../../' + lista_post[id].copertina" />
    </div>
    <div class="container">
      <div class="contenuto">
        {{ lista_post[id].contenuto }}
      </div>
      <div
        class="allegati"
        v-show="lista_post[id].allegati && lista_post[id].files.length > 0"
      >
        <i class="text-muted fas fa-paperclip fa-2x"></i>
        <span class="text-muted h4 ml-3">Documenti allegati:</span>
        <hr
          style="
            width: 30%;
            text-align: left;
            margin-left: 0;
            border: 2px solid;
          "
        />
        <div class="listaFile text-center">
          <div
            class="file"
            v-for="allegato in lista_post[id].files"
            :key="allegato.nome_file"
          >
            <div
              class="cloud"
              @click="
                (showDoc = true),
                  (file =
                    $custom_json.cloud_url +
                    allegato.percorso_file +
                    '/' +
                    allegato.nome_file),
                  (ext = allegato.ext_file.toUpperCase())
              "
            >
              <div :class="allegato.ext_file">
                <div class="desc_elemento mx-3">
                  {{ allegato.nome_file }}
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <Visualizzatore
      :showDoc="showDoc"
      :file="file"
      :ext="ext"
      @aggiorna_modale="aggiorna_modale"
    />
    <div class="container">
      <div class="navigazione">
        <hr />
        <div class="row">
          <div class="col-6 text-right navigazione-col">
            <span
              class="text-muted indicatore"
              style="font-size: 1rem"
              v-if="lista_post[id].id != 0"
              >Precedente <br
            /></span>

            <span class="prev text-muted h6" v-if="lista_post[id].id != 0">
              <CLink
                :to="{
                  name: 'Comunicazione',
                  params: {
                    notizia: lista_post[lista_post[id].id - 1].titolo,
                    id: lista_post[lista_post[id].id - 1].id,
                    lista_post: lista_post,
                  },
                }"
              >
                <em v-if="lista_post[id].id != 0">{{
                  lista_post[lista_post[id].id - 1].titolo
                }}</em>
              </CLink></span
            >
          </div>
          <div class="col-6">
            <span
              class="text-muted"
              style="font-size: 1rem"
              v-if="lista_post[id].id < last"
              >Successiva <br
            /></span>
            <span v-if="lista_post[id].id < last" class="next text-muted h6">
              <CLink
                :to="{
                  name: 'Comunicazione',
                  params: {
                    notizia: lista_post[lista_post[id].id + 1].titolo,
                    id: lista_post[lista_post[id].id + 1].id,
                    lista_post: lista_post,
                  },
                }"
              >
                <em v-if="lista_post[id].id < last">{{
                  lista_post[lista_post[id].id + 1].titolo
                }}</em>
              </CLink>
            </span>
          </div>
        </div>
        <hr />
      </div>
    </div>
  </div>
</template>

<script>
import Visualizzatore from "../../components/visualizzaDocumenti.vue";

export default {
  name: "Comunicazione",
  // ricevo dalla pagina Commerciale.vue il titolo della notizia utilizzato per l'url, l'id e la lista completa dei post
  props: ["notizia", "id", "lista_post"],
  components: {
    Visualizzatore: Visualizzatore,
  },
  data() {
    return {
      showDoc: false,
      last: "",
      first: 0,
      file: "",
      ext: "",
    };
  },
  mounted() {
    if (!this.lista_post) {
      console.log("parametri mancanti");
      this.$router.push("..");
    }
    this.last = this.lista_post[this.lista_post.length - 1].id;
  },
  methods: {
    aggiorna_modale(value) {
      this.showDoc = value;
      if (value == false) {
        this.file = null;
      }
    },
  },
};
</script>

<style scoped>
.area {
  color: #0f3250;
  text-decoration: underline;
  font-size: 16px;
  line-height: 19px;
  text-transform: uppercase;
  margin-bottom: 5px;
  font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
  font-weight: 600;
}
.data {
  color: #ef7a12;
  font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
  font-size: 14px;
  line-height: 19px;
  margin-bottom: 5px;
  font-weight: 500;
}
.titolo {
  margin-bottom: 8px;
  font-size: 45px;
  line-height: 54px;
}
.sottotitolo {
  font-size: 24px;
  line-height: 29px;
  font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
  margin-bottom: 14px;
}
.copertina img {
  vertical-align: middle;
  max-height: 240px;
  width: 100%;
  object-fit: cover;
  object-position: 50% 50%;
  border: 0;
}
.contenuto {
  font-size: 1.5rem;
  padding-bottom: 2rem;
}
.navigazione {
  font-weight: lighter;
  line-height: 1.5rem;
}
.navigazione span {
  font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
  font-size: 1.5rem;
}
.navigazione-col {
  border-right: 2px solid gray;
}
.prev::before {
  content: "\f104";
  font-family: "Font Awesome 5 free";
  color: rgb(103, 103, 104);
  font-size: 2em;
  font-weight: 700;
  padding-right: 8px;
}
.next::after {
  content: "\f105";
  font-family: "Font Awesome 5 free";
  color: rgb(103, 103, 104);
  font-size: 2em;
  font-weight: 700;
  padding-left: 8px;
}

/* SEZIONE ALLEGATI  */

.cloud {
  font-size: 1rem;
  cursor: pointer;
  list-style-type: none;
}

.listaFile {
  display: flex;
  padding-top: 1.5rem;
  padding-bottom: 1.5rem;
}

.jpg::before {
  content: "\f1c5";
  font-family: "Font Awesome 5 free";
  color: rgb(103, 103, 104);
  font-size: 2rem;
  font-weight: 900;
  padding-right: 5px;
}
.JPG::before {
  content: "\f1c5";
  font-family: "Font Awesome 5 free";
  color: rgb(103, 103, 104);
  font-size: 2rem;
  font-weight: 900;
  padding-right: 5px;
}
.PNG::before {
  content: "\f1c5";
  font-family: "Font Awesome 5 free";
  color: rgb(103, 103, 104);
  font-size: 2rem;
  font-weight: 900;
  padding-right: 5px;
}
.png::before {
  content: "\f1c5";
  font-family: "Font Awesome 5 free";
  color: rgb(103, 103, 104);
  font-size: 2rem;
  font-weight: 900;
  padding-right: 5px;
}
.pdf::before {
  content: "\f1c4";
  font-family: "Font Awesome 5 free";
  color: rgb(103, 103, 104);
  font-size: 2rem;
  font-weight: 900;
  padding-right: 5px;
}
.pptx::before {
  content: "\f1c1";
  font-family: "Font Awesome 5 free";
  color: rgb(103, 103, 104);
  font-size: 2rem;
  font-weight: 900;
  padding-right: 5px;
}
.docx::before {
  content: "\f1c2";
  font-family: "Font Awesome 5 free";
  color: rgb(103, 103, 104);
  font-size: 2rem;
  font-weight: 900;
  padding-right: 5px;
}
.txt::before {
  content: "\f15c";
  font-family: "Font Awesome 5 free";
  color: rgb(103, 103, 104);
  font-size: 2rem;
  font-weight: 900;
  padding-right: 5px;
}
</style>