<template>
  <CModal
    color="dark"
    centered
    style="z-index: 30"
    size="lg"
    :show.sync="$parent.viewFile"
  >
    <template #header>
      <strong style="text-transform: uppercase">Anteprima </strong>
      <CButton class="close" @click="$parent.viewFile = false">
        <span aria-hidden="true">&times;</span>
      </CButton>
    </template>
    <template>
      <div class="d-flex align-items-center">
        <CContainer fluid>
          <CRow class="justify-content-center">
            <CCol md="12">
              <div
                v-if="$parent.file_name !== ''"
                style="background-color: #ebedef"
                :key="$parent.file_name"
              >
                <div id="viewer"></div>
                <object
                  width="100%"
                  height="600"
                  :data="$parent.file_name"
                  type="application/pdf"
                  :key="$parent.file_name"
                ></object>
              </div>
              <div
                class="pt-5 text-center"
                style="
                  background-color: #ebedef !important;
                  height: 600px;
                  width: 95%;
                "
                v-if="$parent.file_name == ''"
              >
                <div
                  v-if="$parent.timer != 0 && $parent.select == false"
                  style="background-color: #fff"
                >
                  <img src="img/search-folder.gif" style="width: 50px" /><br />
                  <span class="h4">... Recupero documento in corso ...</span>
                </div>
                <div v-show="$parent.select">
                  <span class="h4">Seleziona un documento</span>
                </div>
              </div>
            </CCol>
          </CRow>
        </CContainer>
      </div>
    </template>
    <template #footer-wrapper>
      <span></span>
    </template>
  </CModal>
</template>
<script>
export default {
  name: "VisualizzaDocumento",
  data() {
    return {};
  },
};
</script>
<style scoped>
</style>