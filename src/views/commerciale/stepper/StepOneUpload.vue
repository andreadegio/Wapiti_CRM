<template>
  <div style="text-align: left; display: flex">
    <div>
      <div class="field">
        <div class="row cover_box mb-3">
          <span class="mb-2"
            ><strong>Seleziona l'area di competenza:</strong></span
          >
          <div class="control">
            <treeselect
              :multiple="false"
              :always-open="false"
              :options="$store.state.aree"
              :max-height="300"
              placeholder="Seleziona l'area"
              v-model="uploadObject.area_post"
            />
          </div>
        </div>
        <div class="cover_box mb-3">
          <span><strong>Titolo:</strong></span>
          <div class="control">
            <CInput
              type="text"
              placeholder="Assegna un titolo a questo caricamento Es. Set Informativo ABC"
              v-model="uploadObject.titolo"
              @change="check_next"
              maxlength="100"
            />
          </div>
        </div>
        <!-- <label class="label">Dai un titolo a questo caricamento!</label>
        <div class="control">
          <CInput
            type="text"
            placeholder="Assegna un titolo a questo caricamento Es. Set Informativo ABC"
            v-model="uploadObject.titolo"
            @change="check_next"

          />
        </div> -->
        <p v-if="errore_titolo" class="help is-danger">
          Inserire un titolo valido
        </p>
      </div>
      <!-- <div class="field">
            <label class="label">Email</label>
            <div class="control">
                <input :class="['input', ($v.form.demoEmail.$error) ? 'is-danger' : '']"  type="text" placeholder="Email input" v-model="form.demoEmail">
            </div>
            <p v-if="$v.form.demoEmail.$error" class="help is-danger">This email is invalid</p>
        </div> -->

      <div class="cover_box mb-3">
        <div class="field">
          <label class="label"
            ><strong>Chi può accedere a questi contenuti?</strong></label
          >
          <div class="control">
            <treeselect
              v-model="uploadObject.permessi"
              :multiple="true"
              :options="options"
              :max-height="300"
              @input="check_next"
              placeholder="Seleziona per tipologia di rapporto"
            />
          </div>
        </div>
      </div>
      <div class="field">
        <div class="cover_box mb-3">
          <label class="label"><strong>Contenuto:</strong></label>
          <div class="control">
            <CTextarea
              placeholder="Descrivi il contenuto di ciò che andrai a caricare"
              v-model="uploadObject.descrizione"
              @change="check_next"
            />
          </div>
        </div>
        <p v-if="errore_descrizione" class="help is-danger">
          Inserire una descrizione
        </p>
      </div>
    </div>
  </div>
</template>

<script>
// import { validationMixin } from "vuelidate";
// import { required } from "vuelidate/lib/validators";
// import the component
import Treeselect from "@riophae/vue-treeselect";
// import the styles
import "@riophae/vue-treeselect/dist/vue-treeselect.css";

export default {
  name: "StepOne",
  props: {
    clickedNext: Boolean,
    currentStep: Object,
    uploadObject: Object,
    coloreTasti: String,
  },
  // mixins: [validationMixin],
  components: { Treeselect },
  data() {
    return {
      errore_titolo: false,
      errore_descrizione: false,
      errore_permessi: false,
      area_post: null,
      //options della select delle tipologie di rapporto
      options: [
        {
          id: "999",
          label: "TUTTI",
          isDefaultExpanded: true,
          children: JSON.parse(localStorage.getItem("tipologie")),
        },
      ],
    };
  },
  // validations: {
  //   form: {
  //     titolo: {
  //       required,
  //     },
  //     descrizione: {
  //       required,
  //     },

  //   },
  // },
  // watch: {
  //   $v: {
  //     handler: function (val) {
  //       if (!val.$invalid) {

  //         this.$emit("can-continue", { value: true });
  //       } else {
  //         this.$emit("can-continue", { value: false });
  //         setTimeout(() => {
  //           this.$emit("change-next", { nextBtnValue: false });
  //         }, 3000);
  //       }
  //     },
  //     deep: true,
  //   },
  watch: {
    // eslint-disable-next-line no-unused-vars
    clickedNext(val) {
      this.uploadObject.titolo == "" ? this.errore_titolo : !this.errore_titolo;
      this.uploadObject.descrizione == ""
        ? this.errore_descrizione
        : !this.errore_descrizione;

      //console.log(val);
      // if (val === true) {
      //   // this.$v.form.$touch();
      // }
    },
  },
  methods: {
    check_next() {
      // console.log("titolo" + this.uploadObject.titolo);
      // console.log(this.uploadObject.permessi);
      // console.log("desc" + this.uploadObject.descrizione);
      // console.log("permessi" + this.uploadObject.permessi.length);
      if (
        this.uploadObject.titolo != "" &&
        this.uploadObject.descrizione != "" &&
        this.uploadObject.permessi.length > 0
      ) {
        this.$emit("can-continue", { value: true });
      } else {
        this.$emit("can-continue", { value: false });
      }
      this.errore_titolo = false;
    },
  },
  mounted() {
    if (this.uploadObject.titolo != "") {
      this.$emit("can-continue", { value: true });
    } else {
      this.$emit("can-continue", { value: false });
    }
  },
};
</script>