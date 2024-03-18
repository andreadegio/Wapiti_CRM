<template>
  <div id="aree" class="pt-4 px-5">
    <CJumbotron class="px-0 py-2 latest" v-show="post.length > 0">
      <h1 class="text-right pl-1 display-4">Ultimi inserimenti</h1>
      <CCardGroup class="latest top5 p-3 col-12">
        <CCard
          class="mx-2 px-0 card_materiale card_post col-md-2"
          v-for="(item, index) in post.slice(0, 5)"
          :key="index"
          :style="{ '--bgColor': item.color_settore }"
        >
          <CLink
            :to="{
              name: 'Comunicazione',
              params: { notizia: item.titolo, id: item.id, lista_post: post },
            }"
          >
            <CCardHeader class="text-uppercase pt-0 titolo_color"
              ><strong>
                <u>{{ item.label_settore }}</u>
              </strong></CCardHeader
            >
            <CCardImg
              :src="$custom_json.base_url + item.copertina"
              style="height: 7rem; object-fit: cover"
              alt="- IMPOSSIBILE CARICARE -"
              class="py-0"
            >
            </CCardImg>
            <CBadge
              v-if="lista_nuovi != null && lista_nuovi.includes(item.id_post)"
              color="danger"
              class="badgeNuovo"
              >Nuovo
            </CBadge>
            <CCardBody class="px-1 py-0">
              <!-- <div class="text-right">
                <cite> {{ item.data_ins | formatDate }}</cite>
              </div> -->
              <h2 class="text-center py-0">{{ item.titolo }}</h2>
            </CCardBody>
            <CCardFooter class="text-center py-0"
              ><span style="font-weight: 400">Leggi di più ...</span>
            </CCardFooter>
          </CLink>
        </CCard>
      </CCardGroup>
    </CJumbotron>
    <CJumbotron style="" class="blue_logo" v-if="isAuto">
      <CCol md="4" class="py-5 justify-content-center">
        <h1
          class="titolo-display text-center"
          style="font-weight: initial !important"
        >
          Assicurazioni
        </h1>

        <CButton
          class="btnAssicurazioni mt-3"
          size="lg"
          to="Commerciale/Assicurazioni"
          >Apri la sezione</CButton
        >
        <div class="mt-3" v-if="admin">
          <CLink
            to="AdminCommerciale/Assicurazioni"
            class=""
            style="color: white !important"
            ><CIcon name="cil-settings" /><strong> Gestione contenuti</strong>
          </CLink>
        </div>
      </CCol>
      <CCol
        md="8"
        style="
          background-image: url('img/buttons/auto.png');
          background-position: center;
          background-size: cover;
          border-radius: 0.5rem 1rem 1rem 0.5rem;
        "
      ></CCol>
    </CJumbotron>
    <CJumbotron class="Gas" v-if="isEnergy">
      <CCol
        md="8"
        style="
          background-image: url('img/buttons/energy.jpg');
          background-position: center;
          background-size: cover;
          border-radius: 1rem 0.5rem 0.5rem 1rem;
        "
        class="py-0"
      >
      </CCol>
      <CCol md="4" class="py-5 text-right">
        <h1
          class="titolo-display text-center"
          style="font-weight: initial !important"
        >
         Energia
        </h1>
        <!-- <p class="lead">
          Materiale e comunicazioni commerciali per il mondo Energy
        </p> -->

        <CButton class="mt-3 btnGas" size="lg" to="Commerciale/Energy"
          >Apri la sezione</CButton
        >
        <div class="mt-3" v-if="admin">
          <CLink to="AdminCommerciale/Energy" style="color: white !important"
            ><CIcon name="cil-settings" /><strong> Gestione contenuti</strong>
          </CLink>
        </div>
      </CCol>
    </CJumbotron>
  </div>
</template>

<script>
import axios from "axios";

