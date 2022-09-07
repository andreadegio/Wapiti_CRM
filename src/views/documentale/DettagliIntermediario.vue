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
          <h4>Elenco prodotti attivi</h4>
        </div>
        <CDataTable
          id="prodotti_table"
          :items="prodotti"
          :fields="fields_PRODOTTI"
          ref="tabella_prod"
          sorter
          hover
          border
          pagination
          :table-filter="{
            placeholder: 'Ricerca...',
            label: 'Ricerca:',
          }"
          striped
          :itemsPerPage="20"
          :items-per-page-select="{ label: 'Risultati per pagina' }"
          :noItemsView="{ noItems: ' ' }"
        >
          <template #Intermediario_Codice="{ item }">
            <td class="text-center">{{ item.Intermediario_Codice }}</td>
          </template>
          <template #Codice_Ramo="{ item }">
            <td class="text-center">{{ item.Codice_Ramo }}</td>
          </template>
        </CDataTable>
      </div>
      <div>
        <CButton
          color="primary"
          class="ml-2"
          variant="outline"
          :to="{ name: 'Documentale', params: { origine: 'Emittenti' } }"
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

//COLONNE PER IL DATAGRID DEI PRODOTTI
const fields_PRODOTTI = [
  {
    key: "Compagnia",
    _style: "font-weight: bold; text-align:center;",
    label: "Compagnia",
  },
  {
    key: "Intermediario_Codice",
    _style: "font-weight: bold; text-align:center;",
    label: "Codice Intermediario",
  },
  {
    key: "Codice_Ramo",
    _style: "font-weight: bold; text-align:center;",
    label: "Codice Ramo",
  },
  {
    key: "Sotto_Prodotto",
    _style: "font-weight: bold; text-align:center;",
    label: "Tipo Contratto",
  },
  {
    key: "Prodotto",
    _style: "font-weight: bold; text-align:center;",
    label: "Denominazione Interna Prodotto",
  },
];
export default {
  name: "DettagliIntermediario",
  components: {},
  props: ["intermediario", "elenco"],
  data() {
    return {
      prodotti: [],
      fields_PRODOTTI,
    };
  },

  mounted() {
    this.recupera_prodotti(this.intermediario.IdAnagrafica);
    localStorage.setItem("elenco_origine", JSON.stringify(this.elenco));
  },
  methods: {
    async recupera_prodotti(idIntermediario) {
      // Chiamata per recuperare i prodotti dell'intermediario
      // console.log("chiamo per l'id" + idIntermediario);
      try {
        var config = {
          method: "post",
          url:
            this.$custom_json.servizi_broker +
            this.$custom_json.ep_broker.ProdottiIntermediario,
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
        const risposta_prodotti = await axios(config);
        // console.log(risposta_prodotti);
        this.prodotti = risposta_prodotti.data;
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

.btn-outline-primary:hover{
  color:#fff !important;
}
</style>

