<template>
  <div>
    <AddCat
      color="dark"
      :centered="true"
      v-if="modale_cat"
      style="z-index: 30"
      size="lg"
      :closeOnBackdrop="true"
      @closeModalClick="chiudi()"
      @salvaCat="salva()"
      :id_old="id_cat"
      :desc_old="edit_desc"
      :color_old="edit_color"
      :action="action"
    />

    <!-- <CModal :show="showModaleUpload" centered>
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
    </CModal> -->

    <div
      style="background-color: white; border-radius: 0.3rem"
      class="container mt-2 card_post"
    >
      <div class="breadcrumbs">
        <CLink @click="back()" class="breadcrumbs_link">Gestione Corsi</CLink>
        > Gestione Categorie
      </div>
      <div class="justify-content-center">
        <h2 class="pl-2 text-center">Categorie presenti</h2>
        <div class="cover_box mb-3">
          <div style="background-color: white">
            <CDataTable
            class="p-2"
             :table-filter="{
              placeholder: 'Ricerca...',
              label: 'Ricerca nelle categorie:',
            }"
              :no-items-view="{
                noResults: 'Nessun filtro appliato',
                noItems: 'Nessuna categoria trovata',
              }"
              ref="tabella_cat"
              :fields="campi"
              :items="categorie"
              hover
              striped
            >
              <template #color="{ item }">
                <td class="py-3" style="text-align: center !important">
                  <div
                    class="riquadro_colore py-0 m-0"
                    :style="{ '--bgColor': item.color }"
                  ></div>
                </td>
              </template>
              <template #show_details="{ item }">
                <td class="py-2" style="text-align: center !important">
                  <CButton
                    size="sm"
                    color="warning"
                    class="ml-2"
                    @click="editCat(item)"
                  >
                    Modifica
                  </CButton>
                </td>
              </template>
            </CDataTable>
          </div>
        </div>

        <div class="container">
          <CButton
            style="color: white"
            color="primary"
            class="ml-2"
            @click="
              modale_cat = true;
              action = 'add';
            "
            ><i class="fas fa-plus fa-2x"></i><br />Aggiungi</CButton
          >
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import AddCat from "./AddCat.vue";
const campi = [
  { key: "label", label: "Descrizione" },
  { key: "color", label: "Colore", _classes: "text-center" },
  {
    key: "show_details",
    label: "Opzioni",
    sorter: false,
    filter: false,
    _classes: "text-center",
  },
];

export default {
  name: "GestioneCategorie",
  components: { AddCat },

  data() {
    return {
      loader: false,
      campi,
      filtroCat: null,
      categorie: [],
      modale_cat: false,
      id_cat: "",
      edit_desc: "",
      edit_color: "",
      action: "",
    };
  },
  mounted() {
    this.get_categorie();
  },
  methods: {
    editCat(item) {
      this.id_cat = item.id;
      this.edit_desc = item.label;
      this.edit_color = item.color;
      this.action = "edit";
      this.modale_cat = true;
    },
    async get_categorie() {
      // Chiamata per recuperare la lista delle categorie
      try {
        await axios
          .post(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.ep_api.categorie_formazione,

            {
              header: {
                "Content-Type": "multipart/form-data",
              },
            }
          )
          .then((response) => {
            this.categorie = response.data;
          });
      } catch (error) {
        console.log("impossibile recuperare le categorie");
      }
    },
    back() {
      this.$emit("back");
    },

    chiudi() {
      this.modale_cat = false;
      this.action = "";
      this.get_categorie();
      this.$forceUpdate();
    },

    cambiaPaginazioneTabella(per_page_items) {
      // crea oggetto da inviare alla CDataTable per cambiare la paginazione
      let pagination_object = {
        target: {
          value: per_page_items,
        },
      };
      // chiama la funzione di cambio paginazione sulla CDataTable
      this.$refs.tabella_cat.paginationChange(pagination_object);
    },
    forzaUpdateTabella() {
      // per forzare l'update della CDataTable simulo un cambio di paginazione
      // salva l'attuale valore di paginazione
      // metti paginazione a 1
      // rimetti attuale valore di paginazione
      // in questo modo la tabella si ri-renderizza
      let old_val = this.$refs.tabella_cat.perPageItems;
      this.cambiaPaginazioneTabella(1);
      this.cambiaPaginazioneTabella(old_val);
    },
  },
};
</script>

<style>
.riquadro_colore {
  display: inline-block;
  border: 1px solid black;
  width: 25px;
  height: 25px;
  background-color: var(--bgColor);
  border-radius: 20px;
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
table {
  margin-bottom: 0px !important;
}
</style>