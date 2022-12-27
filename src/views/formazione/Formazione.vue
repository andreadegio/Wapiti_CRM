<template>
  <div class="pt-2" :class="corsi_filtrati.length && 'formazione_style'">
    
    <div v-if="corsi_filtrati.length > 0" class="row display-4 pb-3">
      <div class="col-12 text-center">Tutti i corsi a te riservati</div>
    </div>
    <p
      v-if="corsi_filtrati.length > 0"
      class="text-center"
      style="font-weight: 600; font-variant: small-caps; margin-bottom: 0px !important; "
    >
      Totale corsi presenti: {{ corsi_filtrati.length }}
    </p>
    <div id="filtro_ricerca" class="mt-2 mx-5 riquadro row">
      <div class="text-left col-sm-3 separatore">
        <strong> <i class="fas fa-filter"></i> Filtra per anno:</strong>
        <treeselect
          v-model="filtroAnno"
          class=" ml-2 filtro"
          :multiple="false"
          :options="anni_select"
          :max-height="300"
          placeholder="Seleziona un anno"
        />
      </div>
      <div class="text-left col-sm-3 separatore">
        <strong> <i class="fas fa-filter"></i> Filtra per categoria:</strong>
        <treeselect
          v-model="filtroCat"
          class=" ml-2 filtro"
          :multiple="false"
          :options="categorie"
          :max-height="300"
          placeholder="Seleziona una categoria"
        />
      </div>
      <div class="text-left col-sm-3 separatore">
        <strong><i class="fas fa-search"></i> Ricerca: </strong><br/>
        <input
          v-model="ricercaTxt"
          id="ricercaTesto"
          placeholder="Testo da cercare"
          class="filtro mx-1 inputSearch"
          style="
            border-bottom: 1px solid gray !important;
            border-left: 0 !important;
            border-right: 0 !important;
            border-top: 0 !important;
            background-color: unset !important;
            border-radius: 0 !important;
            padding-left: 3px !important;
            margin-bottom: 0 !important;
            width: 100%;
            line-height: 2rem;
          "
        />
      </div>
      
      <div class="text-right col-sm-3" v-if="admin">
        <CLink to="AdminFormazione" style="color: #ef7918 !important"
          ><CIcon name="cil-settings" /><strong> Gestione contenuti</strong>
        </CLink>
      </div>
    </div>
    <div>
      <div v-if="corsi_filtrati.length == 0" class="col-12 text-center">
        <h1 class="display-4 mr-4 pb-5">Non sono presenti corsi</h1>
      </div>
    </div>
    <div v-if="corsi_filtrati.length > 0" class="row">
      <div class="col-sm-12">
        <div class="row justify-content-center">
          <CCardGroup class="latest col-10">
            <div
              class="col-lg-3 col-sm-6 px-0"
              v-for="(item, index) in corsi_filtrati"
              :key="index"
            >
              <CCard class="mx-1 card_materiale">
                <CLink
                  :to="{
                    name: 'Corso',
                    params: {
                      corso: item.titolo,
                      id: item.id,
                      lista_corsi: corsi,
                    },
                  }"
                >
                  <CCardImg
                    :src="$custom_json.base_url + item.copertina"
                    style="height: 15rem; object-fit: cover"
                    alt="- IMPOSSIBILE CARICARE -"
                  >
                  </CCardImg>
                  <CBadge
                    v-if="
                      lista_nuovi != null && lista_nuovi.includes(item.id_corso)
                    "
                    color="danger"
                    class="badgeNuovo"
                    >Nuovo
                  </CBadge>
                  <CBadge
                   v-if="item.priority == 1"                    
                    class="badgePin"
                    ><i class="fas fa-thumbtack fa-2x"></i><br/><p style="color: black !important;">Importante</p>
                  </CBadge>

                  <CCardBody
                    class="py-1 px-2 card_post"
                    :style="{ '--bgColor': item.color_categoria }"
                    style="min-height: 10rem"
                  >
                    <div class="text-uppercase settore_color pt-3">
                      <strong>
                        <u>{{ item.categoria }}</u>
                      </strong>
                    </div>

                    <div class="titolo text-left pt-3">
                      {{ item.titolo | truncate(20, "[...]") }}
                    </div>
                    <div class="row dettagli pt-4 pb-5 text-center">
                      <div class="col-6">
                        <i class="far fa-calendar-alt"></i>
                        {{ item.data_ins | formatDate }}
                      </div>
                      <div class="col-6">
                        <i class="far fa-clock"></i> {{ item.durata }} minuti
                      </div>
                    </div>
                    <div class="text-right"></div>
                  </CCardBody>
                  <CCardFooter class="text-right py-2">
                    <div
                      class="views"
                      v-c-tooltip="{
                        content: 'Visualizzazioni ',
                        placement: 'bottom-end',
                      }"
                    >
                      <i class="far fa-eye"></i> {{ item.visite }}
                    </div>
                    <strong>Vai al corso...</strong>
                  </CCardFooter>
                </CLink>
              </CCard>
            </div>
          </CCardGroup>
        </div>
      </div>
      <div class="col-1"></div>
    </div>
  </div>
