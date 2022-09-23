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
        <!-- <CDataTable
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
          <template #RilieviDiAby="{ item }">
            <td class="py-2 text-center">
              <router-link
                :to="{
                  name: 'Rilievi_Audit',
                  params: {
                    intermediario: item,
                    oldData: UO,
                    origine: 'DettaglioProponente',
                    richiesta: 'Aby',
                    proponenti: proponenti,
                    proponente: intermediario
                  },
                }"
              >
                <CButton size="sm" color="primary" variant="outline">
                  Mostra
                </CButton>
              </router-link>
            </td>
          </template>
          <template #RilieviIntermediari="{ item }">
            <td class="py-2 text-center">
              <router-link
                :to="{
                  name: 'Rilievi_Audit',
                  params: {
                    intermediario: item,
                    oldData: UO,
                    origine: 'DettaglioProponente',
                    richiesta: 'Int',
                    proponenti: proponenti,
                    proponente: intermediario
                  },
                }"
              >
                <CButton size="sm" color="primary" variant="outline">
                  Mostra
                </CButton>
              </router-link>
            </td>
          </template>
          <template #Audit="{ item }">
            <td class="py-2 text-center">
              <router-link
                :to="{
                  name: 'Rilievi_Audit',
                  params: {
                    intermediario: item,
                    oldData: UO,
                    origine: 'DettaglioProponente',
                    richiesta: 'Aud',
                    proponenti: proponenti,
                    proponente: intermediario
                  },
                }"
              >
                <CButton size="sm" color="primary" variant="outline">
                  Mostra
                </CButton>
              </router-link>
            </td>
          </template>
        </CDataTable> -->
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
// const fields_UO = [
//   {
//     key: "RagioneSociale",
//     _style: "font-weight: bold; text-align:center;",
//     label: "Ragione Sociale",
//   },
//   {
//     key: "RUI",
//     _style: "font-weight: bold; text-align:center;",
//     label: "RUI",
//   },
//   {
//     key: "RilieviDiAby",
//     label: "Rilievi di Aby",
//     sorter: false,
//     filter: false,
//     _style: "text-align:center;",
//   },
//   {
//     key: "RilieviIntermediari",
//     label: "Rilievi Intermediario",
//     sorter: false,
//     filter: false,
//     _style: "text-align:center;",
//   },
//   {
//     key: "Audit",
//     label: "Audit",
//     sorter: false,
//     filter: false,
//     _style: "text-align:center;",
//   },
// ];
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

