<template>
  <CContainer id="cover_gas" class="d-flex align-items-center min-vh-100" style="
        background: rgb(255, 255, 255) url('img/filigranaGas.jpg') no-repeat scroll
          0% 0%;
      ">
    <CRow class="w-100 justify-content-center">
      <CCol md="6">
        <div class="w-100 justify-content-center text-center pb-5">
        <div class="clearfix">
          <!-- <img src="img/abyway_logo.png"> -->
          <h1 class="display-3 mr-4 pb-5">Area non ancora disponibile</h1>

          <p class="text-muted"></p>
          <CButton
                to="dashboard"
                color="primary"
                size="lg"
                variant="outline"                
              >
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
  name: 'ComingSoon'
}
</script>
<style scoped>
#cover_gas{
  background-size: cover !important;
  background-position: right !important;
  max-width: none !important;
}
</style>