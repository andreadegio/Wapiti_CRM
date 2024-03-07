<template>
  <CContainer
    id="statistiche_portali"
    class="text-center d-flex min-vh-100 pt-5"
    style="
      background: rgb(255, 255, 255) url('img/statistiche.jpg') no-repeat scroll
        0% 0%;
    "
  >
    <CRow class="w-100 justify-content-center">
      <CCol col="12" sm="3">
        <CCardLink to="Statistiche/broker" target="_self">
          <CWidgetSimple class="bg-broker py-3">
            <span style="color: white">
              <i class="fas fa-car-alt fa-3x"></i
            ></span>
            <br />
            <p class="titolo_pulsante_stat">Statistiche</p>
            <p class="pulsante_stat" style="color: white">Assicurazioni</p>
          </CWidgetSimple>
        </CCardLink>
      </CCol>
      <CCol col="12" sm="3" v-if="idUtenteEnergy != -1">
        <CCardLink to="Statistiche/energy" target="_self">
          <CWidgetSimple class="bg-energy py-3">
            <span style="color: white">
              <i class="far fa-lightbulb fa-3x"></i
            ></span>
            <br />
            <p class="titolo_pulsante_stat">Statistiche</p>
            <p class="pulsante_stat" style="color: white">Energia</p>
          </CWidgetSimple>
        </CCardLink>
      </CCol>
    </CRow>
  </CContainer>
</template>
<script>
export default {
  name: "StatistichePortali",
  data: function () {
    return {
      idUtenteEnergy: localStorage.getItem("idUtenteEnergy"),
    };
  },
  beforeDestroy() {
    window.removeEventListener("resize", this.getWindowHeight);
    document.documentElement.style.overflow = "auto";
  },
};
</script>
<style scoped>
.bg-broker {
  background-color: #1f4b6b !important;
}
.bg-rami {
  background-color: #607d8b !important;
}
.bg-energy {
  background-color: green !important;
}
.portali-btn {
  -webkit-filter: grayscale(0%); /* Safari 6.0 - 9.0 */
  filter: grayscale(0%);
}
.pulsante_stat {
  color: white;
  font-weight: 800;
  text-shadow: 1px 1px midnightblue;
  font-size: 2rem;
  margin-bottom: 0 !important;
  
}
.titolo_pulsante_stat {
  color: white;
  text-shadow: 1px 1px midnightblue;
  font-size: 1.5rem;
  margin-bottom: 0 !important;
}

#statistiche_portali {
  background-size: cover !important;
  background-position: right !important;
  max-width: none !important;
}
</style>