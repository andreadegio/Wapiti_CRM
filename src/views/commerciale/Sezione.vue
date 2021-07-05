
<template>
  <div class="my-3 mx-3">
    <div v-show="sezione == 'Assicurazioni'">
      <CTabs variant="tabs" :active-tab="0">
        <CTab title="Comunicazioni">
          <CCardGroup class="latest container">
            <CCard class="mx-2" accent-color="info">
              <CCardHeader>
                <strong> <u>ASSICURAZIONI</u> </strong>
              </CCardHeader>
              <CCardImg variant="none" src="../upload/auto1.jpg"> </CCardImg>
              <CCardBody class="pb-2"
                ><h2>Arriva ABYONE</h2>
                <cite>01 Luglio 2021</cite>
                <div>
                  Ti presentiamo tutti i servizi inclusi nel nuovo prodotto
                  ABYONE
                </div>
              </CCardBody>
              <CCardFooter><strong>Mostra Contenuto</strong> </CCardFooter>
            </CCard>
            <CCard class="mx-2" accent-color="info">
              <CCardHeader
                ><strong> <u>ASSICURAZIONI</u> </strong>
              </CCardHeader>
              <CCardImg variant="none" src="../upload/auto2.jpg"> </CCardImg>
              <CCardBody class="pb-2"
                ><h2>Materiale Grafico</h2>
                <cite>01 Luglio 2021</cite>
                <div>Loghi e Carta intestata ABY</div>
              </CCardBody>
              <CCardFooter><strong>Mostra Contenuto</strong> </CCardFooter>
            </CCard>
            <CCard class="mx-2" accent-color="info">
              <CCardHeader
                ><strong> <u>ASSICURAZIONI</u> </strong>
              </CCardHeader>
              <CCardImg variant="none" src="../upload/auto3.jpg"> </CCardImg>
              <CCardBody class="pb-2"
                ><h2>Titolo di prova</h2>
                <cite>01 Luglio 2021</cite>
                <div>Contenuto di prova nella sezione Assicurazioni</div>
              </CCardBody>
              <CCardFooter><strong>Mostra Contenuto</strong></CCardFooter>
            </CCard>

            <CCard class="mx-2" accent-color="info">
              <CCardHeader
                ><strong> <u>ASSICURAZIONI</u> </strong>
              </CCardHeader>
              <CCardImg variant="none" src="../upload/auto2.jpg"> </CCardImg>
              <CCardBody class="pb-2"
                ><h2>Materiale Grafico</h2>
                <cite>01 Luglio 2021</cite>
                <div>Loghi e Carta intestata ABY</div>
              </CCardBody>
              <CCardFooter><strong>Mostra Contenuto</strong> </CCardFooter>
            </CCard>
            <CCard class="mx-2" accent-color="info">
              <CCardHeader
                ><strong> <u>ASSICURAZIONI</u> </strong>
              </CCardHeader>
              <CCardImg variant="none" src="../upload/auto3.jpg"> </CCardImg>
              <CCardBody class="pb-2"
                ><h2>Titolo di prova</h2>
                <cite>01 Luglio 2021</cite>
                <div>Contenuto di prova nella sezione Assicurazioni</div>
              </CCardBody>
              <CCardFooter><strong>Mostra Contenuto</strong></CCardFooter>
            </CCard>
          </CCardGroup>
        </CTab>
        <CTab title="Allegati">
          <div class="container">
            
            Materiale a disposizione da scaricare
          </div>
        </CTab>
      </CTabs>
    </div>
    <div v-show="sezione == 'Energy'">
      <CCardGroup class="latest">
        <CCard class="mx-2" accent-color="success">
          <CCardHeader
            ><strong> <u>GAS & LUCE</u> </strong></CCardHeader
          >
          <CCardImg
            variant="none"
            src="../upload/energy1.jpg"
            style="min-height: 200px"
          >
          </CCardImg>
          <CCardBody class="pb-2"
            ><h2>Titolo di prova</h2>
            <cite>01 Luglio 2021</cite>
            <div>Contenuto di prova nella sezione Gas & Luce</div>
          </CCardBody>
          <CCardFooter><strong>Mostra Contenuto</strong> </CCardFooter>
        </CCard>

        <CCard class="mx-2" accent-color="success">
          <CCardHeader
            ><strong> <u>GAS & LUCE</u> </strong></CCardHeader
          >
          <CCardImg variant="none" src="../upload/energy2.jpg"> </CCardImg>
          <CCardBody class="pb-2"
            ><h2>Titolo di prova</h2>
            <cite>01 Luglio 2021</cite>
            <div>Contenuto di prova nella sezione Gas & Luce</div>
          </CCardBody>
          <CCardFooter><strong>Mostra Contenuto</strong> </CCardFooter>
        </CCard>
        <CCard class="mx-2" accent-color="success">
          <CCardHeader
            ><strong> <u>GAS & LUCE</u> </strong></CCardHeader
          >
          <CCardImg variant="none" src="../upload/energy2.jpg"> </CCardImg>
          <CCardBody class="pb-2"
            ><h2>Titolo di prova</h2>
            <cite>01 Luglio 2021</cite>
            <div>Contenuto di prova nella sezione Gas & Luce</div>
          </CCardBody>
          <CCardFooter><strong>Mostra Contenuto</strong> </CCardFooter>
        </CCard>
        <CCard class="mx-2" accent-color="success">
          <CCardHeader
            ><strong> <u>GAS & LUCE</u> </strong></CCardHeader
          >
          <CCardImg variant="none" src="../upload/energy2.jpg"> </CCardImg>
          <CCardBody class="pb-2"
            ><h2>Titolo di prova</h2>
            <cite>01 Luglio 2021</cite>
            <div>Contenuto di prova nella sezione Gas & Luce</div>
          </CCardBody>
          <CCardFooter><strong>Mostra Contenuto</strong> </CCardFooter>
        </CCard>
        <CCard class="mx-2" accent-color="success">
          <CCardHeader
            ><strong> <u>GAS & LUCE</u> </strong></CCardHeader
          >
          <CCardImg variant="none" src="../upload/energy2.jpg"> </CCardImg>
          <CCardBody class="pb-2"
            ><h2>Titolo di prova</h2>
            <cite>01 Luglio 2021</cite>
            <div>Contenuto di prova nella sezione Gas & Luce</div>
          </CCardBody>
          <CCardFooter><strong>Mostra Contenuto</strong> </CCardFooter>
        </CCard>
      </CCardGroup>
    </div>
  </div>
</template>
<script>



export default {
  props: ["sezione"],

  data() {
    return {
      // eslint-disable-next-line vue/no-dupe-keys
      sezione: {},
    };
  },
};
</script>
<style scoped>
.latest {
  color: #3c4b64;
}
.card-accent-success {
  border-top: 0px solid #0e7731 !important;
}
.card-accent-info {
  border-top: 0px solid #223560 !important;
}
div.card-accent-info:before {
  content: "";
  position: absolute;
  left: 0;
  top: 0;
  height: 5px;
  width: 50%;
  border-top: 6px solid #223560 !important;
}
div.card-accent-success:before {
  content: "";
  position: absolute;
  left: 0;
  top: 0;
  height: 5px;
  width: 50%;
  border-top: 6px solid #0e7731 !important;
}

.card-img-none {
  max-height: 200px !important;
  min-height: 200px;
  object-fit: cover;
}

cite {
  color: #ef7a12;
  font-size: 0.8rem;
}
</style>