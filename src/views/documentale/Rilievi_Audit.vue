<template>
  <CContainer class="align-items-center min-vh-100">
    <div
      class="container mt-3"
      style="background-color: white; border-radius: 5px"
    >
      <VisualizzaDocumento />
      <div class="text-center pb-2">
        <h1>{{ intermediario.RagioneSociale }}</h1>
        <h4>({{ intermediario.Descrizione }})</h4>
      </div>
      <div class="pt-4">
        <div
          class="text-center h4"
          style="color: #ee7a13"
          v-if="docs.length == 0"
        >
          - Non sono ancora presenti {{ subTitle }} -
        </div>
        <div v-else id="titolo_tabella" class="text-center">
          <h4>Elenco {{ subTitle }}</h4>
        </div>
        <CDataTable
          v-show="docs.length > 0"
          id="UO_table"
          :items="docs"
          :fields="fields_Dettaglio"
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
          <template #Download="{ item }">
            <td class="text-center">
              <a
                :href="item.Id"
                @click.prevent="
                  preview(item.Id, richiesta);
                  titoloModale(
                    richiesta == 'Aud' ? 'AUDIT' : 'RILIEVO',
                    item.Numero_Formatted
                  );
                "
              >
                <i class="fas fa-download fa-2x"></i
              ></a>
            </td>
          </template>
        </CDataTable>
      </div>
      <div>
        <CButton
          v-if="proponente"
          color="primary"
          class="ml-2"
          variant="outline"
          :to="{
            name: 'DettagliProponente',
            params: {
              intermediario: proponente,
              proponenti: proponenti,
            },
          }"
        >
          <i class="fas fa-chevron-left"></i> Indietro</CButton
        >
        <CButton
          v-else
          color="primary"
          class="ml-2"
          variant="outline"
          :to="{ name: 'Documentale', params: { origine: origine } }"
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
import VisualizzaDocumento from "../../containers/VisualizzaDocumento";
// NOMI DELLE COLONNE PER DATA TABLE UNITA OPERATIVE
const fields_Dettaglio = [
  {
    key: "Numero_Formatted",
    _style: "font-weight: bold; text-align:center;",
    label: "Numero",
  },
  {
    key: "Insert_Date",
    _style: "font-weight: bold; text-align:center;",
    label: "Data creazione",
  },
  {
    key: "Insert_User",
    _style: "text-align:center;",
    label: "Inserito da",
  },
  {
    key: "Update_Date",
    label: "Data aggiornamento",
    _style: "text-align:center;",
  },
  {
    key: "Update_User",
    label: "Aggiornato da",
    _style: "text-align:center;",
  },
  {
    key: "Note",
    label: "Note",
    sorter: false,
    filter: false,
    _style: "text-align: center;",
  },
  {
    key: "Download",
    label: "Download",
    sorter: false,
    filter: false,
    _style: "text-align: center;",
  },
];
export default {
  name: "Rilievi_Audit",
  components: { VisualizzaDocumento },
  props: [
    "intermediario",
    "oldData",
    "origine",
    "richiesta",
    "proponenti",
    "proponente",
  ], // nell'oldData passo il datagrid di origine(emitt/propo/uo)
  data() {
    return {
      viewFile: false, // Usato per mostrare la modale con l'antprima del file
      timer: 0, // Utilizzato per temporizzare il passaggio dall'apertura di un documento a l'altro
      select: true, // utilizzato per la visualizzazione del file per far partire il loader o meno
      docs: [],
      fields_Dettaglio,
      subTitle: "",
    };
  },

  mounted() {
    this.recuperaDocs(this.intermediario.IdAnagrafica);
    localStorage.setItem("elenco_origine", JSON.stringify(this.oldData));
    switch (this.richiesta) {
      case "Aby":
        this.subTitle = "Rilievi di Aby";
        break;
      case "Int":
        this.subTitle = "Rilievi Intermediario";
        break;
      case "Aud":
        this.subTitle = "Audit";
        break;
    }
  },

  methods: {
    async recuperaDocs(idIntermediario) {
      let end_point;
      // Chiamata per recuperare le agenzie attive dell'intermediario
      switch (this.richiesta) {
        case "Aby":
          end_point =
            this.$custom_json.servizi_broker +
            this.$custom_json.ep_broker.RilieviDiAby;
          break;
        case "Int":
          end_point =
            this.$custom_json.servizi_broker +
            this.$custom_json.ep_broker.RilieviIntermediari;
          break;
        case "Aud":
          end_point =
            this.$custom_json.servizi_broker +
            this.$custom_json.ep_broker.Audit;
          break;
      }

      try {
        var config = {
          method: "post",
          url: end_point,
          headers: {
            userID: localStorage.getItem("userID"),
            anagraficaid: localStorage.getItem("anagraficaID"),
            unitaoperativaId: localStorage.getItem("unitaoperativaID"),
            ID: idIntermediario,
          },
        };
        const risposta = await axios(config);
        // console.log(risposta);
        this.docs = risposta.data;
      } catch (error) {
        console.log("errore" + error);
      }
    },
    // CHIAMATA PER VISUALIZZARE I PDF
    preview(url, dest) {
      var end_point = "";
      switch (dest) {
        case "Aud":
          end_point =
            this.$custom_json.servizi_broker +
            this.$custom_json.ep_broker.Download_Documentale_Audit +
            "/";
          break;
        case "Aby":
          end_point =
            this.$custom_json.servizi_broker +
            this.$custom_json.ep_broker.Download_Documentale_Rilievi +
            "/";
          break;
        case "Int":
          end_point =
            this.$custom_json.servizi_broker +
            this.$custom_json.ep_broker.Download_Documentale_Rilievi +
            "/";
          break;
      }

      this.viewFile = true;
      if (this.timer == 0) {
        this.select = false;
        this.file_name = end_point + url;
        this.timer = 1;
        setTimeout(() => {
          this.timer = 0;
        }, 8000);
      } else {
        this.file_name = "";
        // console.log("riprovo");
        setTimeout(() => {
          this.preview(url, dest);
        }, 1000);
      }
    },
    titoloModale(tipologia, descrizione, tipoFile) {
      this.tipologia = tipologia;
      this.descrizione = descrizione;
      this.tipoFile = tipoFile;
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

