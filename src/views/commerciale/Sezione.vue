
<template>
  <div class="my-3 mx-3">
    <div v-show="contenuto == 'Assicurazioni'">
      <CTabs variant="tabs" :active-tab="0">
        <CTab>
          <template slot="title"  >
            <i class="fas fa-rss fa-2x"></i> <span class="tabs-nav"> Comunicazioni</span>
          </template>
          <CCardGroup class="latest container">
            <CCard class="mx-2 card_materiale" accent-color="info"
              >
              <CLink to="Comunicazione/Abyway">
              <CCardHeader>
                <strong> <u>ASSICURAZIONI</u> </strong>
              </CCardHeader>
              <CCardImg src="../upload/auto1.jpg"> </CCardImg>
              <CCardBody class="pb-2"
                ><h2>Arriva ABYONE</h2>
                <cite>01 Luglio 2021</cite>
                <div>
                  Ti presentiamo tutti i servizi inclusi nel nuovo prodotto
                  ABYONE
                </div>
              </CCardBody>
              <CCardFooter><strong>Mostra Contenuto</strong> </CCardFooter>
              </CLink>
            </CCard>

            <CCard class="mx-2 card_materiale" accent-color="info">
              <CCardHeader
                ><strong> <u>ASSICURAZIONI</u> </strong>
              </CCardHeader>
              <CCardImg src="../upload/auto2.jpg"> </CCardImg>
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
              <CCardImg src="../upload/auto3.jpg"> </CCardImg>
              <CCardBody class="pb-2"
                ><h2>Titolo di prova</h2>
                <cite>01 Luglio 2021</cite>
                <div>Contenuto di prova nella sezione Assicurazioni</div>
              </CCardBody>
              <CCardFooter><strong>Mostra Contenuto</strong></CCardFooter>
            </CCard>

            <CCard class="mx-2 card_materiale" accent-color="info">
              <CCardHeader
                ><strong> <u>ASSICURAZIONI</u> </strong>
              </CCardHeader>
              <CCardImg src="../upload/auto2.jpg"> </CCardImg>
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
              <CCardImg src="../upload/auto3.jpg"> </CCardImg>
              <CCardBody class="pb-2"
                ><h2>Titolo di prova</h2>
                <cite>01 Luglio 2021</cite>
                <div>Contenuto di prova nella sezione Assicurazioni</div>
              </CCardBody>
              <CCardFooter><strong>Mostra Contenuto</strong></CCardFooter>
            </CCard>
          </CCardGroup>
        </CTab>
        <CTab>
          <template slot="title" >
            <i class="fas fa-paperclip fa-2x"></i> <span class="tabs-nav"> Materiale</span>
          </template>
          <PersonalCloud :area="contenuto" />
        </CTab>
      </CTabs>
    </div>
    <div v-show="contenuto == 'Energy'">
      <CTabs variant="tabs" :active-tab="0">
        <CTab>
          <template slot="title" >
            <i class="fas fa-rss fa-2x"></i> <span class="tabs-nav"> Comunicazioni</span>
          </template>
          <CCardGroup class="latest container">
            <CCard class="mx-2" accent-color="success">
              <CCardHeader
                ><strong> <u>GAS & LUCE</u> </strong></CCardHeader
              >
              <CCardImg src="../upload/energy1.jpg" style="min-height: 200px">
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
              <CCardImg src="../upload/energy2.jpg"> </CCardImg>
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
              <CCardImg src="../upload/energy2.jpg"> </CCardImg>
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
              <CCardImg src="../upload/energy2.jpg"> </CCardImg>
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
              <CCardImg src="../upload/energy2.jpg"> </CCardImg>
              <CCardBody class="pb-2"
                ><h2>Titolo di prova</h2>
                <cite>01 Luglio 2021</cite>
                <div>Contenuto di prova nella sezione Gas & Luce</div>
              </CCardBody>
              <CCardFooter><strong>Mostra Contenuto</strong> </CCardFooter>
            </CCard>
          </CCardGroup>
        </CTab>
        <CTab>
          <template slot="title" >
            <i class="fas fa-paperclip fa-2x"></i> <span class="tabs-nav"> Materiale</span>
          </template>
          <PersonalCloud :area="contenuto" />
        </CTab>
      </CTabs>
    </div>
  </div>
</template>
<script>
import PersonalCloud from "./cloud.vue";
export default {
  name: "Area_tematica",
  props: ["contenuto"],

  data() {
    return {
      tree_RC: {},
    };
  },
  components: {
    PersonalCloud,
  },
};
</script>
<style scoped>
.latest a:hover{
  text-decoration: none;
}
.tabs-nav{
  font-size: 1.5rem !important;
}
</style>