</template>

<script>
import Treeselect from "@riophae/vue-treeselect";
import "@riophae/vue-treeselect/dist/vue-treeselect.css";
import axios from "axios";

export default {
  name: "AreaFormazione",
  components: {
    Treeselect,
  },
  data() {
    return {
      admin: JSON.parse(localStorage.getItem("chisono_data")).Is_Sede,
      isEnergy: JSON.parse(localStorage.getItem("chisono_data"))
        .Abilitato_Energy,
      isAuto: JSON.parse(localStorage.getItem("chisono_data")).Abilitato_Auto,
      corsi: [],
      // corsi_filtrati: [],
      bgColor: "#1F4B6B",
      lista_nuovi: [],
      filtroCat: null,
      categorie: [],
      anni_select: [],

      // anni_select: [
      //   {
      //     id: "2022",
      //     label: "2022",
      //   },
      //   { id: "2023", label: "2023" },
      // ],
      filtroAnno: null,
      ricercaTxt: "",
    };
  },
  computed: {
    corsi_filtrati() {
      let tempCorsi = this.corsi;

      // Ricerca testuale
      if (this.ricercaTxt != "" && this.ricercaTxt) {
        tempCorsi = tempCorsi.filter((item) => {
          return item.titolo
            .toUpperCase()
            .includes(this.ricercaTxt.toUpperCase());
        });
      }
      // Filtro per categoria
      if (!this.filtroCat) {
        // console.log("niente filtro");
        tempCorsi = tempCorsi.slice(0);
      } else {
        // console.log("filtro");
        tempCorsi = tempCorsi.filter((a) => a.id_categoria == this.filtroCat);
      }
      // Filtro per anno di pubblicazione
      if (this.filtroAnno) {
        tempCorsi = tempCorsi.filter((a) => {
          return a.data_ins.substr(0, 4).includes(this.filtroAnno);
        });
      }
      return tempCorsi;
    },
  },
  mounted() {
    this.get_lista_corsi();
    this.getToSee();
    this.get_categorie();
    // this.filtra_risultati();
  },
  methods: {
    async getToSee() {
      // Chiamata per recuperare l'array dei corsi da leggere
      let params = {
        categoria: "Corso",
        utente: localStorage.getItem("userID"),
        tipo_uo: JSON.parse(localStorage.getItem("chisono_data"))
          .UnitaOperativa_Tipo_ID,
      };
      try {
        await axios
          .post(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.ep_api.get_toSee,
            { params }
          )
          .then((response) => {
            this.lista_nuovi = response.data;
          });
      } catch (error) {
        console.log("errore: " + error);
      }
    },
    async get_lista_corsi() {
      // Chiamata per recuperare la lista dei corsi
      let params = {
        UO_tipo: JSON.parse(localStorage.getItem("chisono_data"))
          .UnitaOperativa_Tipo_ID,
        is_sede: JSON.parse(localStorage.getItem("chisono_data")).Is_Sede,
      };
      var lista_corsi = [];
      try {
        await axios
          .post(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.ep_api.lista_corsi,
            { params },
            {
              header: {
                "Content-Type": "multipart/form-data",
              },
            }
          )
          .then((response) => {
            lista_corsi = response.data;
          });
        this.corsi = lista_corsi.map((item, id) => {
          return { ...item, id };
        });
        // console.log("corsi "+ this.corsi);
        // this.corsi_filtrati = this.corsi.slice(0);
        // console.log("corsi filtrati " + this.corsi_filtrati);
      } catch (error) {
        console.log("impossibile accedere al cloud");
      }
      // Genero l'elenco degli anni disponibili per popolare la select del filtro per anno
      // this.anni_select = this.corsi.map((event) => {
      //   return {
      //     id: new Date(event.data_ins).getFullYear(),
      //     label: new Date(event.data_ins).getFullYear(),
      //   };
      // });
      const result = [
        ...new Set(
          this.corsi.map((event) => new Date(event.data_ins).getFullYear())
        ),
      ];
      result.forEach((element) => {
        // console.log(element);
        this.anni_select.push({ id: element, label: element });
        // console.log(this.anni_select);
      });
      // console.log("filtrato= ", result);
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
        // this.categorie = lista_corsi.map((item, id) => {
        //   return { ...item, id };
        // });
      } catch (error) {
        console.log("impossibile recuperare le categorie");
      }
    },
  },
};
</script>

