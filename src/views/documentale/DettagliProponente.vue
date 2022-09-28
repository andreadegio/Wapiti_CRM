<template>
  <CContainer class="align-items-center min-vh-100">
    <div
      class="container mt-3"
      style="background-color: white; border-radius: 5px"
    >
      <div class="text-center pb-2">
        <h1>{{ intermediario.RagioneSociale }}</h1>
        <h4>({{ intermediario.Descrizione }})</h4>
      </div>
      <div class="pt-4">
        <div id="titolo_tabella" class="text-center">
          <h4>Elenco Unità Operative attive</h4>
        </div>
        <CDataTable
          id="UO_table"
          :items="UO"
          :fields="fields_UO"
          ref="tabella_doc"
          sorter
          hover
          border
          :itemsPerPage="20"
          pagination
          :table-filter="{
            placeholder: 'Ricerca...',
            label: 'Ricerca:',
          }"
          striped
          :items-per-page-select="{ label: 'Risultati per pagina' }"
          :noItemsView="{ noItems: ' ' }"
        >
          <template #RUI="{ item }">
            <td class="text-center">{{ item.RUI }}</td>
          </template>
        </CDataTable>
      
      </div>
      <div>
        <CButton
          color="primary"
          class="ml-2"
          variant="outline"
          :to="{ name: 'Documentale', params: { origine: 'Proponenti' } }"
        >
          <i class="fas fa-chevron-left"></i> Indietro</CButton
        >
      </div>

      <br />
    </div>
  </CContainer>
</template>

<script >
import axios from "axios";

// NOMI DELLE COLONNE PER DATA TABLE UNITA OPERATIVE
const fields_UO = [
  {
    key: "Descrizione",
    _style: "font-weight: bold; text-align:center;",
    label: "Descrizione",
  },
  {
    key: "RagioneSociale",
    _style: "font-weight: bold; text-align:center;",
    label: "Ragione Sociale",
  },
  {
    key: "RUI",
    _style: "font-weight: bold; text-align:center;",
    label: "RUI",
  },
];

export default {
  name: "DettagliProponente",
  components: {},
  props: ["intermediario", "proponenti"],
  data() {
    return {
      UO: [],
      fields_UO,
    };
  },

  mounted() {
    this.recuperaUO(this.intermediario.IdAnagrafica);
    localStorage.setItem("elenco_origine", JSON.stringify(this.proponenti));
  },

  methods: {
    async recuperaUO(idIntermediario) {
      // Chiamata per recuperare le agenzie attive dell'intermediario
      try {
        var config = {
          method: "post",
          url:
            this.$custom_json.servizi_broker +
            this.$custom_json.ep_broker.AgenzieIntermediario,
          headers: {
            userID: localStorage.getItem("userID"),
            anagraficaid: localStorage.getItem("anagraficaID"),
            unitaoperativaId: localStorage.getItem("unitaoperativaID"),
            unitaOperativaTipologiaId: JSON.parse(
              localStorage.getItem("chisono_data")
            ).UnitaOperativa_Tipo_ID,
            intermediarioId: idIntermediario,
          },
        };
        const rispostaUO = await axios(config);
        // console.log(risposta_prodotti);
        this.UO = rispostaUO.data;
      } catch (error) {
        console.log("errore" + error);
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

.btn-outline-primary:hover {
  color: #fff !important;
}
</style>

