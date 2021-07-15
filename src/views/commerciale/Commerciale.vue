<template>
  <div id="aree" class="pt-4 px-4">
    <CJumbotron class="px-0 py-2 latest">
      <p class="pl-3 h3" style="font-weight: lighter; font-size: 2rem">
        Ultimi contenuti caricati
      </p>
      <CCardGroup class="latest">
        <CCard class="mx-2 card_materiale" accent-color="success">
          <CCardHeader
            ><strong> <u>GAS & LUCE</u> </strong></CCardHeader
          >
          <CCardImg src="upload/energy1.jpg" style="min-height: 200px">
          </CCardImg>
          <CCardBody class="pb-2"
            ><h2>Titolo di prova</h2>
            <cite>01 Luglio 2021</cite>
            <div>Contenuto di prova nella sezione Gas & Luce</div>
          </CCardBody>
          <CCardFooter><strong>Mostra Contenuto</strong> </CCardFooter>
        </CCard>
        <CCard class="mx-2 card_materiale" accent-color="info">
          <CLink to="Commerciale/Comunicazione/Abyway">
            <CCardHeader>
              <strong> <u>ASSICURAZIONI</u> </strong>
            </CCardHeader>
            <CCardImg src="upload/auto1.jpg"> </CCardImg>
            <CCardBody class="pb-2"
              ><h2>Arriva ABYONE</h2>
              <cite>01 Luglio 2021</cite>
              <div>
                Ti presentiamo tutti i servizi inclusi nel nuovo prodotto ABYONE
              </div>
            </CCardBody>
            <CCardFooter><strong>Mostra Contenuto</strong> </CCardFooter>
          </CLink>
        </CCard>
        <CCard class="mx-2 card_materiale" accent-color="info">
          <CCardHeader
            ><strong> <u>ASSICURAZIONI</u> </strong>
          </CCardHeader>
          <CCardImg src="upload/auto2.jpg"> </CCardImg>
          <CCardBody class="pb-2"
            ><h2>Materiale Grafico</h2>
            <cite>01 Luglio 2021</cite>
            <div>Loghi e Carta intestata ABY</div>
          </CCardBody>
          <CCardFooter><strong>Mostra Contenuto</strong> </CCardFooter>
        </CCard>
        <CCard class="mx-2 card_materiale" accent-color="info">
          <CCardHeader
            ><strong> <u>ASSICURAZIONI</u> </strong>
          </CCardHeader>
          <CCardImg src="upload/auto3.jpg"> </CCardImg>
          <CCardBody class="pb-2"
            ><h2>Titolo di prova</h2>
            <cite>01 Luglio 2021</cite>
            <div>Contenuto di prova nella sezione Assicurazioni</div>
          </CCardBody>
          <CCardFooter><strong>Mostra Contenuto</strong></CCardFooter>
        </CCard>
        <CCard class="mx-2 card_materiale" accent-color="success">
          <CCardHeader
            ><strong> <u>GAS & LUCE</u> </strong></CCardHeader
          >
          <CCardImg src="upload/energy2.jpg"> </CCardImg>
          <CCardBody class="pb-2"
            ><h2>Titolo di prova</h2>
            <cite>01 Luglio 2021</cite>
            <div>Contenuto di prova nella sezione Gas & Luce</div>
          </CCardBody>
          <CCardFooter><strong>Mostra Contenuto</strong> </CCardFooter>
        </CCard>
      </CCardGroup>
    </CJumbotron>
    <CJumbotron style="" class="blue_logo">
      <CCol
        md="5"
        style="
          background-image: url('img/buttons/auto.png');
          background-position: center;
          background-size: cover;
          border-top-left-radius: 5px;
          border-bottom-left-radius: 5px;
          border-top-right-radius: 0px;
          border-bottom-right-radius: 0px;
        "
      ></CCol>
      <CCol md="7" class="py-5">
        <h1 class="display-3">Assicurazioni</h1>
        <p class="lead">
          Materiale e comunicazioni commerciali per il mondo assicurativo
        </p>
        <p>RCA - Rami Elementari</p>
        <CButton
          size="lg"
          style="color: white; background-color: #ef7a12"
          to="Commerciale/Assicurazioni"
          >Accedi ai contenuti</CButton
        >
        <div class="mt-3" v-if="admin">
          <CLink to="AdminCommerciale" class="" style="color: white !important"
            ><CIcon name="cil-settings" /><strong> Gestione</strong>
          </CLink>
        </div>
      </CCol>
    </CJumbotron>
    <CJumbotron
      style="
        display: flex;
        color: white;
        padding: 3px;

        background: linear-gradient(180deg, #0e7731, #139e42) !important;
        box-shadow: 0 3px 5px -1px rgba(0, 0, 0, 0.2),
          0 6px 10px 0 rgba(0, 0, 0, 0.14), 0 1px 18px 0 rgba(0, 0, 0, 0.12) !important;
      "
    >
      <CCol md="7" class="py-5 text-right">
        <h1 class="display-3">Gas & Luce</h1>
        <p class="lead">
          Materiale e comunicazioni commerciali per il mondo Energy
        </p>
        <p>Gas & Luce</p>

        <CButton
          size="lg"
          style="color: white; background-color: #ef7a12"
          to="Commerciale/Energy"
          >Accedi ai contenuti</CButton
        >
        <div class="mt-3" v-if="admin">
          <CLink to="AdminCommerciale" class="" style="color: white !important"
            ><CIcon name="cil-settings" /><strong> Gestione</strong>
          </CLink>
        </div>
      </CCol>
      <CCol
        md="5"
        style="
          background-image: url('img/buttons/energy.jpg');
          background-position: center;
          background-size: cover;
          border-top-left-radius: 0px;
          border-bottom-left-radius: 0px;
          border-top-right-radius: 5px;
          border-bottom-right-radius: 5px;
        "
        class="py-0"
      >
      </CCol>
    </CJumbotron>
  </div>
</template>

<script>
export default {
  data() {
    return {
      admin: JSON.parse(localStorage.getItem("chisono_data")).Is_Sede,
    };
  },
};
</script>

<style scoped>
.latest a:hover{
  text-decoration: none;
}
.jumbotron {
  margin-bottom: 1rem !important;
  display: flex;
  background: linear-gradient(180deg, #1e2f56, #2e467c) !important;
  box-shadow: 0 3px 5px -1px rgba(0, 0, 0, 0.2),
    0 6px 10px 0 rgba(0, 0, 0, 0.14), 0 1px 18px 0 rgba(0, 0, 0, 0.12) !important;
  color: white;
  padding: 3px;
}
.jumbotron.latest {
  margin-bottom: 1rem !important;
  display: flex;
  background: linear-gradient(180deg, #807e7e, #cecece) !important;
  box-shadow: 0 3px 5px -1px rgba(0, 0, 0, 0.2),
    0 6px 10px 0 rgba(0, 0, 0, 0.14), 0 1px 18px 0 rgba(0, 0, 0, 0.12) !important;
  color: white;
  padding: 3px;
}
</style>

