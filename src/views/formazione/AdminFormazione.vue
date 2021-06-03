<template>
  <div>
    <vue-editor v-model="content"></vue-editor>

    <div class="pt-5 mt-5">
        <span style="background-color: black; color: white">
            {{this.content}}
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
    };
  },
};
</script>