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
        <strong>Anteprima del File</strong>
      </span>

      <CButton class="close pt-3" @click="$emit('aggiorna_modale', false)">
        <span aria-hidden="true">&times;</span>
      </CButton>
    </template>
    <template class="justify-content-center" style="display: flex">
      <div v-if="ext == 'MP4'" style="margin: auto; display: grid">
        <video controls width="100%">
          <source :src="encodeURI(file)" type="video/mp4" />

          Spiacente il tuo Browser non supporta la riproduzione video.
        </video>
        <div class="text-center">
          <a :href="encodeURI(file)" :download="nome_file" target="_blank"
            >Download</a
          >
        </div>
      </div>
      <div
        v-show="
          ext == 'JPG' ||
          ext == 'JPEG' ||
          ext == 'BMP' ||
          ext == 'GIF' ||
          ext == 'PNG'
        "
        class="justify-content-center"
        style="margin: auto; display: flex"
      >
        <CImg
          :src="file"
          style="max-height: 40rem"
          class="justify-content-center"
        ></CImg>
      </div>
      <div
        v-if="
          ext == 'DOC' ||
          ext == 'DOCX' ||
          ext == 'XLS' ||
          ext == 'XLSX' ||
          ext == 'PPTX' ||
          ext == 'PPT'
        "
      >
        <VueDocPreview :value="file" type="office" />
      </div>
      <div v-if="ext == 'PDF'">
        <object
          width="100%"
          style="height: 40rem"
          :data="file"
          type="application/pdf"
        ></object>
      </div>
    </template>
    <template #footer>
      <cite> File: {{ nome_file }}</cite>
    </template>
  </CModal>
</template>
 
<script>
import VueDocPreview from "vue-doc-preview";

export default {
  components: {
    VueDocPreview,
  },
  props: ["showDoc", "file", "ext", "nome_file"],
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