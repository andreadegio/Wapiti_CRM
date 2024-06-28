<template>
  <div v-if="recapiti != []">
    <CModal color="dark" centered :show.sync="modale_contatto" style="z-index: 30" size="lg">
      <template #header style="background-color: #1f4b6b !important">
        <strong class="h4" style="text-transform: uppercase" v-if="dati_modale.descrizione">Recapiti per {{
    dati_modale.descrizione[0] }}</strong>
        <CButton class="close" @click="modale_contatto = false">
          <span aria-hidden="true">&times;</span>
        </CButton>
      </template>
      <template>
        <div class="justify-content-center align-items-center">
          <CContainer fluid>
            <CRow class="justify-content-center">
              <CCol md="11" class="p-0">
                <CCard style="border: 0px">
                  <CCardBody v-if="dati_modale.descrizione">
                    <div class="py-2 text-center titolo_recapito" v-if="dati_modale.descrizione">
                      {{ dati_modale.descrizione[0] }}<br /> <small v-if="dati_modale.descrizione.length > 1">
                        ({{ dati_modale.descrizione[1] }} </small>
                    </div>
                    <p class="text-muted"></p>
                    <div class="riga_contatto align-middle" style="border-top: 1px solid rgb(249, 223, 195)">
                      <div class="icona_contatto_modale mr-3 align-middle">
                        <i class="fas fa-phone fa-fw"></i>
                      </div>
                      <div class="recapito_dettaglio align-middle">
                        <div v-show="dati_modale.telefono && !invio">
                          Chiamaci al numero:
                          <p>
                            <b>{{ dati_modale.telefono }}</b>
                          </p>
                        </div>
                        <div v-show="invio">
                          Attendere invio richiesta in corso...
                          <img src="img/message.gif" style="width: 5rem" />
                        </div>
                        <div v-if="dati_modale.form_contatto && !invio">
                          <p class="mb-0" v-if="dati_modale.telefono">
                            Oppure lascia il tuo numero e ti richiameremo noi
                          </p>
                          <p v-else>
                            Lasciaci il tuo numero e ti richiameremo noi
                          </p>

                          <div class="form-row py-2">
                            <div class="form-group col-md-6 m-0 py-0">
                              <input type="text" pattern="[0-9]+" class="form-control" v-model="inputTelefono"
                                id="inputTelefono" placeholder="Telefono"
                                oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" />
                            </div>
                            <CButton @click="
    invia_contatto(
      inputTelefono,
      dati_modale.mailForm,
      dati_modale.descrizione[0]
    )
    " style="color: white" color="primary" class="ml-2"><i class="fas fa-share"></i> Invia
                              Richiesta</CButton>
                          </div>
                        </div>
                        <div class="text-muted" style="font-size: 0.9rem" v-show="dati_modale.orariTelefonoMattina">
                          (orario {{ dati_modale.orariTelefonoMattina }} /
                          {{ dati_modale.orariTelefonoPomeriggio }})
                        </div>
                      </div>
                    </div>
                    <div class="riga_contatto align-middle py-4">
                      <div class="icona_contatto_modale mr-3 align-middle">
                        <i class="far fa-envelope fa-fw"></i>
                      </div>
                      <div class="recapito_dettaglio d-inline-block align-middle">
                        Mandaci una mail
                        <p v-for="mail in dati_modale.mail" :key="mail" class="p-0 m-0">
                          <a style="font-size: 1.5rem" :href="'mailto:' + mail">
                            <b>{{ mail }}</b></a>
                        </p>

                        <div class="text-muted small_text"></div>
                      </div>
                    </div>
                    <div v-show="dati_modale.telegram" class="riga_contatto flex-column align-middle">
                      <div class="icona_contatto_modale mr-3 align-middle">
                        <i class="fab fa-telegram-plane"></i>
                      </div>
                      <div class="recapito_dettaglio d-inline-block align-middle">
                        Scrivici su Telegram
                        <p class="mb-0"><b>{{ dati_modale.telegram }}</b></p>
                        <p class="text-muted" style="font-size: 0.9rem" v-show="dati_modale.orariTelegramMattina">
                          (orario {{ dati_modale.orariTelegramMattina }} /
                          {{ dati_modale.orariTelegramPomeriggio }})
                        </p>
                      </div>
                    </div>

                    <div v-show="dati_modale.has_ticket" class="riga_contatto flex-column align-middle">
                      <div class="icona_contatto_modale mr-3 align-middle">
                        <i class="far fa-question-circle"></i>
                      </div>
                      <div class="recapito_dettaglio d-inline-block align-middle">
                        <p class="p-0 m-0">
                          <span>Apri un ticket </span>
                          <a style="font-size: 1.5rem" :href="dati_modale.ticket_link" target="_blank">
                            <b>cliccando qui</b>
                          </a>
                        </p>
                      </div>
                    </div>

                  </CCardBody>
                </CCard>
              </CCol>
            </CRow>
          </CContainer>
        </div>
        <CButton @click="modale_contatto = false" color="dark" size="sm" variant="outline"
          style="margin-left: auto; margin-right: auto; display: flex">
          Chiudi
        </CButton>
      </template>

      <template #footer-wrapper>
        <p></p>
      </template>
    </CModal>
    <CCard class="h-100">
      <CCardHeader class="main_title d-flex justify-content-between">
        <strong class="h3 titolo_gradient">RECAPITI OPERATIVI</strong>
        <div class="card-header-actions"></div>
      </CCardHeader>
      <CCardBody class="manager news_card py-0">
        <CListGroup class="contatto">
          <CListGroupItem v-for="(contatto, index) in recapiti" :key="index" v-show="contatto.Area.RecapitoOperativo"
            class="flex-column align-items-start grow">
            <div class="d-flex w-100 py-2" style="text-transform: uppercase" @click="show_contatto(index)">
              <div v-show="contatto.Area.FontAweSomeIcon" class="icona_contatto mr-3"
                v-html="contatto.Area.FontAweSomeIcon"></div>
              <div class="recapito_name">
                <strong>{{ contatto.Area.DescrizioneArea }}</strong>
                <br />
                <div class="small_text">
                  (Clicca per visualizzare le modalità di contatto)
                </div>
              </div>
              <div class="right_arrow">
                <i class="fas fa-chevron-right"></i>
              </div>
            </div>
          </CListGroupItem>
        </CListGroup>
      </CCardBody>
    </CCard>
  </div>
</template>
<script>
import axios from "axios";
export default {
  name: "ContattiAby",
  props: ["recapitiParent"],
  watch: {
    recapitiParent: function (newVal) {
      // console.log(JSON.stringify(newVal));
      // console.log("parametro nel watch" + newVal);
      this.recapiti = newVal;
    },
  },
  data() {
    return {
      chisono: JSON.parse(localStorage.getItem("chisono_data")),
      modale_contatto: false,
      dati_modale: [],
      inputTelefono: "",
      recapiti: [],
      user: [],
      invio: false,
    };
  },
  mounted() {
    if (localStorage.getItem("RecapitiAby")) {
      // console.log("recupero dallo storage");
      this.recapiti = JSON.parse(localStorage.getItem("RecapitiAby"));
    } else {
      // console.log("recupero dal parent");
      this.recapiti = this.recapitiParent;
    }
  },
  methods: {
    invia_contatto(telefono, mailReparto, settore) {
      // console.log(telefono);
      if (telefono) {
        this.invio = true;
        // chiamo il servizio per inviare la mail
        this.user = JSON.parse(localStorage.getItem("chisono_data"));
        // console.log("Utente:" + this.user.Nominativo);
        // console.log("Ufficio" + this.user.UnitaOperativa);
        // console.log("Telefono" + telefono);
        // console.log("MailReparto" + mailReparto);

        let params = {
          Utente: this.user.Nominativo,
          Ufficio: this.user.UnitaOperativa,
          Telefono: telefono,
          MailReparto: mailReparto,
          Settore: settore,
        };
        try {
          axios
            .post(
              this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.ep_api.richiesta_contatto,
              { params }
            )
            .then((response) => {
              // console.log(response.data);
              this.invio = false;
              this.$alert(
                "Sarai ricontattato quanto prima",
                "Richiesta inviata correttamente",
                "success"
              ).then(
                // eslint-disable-next-line no-unused-vars
                (result) => {
                  this.modale_contatto = false;
                }
              );
            });
        } catch (error) {
          console.log(error);
        }
        return;
      } else {
        this.$alert(
          "Verifica di aver inserito il numero corretto",
          "Numero telefonico errato",
          "warning"
        );
        return;
      }
    },
    show_contatto(index) {
      this.modale_contatto = true;
      this.inputTelefono = "";
      let Mail = this.recapiti[index].Area.Email.split(";");
      // console.log(Mail);
      this.dati_modale = {
        descrizione: this.recapiti[index].Area.DescrizioneArea.split("("),
        mail: Mail,
        telefono: this.recapiti[index].Area.Telefono.NrTelefono,
        orariTelefonoMattina: this.recapiti[index].Area.Telefono.OrariMattina,
        orariTelefonoPomeriggio:
          this.recapiti[index].Area.Telefono.OrariPomeriggio,
        telegram: this.recapiti[index].Area.Telegram.NrTelegram,
        orariTelegramMattina: this.recapiti[index].Area.Telegram.OrariMattina,
        orariTelegramPomeriggio:
          this.recapiti[index].Area.Telegram.OrariPomeriggio,
        form_contatto:
          this.recapiti[index].Area.Telefono.CliccaPerEssereRichiamato,
        mailForm:
          this.recapiti[index].Area.Telefono
            .DestinatarioDelCliccaPerEssereRichiamato,
        has_ticket: false,
        ticket_link: "",
      };

      if (this.recapiti[index].Area.hasOwnProperty('Ticket')) {
        this.dati_modale.has_ticket = this.recapiti[index].Area.Ticket.Link !== "";
        this.dati_modale.ticket_link = this.recapiti[index].Area.Ticket.Link;
      }

      // console.log(this.dati_modale.descrizione.length);
      // console.log(index);
    },
  },
};
</script>
