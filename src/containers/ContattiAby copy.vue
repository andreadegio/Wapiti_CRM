<template>
  <!-- <CCardHeader class="d-flex justify-content-between">
      <strong class="h4 titolo_gradient">CONTATTI ABY</strong>
    </CCardHeader> -->

  <CRow align-horizontal="center">
    <!-- <CCol sm="3" v-for="(contatto,index) in elenco_contatti" :key="index" class="card_contatto">
      <div class="h4 titolo_gradient text-center">{{contatto.descrizione}}</div>
      <p class="my-3 text-justify">
        <i class="far fa-envelope fa-fw"></i> Mail:
        <span class="mail">{{contatto.mail}}</span>
      </p>
      <p class="my-3 text-justify">
        <i class="fas fa-phone fa-fw"></i> Telefono:
        <span style="text-transform: lowercase">{{contatto.telefono}}</span>
      </p>
      <p class="my-3 text-justify">
        <i class="fas fa-mobile-alt fa-fw"></i> Telegram: {{contatto.telegram}}
      </p>
    </CCol>
    
  </CRow> -->

  <CTabs
      variant="pills"
      :active-tab="0"
      vertical="true"
      add-nav-wrapper-classes="col-sm-4"
      add-tabs-wrapper-classes="col-sm-8"
    >
      <CTab title="Servizi Gas e Luce">
        <p
            class="my-3 text-justify" 
            v-show="chisono.DirettoreCommerciale_TelefonoFisso"
          >
            <i class="fas fa-phone fa-fw"></i> Telefono:
           <span style="text-transform:lowercase"> {{ chisono.DirettoreCommerciale_TelefonoFisso }}</span>
          </p>
          
      </CTab>
      <CTab title="Polizze RC Auto">
        <p
            class="my-3 text-justify" 
            
          >
            <i class="fas fa-phone fa-fw"></i> Telefono:
           <span style="text-transform:lowercase"> {{ chisono.DirettoreCommerciale_TelefonoFisso }}</span>
          </p>
           <p
            class="my-3 text-justify"
            
          >
            <i class="far fa-envelope fa-fw"></i> Mail:
            <span class="mail">{{ chisono.DirettoreCommerciale_Email }}</span>
          </p>
      </CTab>
      <CTab title="Polizze Flotte e Trasporti"> Text will not be shown. </CTab>
      <CTab title="Polizze Individuali e Professionisti">
        Text will not be shown.
      </CTab>
      <CTab title="Polizze Aziende e Fidejussioni">
        Text will not be shown.
      </CTab>
      <CTab title="Servizio Sinistri"> Text will not be shown. </CTab>
      <CTab title="Area Amministrativa"> Text will not be shown. </CTab>
    </CTabs>
     </CCol>
    
  </CRow>
  <!-- <table>
      <thead>
        <tr>
          <th class="header_contatti riga_tabella">Settore</th>
          <th>Telefono</th>
          <th>Mail</th>
          <th>Telegram</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td class="header_contatti riga_tabella">Servizi Gas e Luce</td>
          <td>02-86882871 interno</td>
          <td>energy@.....</td>
          <td>telegram</td>
        </tr>
        <tr>
          <td class="header_contatti riga_tabella">Polizze RC Auto</td>
          <td>02-86882871 interno</td>
          <td>mail@.....</td>
          <td>telegram</td>
        </tr>
        <tr>
          <td class="header_contatti riga_tabella">
            Polizze Flotte e Trasporti
          </td>
          <td>02-86882871 interno</td>
          <td>mail@.....</td>
          <td>telegram</td>
        </tr>
        <tr>
          <td class="header_contatti riga_tabella">
            Polizze Individuali e Professionisti
          </td>
          <td>02-86882871 interno</td>
          <td>mail@.....</td>
          <td>telegram</td>
        </tr>
        <tr>
          <td class="header_contatti riga_tabella">
            Polizze Aziende e Fidejussioni
          </td>
          <td>02-86882871 interno</td>
          <td>mail@.....</td>
          <td>telegram</td>
        </tr>
        <tr>
          <td class="header_contatti riga_tabella">Servizio Sinistri</td>
          <td>02-86882871 interno</td>
          <td>mail@.....</td>
          <td>telegram</td>
        </tr>
        <tr>
          <td class="header_contatti riga_tabella">Area Amministrativa</td>
          <td>02-86882871 interno</td>
          <td>mail@.....</td>
          <td>telegram</td>
        </tr>
      </tbody>
    </table> -->
</template>
<script>
export default {
  name: "ContattiAby",
  data() {
    return {
      chisono: JSON.parse(localStorage.getItem("chisono_data")),
      elenco_contatti: [
        {
        "descrizione" : "Servizi Gas e Luce",
        "mail" : "esempio@email.com",
        "telefono":"02-86882871 int XYZ",
        "telegram":"333-123456789"},
        {
        "descrizione" : "Polizze RC Auto",
        "mail" : "esempio@email.com",
        "telefono":"02-86882871 int XYZ",
        "telegram":"333-123456789"},
        {
        "descrizione" : "Polizze Flotte e Trasporti",
        "mail" : "esempio@email.com",
        "telefono":"02-86882871 int XYZ",
        "telegram":"333-123456789"},
        {
        "descrizione" : "Polizze Individuali e Professionisti",
        "mail" : "esempio@email.com",
        "telefono":"02-86882871 int XYZ",
        "telegram":"333-123456789"},
        {
        "descrizione" : "Polizze aziende e Fidejussioni",
        "mail" : "esempio@email.com",
        "telefono":"02-86882871 int XYZ",
        "telegram":"333-123456789"},
        {
        "descrizione" : "Servizio Sinistri",
        "mail" : "esempio@email.com",
        "telefono":"02-86882871 int XYZ",
        "telegram":"333-123456789"},
        
        ]
    };
  },
};
</script>
<style scoped>
.titolo_gradient {
  background: -webkit-linear-gradient(#ef7918, #1f4b6b);
  background-clip: border-box;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  font-weight: 700;
  text-transform: uppercase;
  border-bottom: 1px solid lightgray;
}
.header_contatti {
  background-color: #ddd;
  left: 0;
  position: sticky;
  z-index: 9999;
}
.riga_tabella {
  padding-top: 2rem;
  padding-bottom: 2rem;
  padding-left: 1rem;
}

.card_contatto {
  display: block;
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  box-sizing: border-box;
  border: 1px solid lightgray;
  border-radius: 5px;
  margin: 10px;
  min-width: 30% !important;
  background-color: white;
}
.card_contatto p {
  font-size: 1.1rem;
  font-weight: 100;
}
</style>