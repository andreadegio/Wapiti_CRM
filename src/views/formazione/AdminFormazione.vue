<template>
  <div>
    <vue-editor v-model="content" :editor-toolbar="customToolbar"></vue-editor>

    <div class="pt-5 mt-5">
      <span style="background-color: black; color: white">
        {{ this.content }}
      </span>
    </div>
  </div>
</template>
<script>
import { VueEditor } from "vue2-editor";

export default {
  components: {
    VueEditor,
  },
  data() {
    return {
      content: "prova",
      customToolbar: [
        [{ header: [false, 1, 2, 3, 4, 5, 6] }],
        ["bold", "italic", "underline"],
        [{ color: [] }, { background: [] }],
        [
          { align: "" },
          { align: "center" },
          { align: "right" },
          { align: "justify" },
        ],
        [{ list: "ordered" }, { list: "bullet" }, { list: "check" }],
        [{ indent: "-1" }, { indent: "+1" }],
        ["link"],
      ],
    };
  },
};
</script>