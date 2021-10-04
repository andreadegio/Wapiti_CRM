<template>
  <div class="d-flex align-items-center min-vh-100">
    <CContainer fluid>
      <CRow class="justify-content-center">
        <CCol md="6">
          <CCard class="mx-4 mb-0">
            <CCardBody class="p-4">
              
                <h1>{{user.Nominativo}}</h1>
                <p class="text-muted"></p>
                <p>Unità Operativa: {{user.UnitaOperativa}} </p>
                <p>Intermediario: {{user.Intermediario}} </p>
                <p>Abilitazione Auto:  {{user.Abilitato_Auto}} </p>
                <p>Abilitazione Rami: {{user.Abilitato_Rami}} </p>
                <CButton
                to="dashboard"
                color="info"
                size="lg"
                variant="outline"                
              >
                <i class="fas fa-angle-left"></i> Indietro
              </CButton>

              
            </CCardBody>
            
          </CCard>
        </CCol>
      </CRow>
    </CContainer>
  </div>
</template>

<script>
export default {
  name: "ProfiloUtente",

  data() {
    return {
      user: JSON.parse(localStorage.getItem("chisono_data")),
    };
  },
};
</script>
