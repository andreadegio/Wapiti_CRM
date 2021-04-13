<template>
  <div>
    <FormulateForm
      name="add_news"
      class="add-news-form"
      v-model="formValues"
      :schema="schema_news"
      @submit="invio_news()"
    >

       
<div style="display: flex;">
     
      <FormulateInput
      id="reset-btn"
        type="button"
        label="Reset"
        data-ghost
        @click= "reset()"
      />
      <FormulateInput
        type="submit"
        label="Salva"
        name= "salva"
      />
</div>

    
      <pre class="code" v-text="formValues" />


    </FormulateForm>
  </div>
</template>
<script>
export default {
  data() {
    return {
      formValues: {},
      schema_news: [
        {
          type: "image",
          name: "immagine",
          label: "Seleziona Immagine di copertina",
          validation: "^required|mime:image/jpeg,image/png,image/gif",
          "validation-messages": {
            required: "Immagine obbligatoria",
            mime: "Formato errato si accetta solo jpg, png o gif ",
          },
          help: "Formati accettati png, jpg o gif",
        },
        {
          type: "text",
          name: "titolo",
          label: "Titolo della News",
          validation: "required",
          "validation-messages": {
            required: "Titolo obbligatorio",
          },
          placeholder: "Inserirsci il titolo",
        },
        {
          type: "textarea",
          name: "contenuto",
          label: "Contenuto della News",
          validation: "required",
          "validation-messages": {
            required: "Contenuto obbligatorio",
          },
          placeholder: "Contenuto della news",
        },
      ],
    };
  },
  methods: {
    reset() {
      this.$formulate.reset("add_news");
    },
    invio_news() {
      alert(this.formValues.immagine);
      console.log('oggetto',this.formValues);

    },
    
  },
};
</script>
<style scoped>
.add-news-form {
  padding: 2em;
  background-color: white;
  max-width: 800px;
  box-sizing: border-box;
}
.form-title {
  margin-top: 0;
}
.add-news-form::v-deep .formulate-input .formulate-input-element {
  max-width: none;
}
@media (min-width: 420px) {
  .double-wide {
    display: flex;
  }
  .double-wide .formulate-input {
    flex-grow: 1;
    width: calc(50% - 0.5em);
  }
  .double-wide .formulate-input:first-child {
    margin-right: 0.5em;
  }
  .double-wide .formulate-input:last-child {
    margin-left: 0.5em;
  }
}
</style>