export default {
  name: "Commerciale",
  data() {
    return {
      admin: JSON.parse(localStorage.getItem("chisono_data")).Is_Sede,
      isEnergy: JSON.parse(localStorage.getItem("chisono_data"))
        .Abilitato_Energy,
      isAuto: JSON.parse(localStorage.getItem("chisono_data")).Abilitato_Auto,
      post: [],
      lista_nuovi: [],
    };
  },
  mounted() {
    this.get_lista_post();
    this.getToSee();
    this.get_tipologie();
  },
  methods: {
    async get_tipologie() {
      // Chiamata per recuperare le tipologie di rapporto
      try {
        await axios
          .post(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.ep_api.tipologie_rapporto
          )
          .then((response) => {
            //       this.tipologie =  [
            //   {
            //     id: "ALL",
            //     label: "TUTTI",
            //     isDefaultExpanded: true,
            //     children: ,
            //   },
            // ],
            // la risposta con l'elenco delle tipologie di rapporto la salvo nello storage
            localStorage.setItem("tipologie", JSON.stringify(response.data));
            // console.log(JSON.stringify(response.data));
          });
      } catch (error) {
        console.log("impossibile accedere al cloud");
      }
    },
    async getToSee() {
      // Chiamata per recuperare l'array dei corsi da leggere
      let params = {
        categoria: "Post",
        utente: localStorage.getItem("userID"),
        tipo_uo: JSON.parse(localStorage.getItem("chisono_data"))
          .UnitaOperativa_Tipo_ID,
      };
      try {
        await axios
          .post(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.ep_api.get_toSee,
            { params }
          )
          .then((response) => {
            this.lista_nuovi = response.data;
          });
      } catch (error) {
        console.log("errore: " + error);
      }
    },
    async get_lista_post() {
      // Chiamata per recuperare la lista dei post
      let params = {
        UO_tipo: JSON.parse(localStorage.getItem("chisono_data"))
          .UnitaOperativa_Tipo_ID,
        is_sede: JSON.parse(localStorage.getItem("chisono_data")).Is_Sede,
      };
      var lista_post = [];
      try {
        await axios
          .post(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.ep_api.lista_post,
            { params },
            {
              header: {
                "Content-Type": "multipart/form-data",
              },
            }
          )
          .then((response) => {
            lista_post = response.data;
          });
        this.post = lista_post.map((item, id) => {
          return { ...item, id };
        });
        // console.log(this.post[0].color_settore);
      } catch (error) {
        console.log("impossibile accedere al cloud");
      }
      // console.log(JSON.stringify(this.post));
    },
  },
};
</script>

<style scoped>
.card_post::before {
  content: "";
  display: block;
  position: absolute;
  top: 0;
  width: 50%;
  left: 0;
  height: 8px;
  background: linear-gradient(
    to right,
    var(--bgColor) 60%,
    rgba(255, 255, 255, 0) 100%
  );
  border-radius: 1rem 0 0 0;
}
.titolo_color {
  color: var(--bgColor);
}

.latest a:hover {
  text-decoration: none;
}
.btnAssicurazioni {
  color: #1f4b6b !important;
  background-color: #ffffff;
  margin: 0 auto;
  display: block;
  max-width: max-content;
}
.btnAssicurazioni:hover {
  color: rgb(255, 255, 255) !important;
  background-color: #eba133;
}
.jumbotron {
  margin-bottom: 1rem !important;
  border-radius: 1rem;
  display: flex;
  background: linear-gradient(0deg, #1f4b6b, #798ebd);
  box-shadow: 0 3px 5px -1px rgba(0, 0, 0, 0.2),
    0 6px 10px 0 rgba(0, 0, 0, 0.14), 0 1px 18px 0 rgba(0, 0, 0, 0.12) !important;
  color: white;
  padding: 3px;
}
.jumbotron.latest {
  margin-bottom: 1rem !important;
  display: flex;
  background: linear-gradient(0deg, #7b7b7b, #cecece);
  box-shadow: 0 3px 5px -1px rgba(0, 0, 0, 0.2),
    0 6px 10px 0 rgba(0, 0, 0, 0.14), 0 1px 18px 0 rgba(0, 0, 0, 0.12) !important;
  color: white;
  padding: 3px;
}
.jumbotron.Gas {
  display: flex;
  color: white;
  padding: 3px;
  border-radius: 1rem;
  background: rgba(0, 0, 0, 0)
    linear-gradient(0deg, rgb(14, 119, 49), rgb(81, 213, 126)) repeat scroll 0%
    0% ;
  box-shadow: 0 3px 5px -1px rgba(0, 0, 0, 0.2),
    0 6px 10px 0 rgba(0, 0, 0, 0.14), 0 1px 18px 0 rgba(0, 0, 0, 0.12) !important;
}

.btnGas {
  color: rgb(14, 119, 49) !important;
  background-color: #ffffff;
  margin: 0 auto;
  display: block;
  max-width: max-content;
}
.btnGas:hover {
  color: rgb(255, 255, 255) !important;
  background-color: #eba133;
}
.badgeNuovo {
  position: absolute;
  z-index: 99;
  right: 42%;
  top: 58%;
  padding: 0.4em 0.4em !important;
  box-shadow: 0 3px 5px -1px rgba(0, 0, 0, 0.2),
    0 6px 10px 0 rgba(0, 0, 0, 0.55), 0 1px 18px 0 rgba(223, 78, 78, 0.83) !important;
  font-size: 90% !important;
}
.top5 {
  max-width: 95% !important;
}

@media screen and (max-width: 600px) {
  .jumbotron {
    display: block !important;
  }

  .titolo-display {
    font-size: 2rem !important;
  }
}
</style>