<style scoped>
.card_post::before {
  content: "";
  display: block;
  position: absolute;
  /* top: 0; */
  width: 50%;
  left: 0;
  height: 8px;
  background: linear-gradient(
    to right,
    var(--bgColor) 60%,
    rgba(255, 255, 255, 0) 100%
  );
  /* border-top: 8px solid var(--bgColor); */
}
.latest a:hover {
  text-decoration: none;
}
.settore_color {
  /* color: var(--bgColor); */
  opacity: 0.6;
  padding-top: 4px !important;
  margin-left: -5px !important;
}
.separatore{
  border-right: 1px dotted gray;
}
.titolo {
  font-size: 1.8rem !important;
  max-width: 95%;
  white-space: nowrap;
  overflow: hidden;
  /* text-overflow: ellipsis; */
  letter-spacing: 0.05rem;
}

.dettagli {
  font-size: 0.8rem !important;
  text-transform: uppercase;
  letter-spacing: 0.025em;
  color: #ef7918 !important;
}
.card-img,
.card-img-bottom {
  border-bottom-right-radius: 0 !important;
  border-bottom-left-radius: 0 !important;
}
.formazione_style {
  display: grid;
  overflow: hidden;
}
.badgeNuovo {
  position: absolute;
  z-index: 99;
  right: 45%;
  top: 50%;
  padding: 0.4em 0.4em !important;
  box-shadow: 0 3px 5px -1px rgba(0, 0, 0, 0.2),
    0 6px 10px 0 rgba(0, 0, 0, 0.55), 0 1px 18px 0 rgba(223, 78, 78, 0.83) !important;
}
.badgePin {
  transform: rotate(25deg);
  color: red;
  position: absolute;
  z-index: 99;
  right: 0%;
  top: 0%;
  padding: 0.4em 0.4em !important;
  /* box-shadow: 0 3px 5px -1px rgba(0, 0, 0, 0.2),
    0 6px 10px 0 rgba(0, 0, 0, 0.55), 0 1px 18px 0 rgba(223, 78, 78, 0.83) !important;
     */
}
.fa-thumbtack{
  stroke: rgba(0, 0, 0, 0.73);
  stroke-width: 20;
}
.riquadro {
  border: 1px solid lightgray;
  border-radius: 10px;
  padding: 0.5rem;
  background-color: aliceblue;
  margin-bottom: 3px !important;
}
.views {
  position: absolute;
  top: auto;
  left: 5px;
  right: auto;
  color: rgb(164, 160, 160);
  font-size: 0.7rem;
}
.filtro {
  display: inline-table;
  vertical-align: middle;
  padding: 0px;
}
#ricercaTesto .form-control {
  border-bottom: 1px solid gray !important;
  border-left: 0 !important;
  border-right: 0 !important;
  border-top: 0 !important;
  background-color: unset !important;
  border-radius: 0 !important;
  padding-left: 3px !important;
  margin-bottom: 0 !important;
}
</style>

