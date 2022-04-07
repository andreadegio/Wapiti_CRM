<template>
  <CContainer class="text-center" style="background-color: white;">
    <p class="display-3 mb-5">
        Accessi alle piattaforme
      </p>
    <CRow style="border-top: 1px solid lightgray;">
      <CCol col="12" sm="2" >
        <h1>Totali</h1>
        <cite>dal 7/4/2022</cite>
      </CCol>
      <CCol col="12" sm="3">
        <CWidgetBrand
          color="broker"
          :rightHeader="accessi_totali.Broker_totale"
          rightFooter="Totali"
          :leftHeader="accessi_totali.Broker_unici"
          leftFooter="univoci"
        >
          <span class="py-3">
            <i class="fas fa-car-alt fa-3x"></i>
            <br />
            Broker
          </span>
        </CWidgetBrand>
      </CCol>
      <CCol col="12" sm="3">
        <CWidgetBrand
          color="rami"
          :rightHeader="accessi_totali.Rami_totale"
          rightFooter="Totali"
          :leftHeader="accessi_totali.Rami_unici"
          leftFooter="univoci"
        >
          <span class="py-3">
            <i class="fas fa-user-tie fa-3x"></i>
            <br />
            Professionisti
          </span>
        </CWidgetBrand>
      </CCol>
      <CCol col="12" sm="3">
        <CWidgetBrand
          color="energy"
          :rightHeader="accessi_totali.Energy_totale"
          rightFooter="Totali"
          :leftHeader="accessi_totali.Energy_unici"
          leftFooter="univoci"
        >
          <span class="py-3">
            <i class="far fa-lightbulb fa-3x"></i>
            <br />
            Gas & Luce
          </span>
        </CWidgetBrand>
      </CCol>
    </CRow>
    <CRow style="border-top: 1px solid lightgray; border-bottom: 1px solid lightgray">
      <CCol col="12" sm="2">
       <h1>Mese corrente</h1>
      </CCol>
      <CCol col="12" sm="3">
        <CWidgetBrand
          color="broker"
          :rightHeader="accessi_totali.Broker_totale_m"
          rightFooter="Totali"
          :leftHeader="accessi_totali.Broker_unici_m"
          leftFooter="univoci"
        >
          <span class="py-3">
            <i class="fas fa-car-alt fa-3x"></i>
            <br />
            Broker
          </span>
        </CWidgetBrand>
      </CCol>
      <CCol col="12" sm="3">
        <CWidgetBrand
          color="rami"
          :rightHeader="accessi_totali.Rami_totale_m"
          rightFooter="Totali"
          :leftHeader="accessi_totali.Rami_unici_m"
          leftFooter="univoci"
        >
          <span class="py-3">
            <i class="fas fa-user-tie fa-3x"></i>
            <br />
            Professionisti
          </span>
        </CWidgetBrand>
      </CCol>
      <CCol col="12" sm="3">
        <CWidgetBrand
          color="energy"
          :rightHeader="accessi_totali.Energy_totale_m"
          rightFooter="Totali"
          :leftHeader="accessi_totali.Energy_unici_m"
          leftFooter="univoci"
        >
          <span class="py-3">
            <i class="far fa-lightbulb fa-3x"></i>
            <br />
            Gas & Luce
          </span>
        </CWidgetBrand>
      </CCol>
    </CRow>
    <CRow>
      <CCol col="12" sm="2">
        <h1>Oggi</h1> 
      </CCol>
      <CCol col="12" sm="3">
        <CWidgetBrand
          color="broker"
          :rightHeader="accessi_totali.Broker_totale_d"
          rightFooter="Totali"
          :leftHeader="accessi_totali.Broker_unici_d"
          leftFooter="univoci"
        >
          <span class="py-3">
            <i class="fas fa-car-alt fa-3x"></i>
            <br />
            Broker
          </span>
        </CWidgetBrand>
      </CCol>
      <CCol col="12" sm="3">
        <CWidgetBrand
          color="rami"
          :rightHeader="accessi_totali.Rami_totale_d"
          rightFooter="Totali"
          :leftHeader="accessi_totali.Rami_unici_d"
          leftFooter="univoci"
        >
          <span class="py-3">
            <i class="fas fa-user-tie fa-3x"></i>
            <br />
            Professionisti
          </span>
        </CWidgetBrand>
      </CCol>
      <CCol col="12" sm="3">
        <CWidgetBrand
          color="energy"
          :rightHeader="accessi_totali.Energy_totale_d"
          rightFooter="Totali"
          :leftHeader="accessi_totali.Energy_unici_d"
          leftFooter="univoci"
        >
          <span class="py-3">
            <i class="far fa-lightbulb fa-3x"></i>
            <br />
            Gas & Luce
          </span>
        </CWidgetBrand>
      </CCol>
    </CRow>
    <!-- <CRow>
      <vc-date-picker
        v-model="range"
        color="blue"
        is-range
        :attributes="attrs"
        :max-date="new Date()"
      />
    </CRow>
    <CRow v-if="range.start && range.end">
      Periodo selezionato:<br />dal {{ range.start.toLocaleDateString() }} al
      {{ range.end.toLocaleDateString() }}
    </CRow> -->
  </CContainer>
</template>
<script>
import axios from "axios";
export default {
  data() {
    return {
      accessi_totali:[],
      attrs: [
        {
          key: "today",
          highlight: "red",
          dates: new Date(),
        },
      ],
      range: {
        start: "",
        end: "",
      },
      contBroker: "400",
      contRami: "20",
      contEnergy: "100",
    };
  },
  mounted(){
    this.get_accessi_totali();
  },
  methods:{
     async get_accessi_totali() {
      // Chiamata per recuperare il totale degli accessi alle piattaforme
      try {
        await axios
          .post(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.ep_api.get_accessi_totali
          )
          .then((response) => {
            this.accessi_totali= response.data;
           console.log(this.accessi_totali.Broker_totale);
          });
      } catch (error) {
        console.log("errore: " + error);
      }
    },
  }
};
</script>
<style>
.bg-broker {
  background-color: #1f4b6b !important;
}
.bg-rami {
  background-color: #607d8b !important;
}
.bg-energy {
  background-color: green !important;
}
</style>