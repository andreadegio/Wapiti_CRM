<template>
  <CModal
    color="dark"
    size="xl"
    :closeOnBackdrop="false"
    :centered="true"
    :show.sync="showDoc"
  >
    <template #header>
      <span class="h5 text-uppercase py-2">
        <strong>Anteprima</strong>
      </span>

      <CButton class="close pt-3" @click="$emit('aggiorna_modale', false)">
        <span aria-hidden="true">&times;</span>
      </CButton>
    </template>
    <template class="justify-content-center">
      <CImg v-show="ext == 'JPG' || ext == 'JPEG' || ext == 'PNG' || ext == 'BMP' || ext == 'GIF'" 
       :src="file" style="max-height: 40rem;" class="justify-content-center"></CImg>
      <VueDocPreview
        v-show="ext == 'DOC' || ext == 'DOCX' || ext == 'XLS' || ext == 'XLSX' || ext == 'PPTX' || ext == 'PPT'" 
        :value="file"
        type="office"
      />
    </template>
    <template #footer>
      <cite> Estensione: {{ ext }}</cite>
    </template>
  </CModal>
</template>
 
<script>
import VueDocPreview from "vue-doc-preview";
export default {
  components: {
    VueDocPreview,
  },
  props: ["showDoc", "file", "ext"],
  watch: {
    showDoc: function (value) {
      this.$emit("aggiorna_modale", value);
      //    console.log("nuovo valore di showdoc " , value);
    },
  },
  data() {
    return {};
  },
};
</script>
<style scoped>
#VueDocPreviewRoot {
  height: 40rem !important;
}
</style>