<template>
  <div style="background-color: white">
    <div class="copertina">
      <CImg :src="$custom_json.base_url + lista_corsi[id].copertina" />

      <section
        class="box_contenuti"
        :style="{ '--bgColor': lista_corsi[id].color_settore }"
      >
        <div
          class="text-uppercase settore_color py-3"
          :style="{ '--bgColor': lista_corsi[id].color_settore }"
        >
          <strong
            ><u>{{ lista_corsi[id].settore }}</u></strong
          >
        </div>

        <div class="titolo pb-3">{{ lista_corsi[id].titolo }}</div>
        <div class="sottotitolo pb-3">
          {{ lista_corsi[id].sottotitolo }}
        </div>
        <div class="row dettagli pt-4 text-center">
          <div class="col-6">
            <i class="far fa-calendar-alt"></i>
            {{ lista_corsi[id].data_ins | formatDate }}
          </div>
          <div class="col-6">
            <i class="far fa-clock"></i> {{ lista_corsi[id].durata }} minuti
          </div>
        </div>
      </section>
    </div>
    <div class="container pt-5">
      <div class="row">
        <div class="col-md-8">
          <div class="contenuto pb-4">
            <span class="descrizione_header"
              >Cosa imparerai con questo corso</span
            >
            <div
              class="descrizione_corso text-justify pt-3 pl-3"
              v-html="lista_corsi[id].contenuto"
            ></div>
          </div>

          <span class="obiettivi_header">
            <CImg src="/img/formazione/obiettivo.png" width="3%" /> Obiettivi di
            questo corso</span
          >
          <div
            class="descrizione_obiettivi text-justify pt-2 pl-3"
            v-html="lista_corsi[id].obiettivi"
          ></div>
        </div>

        <div class="col-md-4 colonna_dx" v-show="
              lista_corsi[id].allegati && lista_corsi[id].files.length > 0
            ">
          <div
            class="allegati"            
          >
            <span class="titolo_allegati ml-3">
              <i class="fas fa-paperclip"></i> Materiale del corso:</span
            >
            
            <div class="listaFile text-center">
              <div
                class="file"
                v-for="allegato in lista_corsi[id].files"
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
          <Visualizzatore
            :showDoc="showDoc"
            :file="file"
            :ext="ext"
            :nome_file="nome_file"
            @aggiorna_modale="aggiorna_modale"
          />
        </div>
      </div>
    </div>

    <div class="container pt-4">
      <div class="navigazione" v-show="lista_corsi.length > 1">
        <hr />
        <div class="row">
          <div class="col-6 text-right navigazione-col">
            <span
              class="text-muted indicatore"
              style="font-size: 1rem"
              v-if="lista_corsi[id].id < last"
              >Precedente <br
            /></span>

            <span class="prev text-muted h6" v-if="lista_corsi[id].id < last">
              <CLink
                :to="{
                  name: 'Corso',
                  params: {
                    corso: lista_corsi[lista_corsi[id].id + 1].titolo,
                    id: lista_corsi[lista_corsi[id].id + 1].id,
                    lista_corsi: lista_corsi,
                  },
                }"
              >
                <em v-if="lista_corsi[id].id < last">{{
                  lista_corsi[lista_corsi[id].id + 1].titolo
                }}</em>
              </CLink>
            </span>
          </div>
          <div class="col-6">
            <span
              class="text-muted"
              style="font-size: 1rem"
              v-if="lista_corsi[id].id != 0"
              >Successiva <br
            /></span>
            <span class="next text-muted h6" v-if="lista_corsi[id].id != 0">
              <CLink
                :to="{
                  name: 'Corso',
                  params: {
                    corso: lista_corsi[lista_corsi[id].id - 1].titolo,
                    id: lista_corsi[lista_corsi[id].id - 1].id,
                    lista_corsi: lista_corsi,
                  },
                }"
              >
                <em v-if="lista_corsi[id].id != 0">{{
                  lista_corsi[lista_corsi[id].id - 1].titolo
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
  name: "Corso",
  // ricevo dalla pagina Commerciale.vue il titolo della notizia utilizzato per l'url, l'id e la lista completa dei post
  props: ["corso", "id", "lista_corsi"],
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
      nome_file: "",
    };
  },
  mounted() {
    if (!this.lista_corsi) {
      console.log("parametri mancanti");
      this.$router.push("..");
    }
    this.last = this.lista_corsi[this.lista_corsi.length - 1].id;
  },
  methods: {
    aggiorna_modale(value) {
      this.showDoc = value;
    },
  },
};
</script>

<style scoped>
.listaFile {
  /* margin-left: 50%; */
  margin-right: auto;
}
.box_contenuti::before {
  content: "";
  display: block;
  position: absolute;
  /* top: 0; */
  width: 50%;
  left: 1rem;
  height: 8px;
  background: linear-gradient(
    to right,
    var(--bgColor) 60%,
    rgba(255, 255, 255, 0) 100%
  );
  /* border-top: 8px solid var(--bgColor); */
}
.settore_color {
  color: var(--bgColor);
  opacity: 0.5;
}
.box_contenuti {
  background-color: rgba(255, 255, 255, 0.871);
  top: 10%;
  position: absolute;
  left: 10%;
  padding: 3rem;
}
.data {
  color: #ef7a12;
  font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;

  font-size: 0.8rem !important;
  text-transform: uppercase;
  letter-spacing: 0.025em;
}

.titolo {
  font-size: 3.5rem !important;
  letter-spacing: 0.08rem;
  line-height: 2rem;
  font-weight: 350;
}
.sottotitolo {
  font-size: 1.5rem;
  line-height: 2rem;
  font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
  color: #3e4857;
  font-weight: 300;
  font-style: oblique;
}
.copertina img {
  vertical-align: middle;
  max-height: 350px;
  width: 100%;
  object-fit: cover;
  object-position: 50% 50%;
  border: 0;
}
.titolo_allegati {
  font-size: 1.8rem;
  font-weight: 300;
  letter-spacing: 0.06rem;
  line-height: 2rem;
  color: gray;
  font-style: oblique;
}
.obiettivi_header {
  font-size: 2rem;
  font-weight: 300;
  letter-spacing: 0.06rem;
  line-height: 4rem;
  color: gray;
  font-style: oblique;
}
.descrizione_obiettivi {
  font-size: 1rem;
  font-weight: 300;
  padding-bottom: 2rem;
  color: black;
  font-style: oblique;
}
.descrizione_header {
  font-size: 3rem;
  font-weight: 300;
  letter-spacing: 0.06rem;
  line-height: 4rem;
  color: gray;
  font-style: oblique;
}
.descrizione_corso {
  font-size: 1.2rem;
  font-weight: 100;
  padding-bottom: 2rem;
  color: black;
}
.colonna_dx {
  -webkit-box-shadow: 5px 5px 20px -1px #000000;
  -moz-box-shadow: 5px 5px 20px -1px #000000;
  -o-box-shadow: 5px 5px 20px -1px #000000;
  box-shadow: 5px 5px 20px -1px #000000;
}
.dettagli {
  font-size: 0.8rem !important;
  text-transform: uppercase;
  letter-spacing: 0.025em;
  color: #ef7a12 !important;
  font-weight: 600;
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
@import "/css/cloud.css";
</style>