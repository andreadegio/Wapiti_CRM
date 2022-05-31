<template>
  <CCard class="h-100 px-4 pb-5" style="z-index: 10">
    <CCardHeader class="d-flex justify-content-between">
      <strong class="h4 titolo_gradient">CONTATTI ABY</strong>
    </CCardHeader>
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
  </CCard>
</template>
<script>
export default {
  name: "ContattiAby",
  data() {
    return {
      chisono: JSON.parse(localStorage.getItem("chisono_data")),
    };
  },
};
</script>
<style scoped>
/* #manager .list-group-item {
  border-left: 0px !important;
  border-right: 0px !important;
  border-bottom: 0px !important;
  border-radius: 0px !important;
}
#manager li {
  border-top: 1px solid rgba(0, 0, 21, 0.125) !important;
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
} */

.titolo_gradient {
  background: -webkit-linear-gradient(#ef7918, #1f4b6b);
  background-clip: border-box;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  font-weight: 700;
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
</style>