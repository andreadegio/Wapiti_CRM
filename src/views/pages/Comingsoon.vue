<template>
  <CContainer class="d-flex align-items-center min-vh-100">
    <CRow class="w-100 justify-content-center">
      <CCol md="6">
        <div class="w-100 justify-content-center text-center pb-5">
        <div class="clearfix">
          <!-- <img src="img/abyway_logo.png"> -->
          <h1 class="display-3 mr-4 pb-5">Area non ancora disponibile</h1>

          <p class="text-muted"></p>
          <CButton
                to="dashboard"
                color="info"
                size="lg"
                variant="outline"                
              >
                < Indietro
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
