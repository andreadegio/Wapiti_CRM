
<template>
  <div class="my-3 mx-3">
    <div v-show="contenuto == 'Assicurazioni'">
      <CTabs variant="tabs" :active-tab="0">
        <CTab title="Comunicazioni">
          <CCardGroup class="latest container">
            <CCard class="mx-2" accent-color="info">
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
            </CCard>
            <CCard class="mx-2" accent-color="info">
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
            <CCard class="mx-2" accent-color="info">
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

            <CCard class="mx-2" accent-color="info">
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
            <CCard class="mx-2" accent-color="info">
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
        <CTab title="Allegati">
          <div class="container">
            {{ tree_RC }}
            <div
              v-for="elemento in tree_RC"
              :key="elemento.descrizione"
              :class="elemento.ext"
              class="cloud"
            >
              {{ elemento.descrizione }}
              <cite style="font-size: 0.7rem" v-show="elemento.tipo != 'directory'"
                >({{ elemento.size }}byte)</cite
              >
              <cite
                style="font-size: 0.7rem"
                v-show="
                  elemento.tipo == 'directory' && elemento.contenuto == null
                "
                >(cartella vuota)</cite
              >
            </div>

            Materiale a disposizione da scaricare
          </div>
        </CTab>
      </CTabs>
    </div>
    <div v-show="contenuto == 'Energy'">
      <CCardGroup class="latest">
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
    </div>
  </div>
</template>
<script>
import axios from "axios";

export default {
  props: ["contenuto"],

  data() {
    return {
      tree_RC: {},
    };
  },
  created() {
    this.get_tree_rc();
    alert(this.contenuto);
  },
  methods: {
    async get_tree_rc() {
      await axios
        .get(this.$custom_json.api_url + this.$custom_json.ep_api.cloudRC)
        .then((response) => {
          this.tree_RC = response.data;
          // console.log(response.data); nb
        });
    },
  },
};
</script>
<style scoped>
/* CLASSI PER LA VISUALIZZAZIONE DEI FILE DEL CLOUD  */
.cloud {
  cursor: pointer;
  list-style-type: none;
}
.jpg::before {
  content: "\f1c5";
  font-family: "Font Awesome 5 free";
  color: rgb(103, 103, 104);
  font-size: 2em;
  font-weight: 900;
  padding-right: 5px;
}
.pdf::before {
  content: "\f1c1";
  font-family: "Font Awesome 5 free";
  color: rgb(103, 103, 104);
  font-size: 2em;
  font-weight: 900;
  padding-right: 5px;
}
.txt::before {
  content: "\f15c";
  font-family: "Font Awesome 5 free";
  color: rgb(103, 103, 104);
  font-size: 2em;
  font-weight: 900;
  padding-right: 5px;
}
.directory::before {
  content: "\f07b";
  font-family: "Font Awesome 5 free";
  color: rgb(252, 198, 3);
  font-size: 2em;
  font-weight: 900;
  padding-right: 5px;
}
.directory:hover::before {
  content: "\f07c";
  font-family: "Font Awesome 5 free";
  color: rgb(252, 198, 3);
  font-size: 2em;
  font-weight: 900;
  padding-right: 5px;
}
.directory.highlight::before {
  content: "\f07c";
  font-family: "Font Awesome 5 free";
  color: rgb(252, 198, 3);
  font-size: 2em;
  font-weight: 900;
  padding-right: 5px;
}

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