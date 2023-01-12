<template>
  <div
    id="app"
    style="margin-top: 20px; padding-left: 20px; background-color: white"
  >
    <CModal
      color="dark"
      centered
      :show.sync="help"
      style="z-index: 30"
      size="lg"
    >
      <template #header style="background-color: #1f4b6b !important">
        <strong style="text-transform: uppercase">Istruzioni</strong>
        <CButton class="close" @click="help = false">
          <!-- <button type="button" class="close" aria-label="Close"> -->
          <span aria-hidden="true">&times;</span>
        </CButton>
      </template>
      <template>
        <div class="d-flex align-items-center">
          <CContainer fluid>
            <CRow class="justify-content-center">
              <CCol md="10">
                <div>
                  <span class="py-5">
                    SEGUI QUESTE ISTRUZIONI PER CREARE LA FIRMA PER IL TUO
                    SOFTWARE DI POSTA ELETTRONICA:</span
                  ><br /><br />
                  <ol>
                    <li>Seleziona l'<b>Azienda</b></li>
                    <li>Inserisci il <b>Nome</b> e <b>Cognome</b></li>
                    <li>
                      Per mostrare il <b>Ruolo</b> spunta la casella "Mostra
                      Ruolo" e compila la "Riga 1" se necessiti di un'altra riga
                      compila anche "Riga 2"
                    </li>
                    <li>
                      Per cambiare il <b>Numero di telefono</b> spunta la
                      casella "Cambia numero fisso" altrimenti di default
                      assegna il numero +39 02 86882871
                    </li>
                    <li>
                      Per mostrare l'<b>Interno</b> del centralino, spunta la
                      casella "Mostra Interno" e compila il campo
                    </li>
                    <li>
                      Per mostrare il <b>Cellulare</b> spunta la casella "Mostra
                      Cellulare" e compila il campo
                    </li>
                    <li>
                      Per mostrare la <b>Mail</b> spunta la casella "Mostra
                      Mail" ed inserisci la mail
                    </li>
                    <li>
                      Per cambiare l'<b>Indirizzo</b> spunta la casella "Cambia
                      Indirizzo" e compila il campo, altrimenti di default
                      assegna "Via Monte Napoleone 8, 20121 Milano (MI)"
                    </li>
                  </ol>
                  <div>
                    Al termine puoi vedere l'<b>Anteprima</b> di come si
                    presenterà la tua firma, se tutto ok premi sul pulsante
                    <b>COPIA LA FIRMA</b> e poi apri il tuo software di posta ed
                    incolla nell'apposito spazio
                  </div>
                </div>
              </CCol>
            </CRow>
          </CContainer>
        </div>
      </template>

      <template #footer>
        <CButton @click="help = false" color="dark" size="sm" variant="outline">
          Chiudi
        </CButton>
      </template>
    </CModal>
    <span class="text-center"><b>GENERATORE FIRME EMAIL</b> &nbsp;</span>
    <CButton
      style="color: white"
      shape="pill"
      color="primary"
      @click="help = true"
    >
      <i class="fas fa-info"></i>
    </CButton>
    <Configuratore
      class="configuratore"
      
      :recapiti="recapiti"
      @switchAzienda="switchAzienda"
      
      @changeRecapiti="changeRecapiti"
    />
    <div style="text-align: center">
      <v-btn
        v-if="company != ''"
        class="mx-2"
        color="#1f4b6b"
        style="color: white"
        @click="copytohtml(company)"
      >
        Copia in HTML
      </v-btn>
      &nbsp;
      <v-btn
        v-if="company != ''"
        class="mx-2"
        color="#1f4b6b"
        style="color: white"
        @click="copy4outlook(company)"
      >
        Copia per Outlook
      </v-btn>
    </div>
    <br />

    <span v-if="company != ''"><b>ANTEPRIMA DELLA FIRMA CREATA</b></span>
    <SignatureAby
      class="preview"
      v-show="company == 'ABY'"
      
      :recapiti="recapiti"
    />
    <SignatureNavert
      class="preview"
      v-show="company == 'NAV'"

      :recapiti="recapiti"
    />
  </div>
</template>

<script>
import SignatureAby from "./components/SignAby.vue";
import SignatureNavert from "./components/SignNavert.vue";
import Configuratore from "./components/Configuratore.vue";

export default {
  name: "AbySign",
  components: {
    SignatureAby,
    SignatureNavert,
    Configuratore,
  },
  data() {
    return {
      help: true,
      company: "",

      recapiti: {
        nome: "",
        ruolo: "",
        ruolo2: "",
        mostra_ruolo: false,
        sel_telefono: false,
        telefono: "",
        sel_interno: false,
        interno: "",
        sel_cell: false,
        cellulare: "",
        sel_mail: true,
        mail: "mail",
        sel_indirizzo: false,
        indirizzo: "",
      },
    };
  },
  methods: {
    switchAzienda(azienda) {
      this.company = azienda;
      this.recapiti = {
        nome: "",
        ruolo: "",
        ruolo2: "",
        mostra_ruolo: false,
        sel_telefono: false,
        telefono: "",
        sel_interno: false,
        interno: "",
        sel_cell: false,
        cellulare: "",
        sel_mail: true,
        mail: "mail",
        sel_indirizzo: false,
        indirizzo: "",
      };
    },
    // changeNome(utente) {
    //   this.nome = utente;
    // },
    // changeRuolo(newRuolo) {
    //   this.ruolo = newRuolo;
    // },
    // changeRuolo2(newRuolo2) {
    //   this.ruolo2 = newRuolo2;
    // },
    // changeMostraRuolo(newMostraRuolo) {
    //   this.mostra_ruolo = newMostraRuolo;
    // },
    changeRecapiti(newRecapiti) {
      this.recapiti = newRecapiti;
    },
    copytohtml(tipo) {
      var t = document.getElementById("firma_" + tipo).innerHTML;
      navigator.clipboard.writeText(t);
      alert(
        "Firma copiata negli appunti, adesso la puoi incollare all'interno del tuo programma di posta"
      );
    },
    copy4outlook(tipo) {
      var elem = document.getElementById("firma_" + tipo);

      var range = document.createRange();
      range.selectNode(elem);
      window.getSelection().removeAllRanges();
      window.getSelection().addRange(range);
      document.execCommand("Copy");
      alert(
        "Firma copiata negli appunti, adesso la puoi incollare all'interno di Outlook"
      );
      window.getSelection().removeAllRanges();
    },
  },
};
</script>

<style>
#app {
  font-family: "Trebuchet MS", "Lucida Sans Unicode", "Lucida Grande",
    "Lucida Sans", Arial, sans-serif;
}
.configuratore {
  border: 1px dashed gray;
  padding: 20px;
  margin: 10px;
}
.preview {
  border: 1px dashed gray;
  padding: 20px;
  margin: 10px;
}
</style>
