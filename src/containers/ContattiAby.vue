<template>
  <div>
    <CModal
      color="dark"
      centered
      :show.sync="modale_contatto"
      style="z-index: 30"
      size="lg"
    >
      <template #header style="background-color: #1f4b6b !important">
        <strong style="text-transform: uppercase"
          >Recapiti per {{ dati_modale.descrizione }}</strong
        >
        <CButton class="close" @click="modale_contatto = false">
          <span aria-hidden="true">&times;</span>
        </CButton>
      </template>
      <template>
        <div class="d-flex align-items-center">
          <CContainer fluid>
            <CRow class="justify-content-center">
              <CCol md="10">
                <CCard>
                  <CCardBody>
                    <h1>{{ dati_modale.descrizione }}</h1>
                    <p class="text-muted"></p>
                    <p>Telefono: {{ dati_modale.telefono }}</p>
                    <p>Mail: {{ dati_modale.mail }}</p>
                    <p>Telegram: {{ dati_modale.telegram }}</p>
                    <p v-show="dati_modale.form_contatto != null">
                      INSERISCI IL TUO NUMERO DI TELEFONO PER ESSERE
                      RICONTATTATO form di contatto
                    </p>
                  </CCardBody>
                </CCard>
              </CCol>
            </CRow>
          </CContainer>
        </div>
      </template>

      <template #footer>
        <CButton
          @click="modale_contatto = false"
          color="dark"
          size="sm"
          variant="outline"
        >
          Chiudi
        </CButton>
      </template>
    </CModal>
    <CCard class="h-100">
      <CCardHeader class="d-flex justify-content-between">
        <strong class="h4 titolo_gradient">RECAPITI</strong>
        <div class="card-header-actions"></div>
      </CCardHeader>
      <CCardBody id="manager" class="news_card py-0">
        <CListGroup class="contatto">
          <CListGroupItem
            v-for="(contatto, index) in elenco_contatti"
            :key="index"
            class="flex-column align-items-start"
            v-show="chisono.DirettoreCommerciale"
          >
            <div
              class="d-flex w-100 justify-content-center py-3"
              style="text-transform: uppercase"
              @click="show_contatto(index)"
            >
              <h5>
                <strong>{{ contatto.descrizione }}</strong>
              </h5>
            </div>
          </CListGroupItem>
        </CListGroup>
      </CCardBody>
    </CCard>
  </div>
</template>
<script>
export default {
  name: "ContattiAby",
  data() {
    return {
      chisono: JSON.parse(localStorage.getItem("chisono_data")),
      modale_contatto: false,
      dati_modale: [],
      elenco_contatti: [
        {
          descrizione: "Servizi Gas e Luce",
          mail: "esempio@email.com",
          telefono: "02-86882871 int XYZ",
          orarioTelefono: "orario 9-12:30 / 14:30-18:30",
          telegram: "333-123456789",
          orarioTelegram: "orario 11-18",
          form_contatto: null,
        },
        {
          descrizione: "Polizze RC Auto",
          mail: "esempio@email.com",
          telefono: "02-86882871 int XYZ",
          orarioTelefono: "orario 9-12:30 / 14:30-18:30",
          telegram: "333-123456789",
          orarioTelegram: "orario 11-18",
          form_contatto: null,
        },
        {
          descrizione: "Polizze Flotte e Trasporti",
          mail: "esempio@email.com",
          telefono: "02-86882871 int XYZ",
          orarioTelefono: "orario 9-12:30 / 14:30-18:30",
          telegram: "333-123456789",
          orarioTelegram: "orario 11-18",
          form_contatto: null,
        },
        {
          descrizione: "Polizze Individuali e Professionisti",
          mail: "esempio@email.com",
          telefono: "02-86882871 int XYZ",
          orarioTelefono: "orario 9-12:30 / 14:30-18:30",
          telegram: "333-123456789",
          orarioTelegram: "orario 11-18",
          form_contatto: null,
        },
        {
          descrizione: "Polizze aziende e Fidejussioni",
          mail: "esempio@email.com",
          telefono: "02-86882871 int XYZ",
          orarioTelefono: "orario 9-12:30 / 14:30-18:30",
          telegram: "333-123456789",
          orarioTelegram: "orario 11-18",
          form_contatto: null,
        },
        {
          descrizione: "Servizio Sinistri",
          mail: "esempio@email.com",
          telefono: "Clicca per essere contattato",
          orarioTelefono: "orario 11-18",
          telegram: "333-123456789",
          orarioTelegram: "orario 11-18",
          form_contatto: "mail_per_richiamare",
        },
        {
          descrizione: "Area Amministrativa",
          mail: "esempio@email.com",
          telefono: "Clicca per essere contattato",
          orarioTelefono: "orario 11-18",
          telegram: "333-123456789",
          orarioTelegram: "orario 11-18",
          form_contatto: "mail_per_richiamare",
        },
      ],
    };
  },
  methods: {
    show_contatto(index) {
      this.modale_contatto = true;
      this.dati_modale = {
        descrizione: this.elenco_contatti[index].descrizione,
        mail: this.elenco_contatti[index].mail,
        telefono: this.elenco_contatti[index].telefono,
        orariTelefono: this.elenco_contatti[index].orariTelefono,
        telegram: this.elenco_contatti[index].telegram,
        orariTelegram: this.elenco_contatti[index].orariTelegram,
        form_contatto: this.elenco_contatti[index].form_contatto,
      };
      console.log(index);
    },
  },
};
</script>
<style scoped>
.contatto li:hover {
  cursor: pointer;
  background-color: #ef791898;
}
.card-header {
  border-bottom: 0px !important;
}
.card-footer {
  border-top: 0px !important;
}

#manager .list-group-item {
  border-left: 0px !important;
  border-right: 0px !important;
  border-bottom: 0px !important;
  border-radius: 0px !important;
}
#manager li {
  border-top: 1px solid rgba(0, 0, 21, 0.125) !important;
}
#manager li:last-of-type {
  border-bottom: 1px solid rgba(0, 0, 21, 0.125) !important;
}

#manager p {
  font-size: 1.1rem;
  font-weight: 100;
}

#manager p.nome {
  font-weight: 500;
  text-transform: capitalize;
}

#manager span.mail {
  text-transform: lowercase;
}

#manager .fa-fw {
  color: #1f4b6b;
}

.titolo_gradient {
  background: -webkit-linear-gradient(#ef7918, #1f4b6b);
  background-clip: border-box;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  font-weight: 700;
}
</style>