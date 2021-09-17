<template>
  <div id="aree" class="pt-4 px-5">
    <CJumbotron class="px-0 py-2 latest">
      <CCardGroup class="latest p-3">
        <CCard
          class="mx-2 card_materiale card_post col-md-3"
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
            <CCardHeader class="text-uppercase"
              ><strong>
                <u>{{ item.settore }}</u>
              </strong></CCardHeader
            >
            <CCardImg
              :src="item.copertina"
              style="min-height: 200px"
              alt="- IMPOSSIBILE CARICARE -"
            >
            </CCardImg>
            <CCardBody class="pb-2"
              ><h2>{{ item.titolo }}</h2>
              <cite> {{ item.data_ins | formatDate }}</cite>
              <div
                v-html="$options.filters.truncate(item.contenuto, 50, ' [...]')"
              ></div>
            </CCardBody>
            <CCardFooter><strong>Leggi di più...</strong> </CCardFooter>
          </CLink>
        </CCard>
      </CCardGroup>
    </CJumbotron>
    <CJumbotron style="" class="blue_logo">
      <CCol
        md="8"
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
      <CCol md="4" class="py-5 justify-content-center">
        <h1
          class="display-3 text-center"
          style="font-weight: initial !important"
        >
          Assicurazioni
        </h1>

        <CButton
          class="btnAssicurazioni mt-3"
          size="lg"
          to="Commerciale/Assicurazioni"
          >Scopri di più...</CButton
        >
        <div class="mt-3" v-if="admin">
          <CLink
            to="AdminCommerciale/Assicurazioni"
            class=""
            style="color: white !important"
            ><CIcon name="cil-settings" /><strong> Gestione</strong>
          </CLink>
        </div>
      </CCol>
    </CJumbotron>
    <CJumbotron class="Gas">
      <CCol md="4" class="py-5 text-right">
        <h1
          class="display-3 text-center"
          style="font-weight: initial !important"
        >
          Gas & Luce
        </h1>
        <!-- <p class="lead">
          Materiale e comunicazioni commerciali per il mondo Energy
        </p> -->

        <CButton class="mt-3 btnGas" size="lg" to="Commerciale/Energy"
          >Scopri di più...</CButton
        >
        <div class="mt-3" v-if="admin">
          <CLink
            to="AdminCommerciale/Energy"
            class=""
            style="color: white !important"
            ><CIcon name="cil-settings" /><strong> Gestione</strong>
          </CLink>
        </div>
      </CCol>
      <CCol
        md="8"
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
import axios from "axios";

export default {
  data() {
    return {
      admin: JSON.parse(localStorage.getItem("chisono_data")).Is_Sede,
      post: [],
      bgColor: "#1e2f56",
    };
  },
  mounted() {
    this.get_lista_post();
  },
  methods: {
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
            this.$custom_json.api_url + this.$custom_json.ep_api.lista_post,
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

  border-top: 6px solid var(--bgColor);
}

.latest a:hover {
  text-decoration: none;
}
.btnAssicurazioni {
  color: #1e2f56 !important;
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
  display: flex;
  background: linear-gradient(0deg, #1e2f56, #798ebd) !important;
  box-shadow: 0 3px 5px -1px rgba(0, 0, 0, 0.2),
    0 6px 10px 0 rgba(0, 0, 0, 0.14), 0 1px 18px 0 rgba(0, 0, 0, 0.12) !important;
  color: white;
  padding: 3px;
}
.jumbotron.latest {
  margin-bottom: 1rem !important;
  display: flex;
  background: linear-gradient(0deg, #595858, #cecece) !important;
  box-shadow: 0 3px 5px -1px rgba(0, 0, 0, 0.2),
    0 6px 10px 0 rgba(0, 0, 0, 0.14), 0 1px 18px 0 rgba(0, 0, 0, 0.12) !important;
  color: white;
  padding: 3px;
}
.jumbotron.Gas {
  display: flex;
  color: white;
  padding: 3px;

  background: rgba(0, 0, 0, 0)
    linear-gradient(0deg, rgb(14, 119, 49), rgb(81, 213, 126)) repeat scroll 0%
    0% !important;
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
</style>

