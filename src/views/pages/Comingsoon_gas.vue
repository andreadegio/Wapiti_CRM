<template>
  <CContainer id="cover_gas" class="d-flex align-items-center min-vh-100" style="
      background: rgb(255, 255, 255) url('img/filigranaGas.jpg') no-repeat
        scroll 0% 0%;
    ">
    <CRow class="w-100 justify-content-center">
      <CCol md="6">
        <div class="w-100 justify-content-center text-center pb-5">
          <div class="clearfix">
            <!-- <img src="img/abyway_logo.png"> -->
            <h1 class="display-3 mr-4">Utente non abilitato</h1>
            <br />
            <h3>
              Per ulteriori informazioni e chiarimenti è possibile contattare<br />
              la direzione di ABY ENERGIA attraverso l’indirizzo di posta
              elettronica dedicato:<br />assistenza@abyservizi.it
            </h3>

            <p class="text-muted pt-3"></p>
            <CButton to="dashboard" color="primary" size="lg" variant="outline">
              <i class="fas fa-angle-left"></i> Indietro
            </CButton>
          </div>
        </div>
      </CCol>
    </CRow>
  </CContainer>
</template>

<script>
export default {
  name: "ComingSoon",
};
</script>
<style scoped>
#cover_gas {
  background-size: cover !important;
  background-position: right !important;
  max-width: none !important;
}
</style>
