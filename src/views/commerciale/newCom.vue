<template>
  <div style="background-color: white" class="container mt-2">
    <div class="row">
      <div class="p-3 rounded col-8">
        <h2 class="pl-2">Inserimento di una nuova comunicazione</h2>
        <CInput label="Titolo" type="text" placeholder="Assegna un titolo" />
        <vue-editor v-model="content" class="pb-3"></vue-editor>
      </div>
      <div class="col-4">
        Carica o cerca un'immagine per la copertina<br />
        <div id="carica_cover" class="cover_box">
          <img v-if="thumb" :src="thumb" height="50" class="m-2" />
          <input type="file" @change="previewFiles" ref="file" />
          <button v-if="thumb" @click="resetCover" style="color: darkred">
            <i class="far fa-trash-alt fa-lg"></i>
          </button>
          <div class="input-group mt-2">
            <input
              type="text"
              class="form-control"
              placeholder="Che immagine vuoi cercare?"
              ref="query"
            />
            <div class="input-group-append">
              <button class="btn btn-secondary" type="button" @click="searchImg($refs.query.value)">
                <i class="fa fa-search"></i>
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { VueEditor } from "vue2-editor";

export default {
  name: "nuovaComunicazione",
  components: {
    VueEditor,
  },
  data() {
    return {
      content: "",
      // file: application.$refs.file,

      thumb: "",
    };
  },
  methods: {
    previewFiles(event) {
      // console.log(event.target.files);
      this.thumb = URL.createObjectURL(event.target.files[0]);
    },
    resetCover() {
      this.$refs.file.value = null;
      this.thumb = null;
    },
    searchImg(query){
      console.log(query);
    }
  },
};
</script>

<style>
.cover_box {
  border: 1px solid darkgray;
  padding: 0.4rem;
}
.ql-container.ql-snow {
  border-radius: 0 0 0.5rem 0.5rem !important;
}
.ql-toolbar.ql-snow {
  border-radius: 0.5rem 0.5rem 0 0 !important;
}
</style>