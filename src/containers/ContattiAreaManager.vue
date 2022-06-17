<template>
  <div class="h-100">
    <CModal
      color="dark"
      centered
      :show.sync="modale"
      style="z-index: 30"
      size="lg"
    >
      <template #header style="background-color: #1f4b6b !important">
        <strong class="h4" style="text-transform: uppercase"
          >Recapiti per {{ modale_recapiti.Descrizione }}
        </strong>
        <CButton class="close" @click="modale = false">
          <span aria-hidden="true">&times;</span>
        </CButton>
      </template>
      <template>
        <div class="justify-content-center align-items-center">
          <CContainer fluid>
            <CRow class="justify-content-center">
              <CCol md="11" class="p-0">
                <CCard style="border: 0px">
                  <CCardBody>
                    <div class="h4 py-2 text-center titolo_recapito nome">
                      {{ modale_recapiti.Nome ? modale_recapiti.Nome : modale_recapiti.Descrizione }}
                      <!-- <p
                        class="h4 mb-1 mt-3 text-center manager nome"
                        v-show="modale_recapiti.Nome"
                      >
                        <i>{{ modale_recapiti.Nome | capitalize }}</i>
                      </p> -->
                    </div>
                    <p class="text-muted"></p>
                    <div
                      class="riga_contatto align-middle"
                      style="border-top: 1px solid rgb(249, 223, 195)"
                      v-show="modale_recapiti.Telefono"
                    >
                      <div class="icona_contatto_modale mr-3 align-middle">
                        <i class="fas fa-phone fa-fw"></i>
                      </div>
                      <div class="recapito_dettaglio align-middle">
                        <div v-show="modale_recapiti.Telefono && !invio">
                          Chiamaci al numero:
                          <p>
                            <b>{{ modale_recapiti.Telefono }}</b>
                          </p>
                        </div>
                        <div v-show="invio">
                          Attendere invio richiesta in corso...
                          <img src="img/message.gif" style="width: 5rem" />
                        </div>
                        <div>
                          <p class="mb-0">
                            Oppure lascia il tuo numero e ti richiameremo noi
                          </p>
                          <div class="form-row py-2">
                            <div class="form-group col-md-6 m-0 py-0">
                              <input
                                type="text"
                                pattern="[0-9]+"
                                class="form-control"
                                v-model="inputTelefono"
                                id="inputTelefono"
                                placeholder="Telefono"
                                oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');"
                              />
                            </div>
                            <CButton
                              @click="
                                richiamami(
                                  inputTelefono,
                                  modale_recapiti.Email,
                                  modale_recapiti.Descrizione
                                )
                              "
                              style="color: white"
                              color="primary"
                              class="ml-2"
                              ><i class="fas fa-share"></i> Invia
                              Richiesta</CButton
                            >
                          </div>
                        </div>
                        <div
                          class="text-muted"
                          style="font-size: 0.9rem"
                          v-show="
                            modale_recapiti.TelefonoOraMattina &&
                            modale_recapiti.TelefonoOraPomeriggio
                          "
                        >
                          (orario {{ modale_recapiti.TelefonoOraMattina }} /
                          {{ modale_recapiti.TelefonoOraPomeriggio }} )
                        </div>
                      </div>
                    </div>
                    <div
                      class="riga_contatto align-middle"
                      style="border-top: 1px solid rgb(249, 223, 195)"
                      v-show="modale_recapiti.Cell"
                    >
                      <div class="icona_contatto_modale mr-3 align-middle">
                        <i class="fas fa-mobile-alt fa-fw"></i>
                      </div>
                      <div class="recapito_dettaglio align-middle">
                        <div>
                          Cellulare
                          <p>
                            <b>{{ modale_recapiti.Cell }}</b>
                          </p>
                        </div>
                      </div>
                    </div>
                    <div
                      class="riga_contatto align-middle py-4"
                      v-show="modale_recapiti.Email"
                    >
                      <div class="icona_contatto_modale mr-3 align-middle">
                        <i class="far fa-envelope fa-fw"></i>
                      </div>
                      <div
                        class="recapito_dettaglio d-inline-block align-middle"
                      >
                        {{ modale_recapiti.Nome ? "Mail" : "Mandaci una mail" }}
                        <p class="p-0 m-0 mail">
                          <a :href="'mailto:'">
                            <p class="mail">{{ modale_recapiti.Email }}</p></a
                          >
                        </p>

                        <div class="text-muted small_text"></div>
                      </div>
                    </div>
                    <!-- <div class="riga_contatto flex-column align-middle">
                      <div class="icona_contatto_modale mr-3 align-middle">
                        <i class="fab fa-telegram-plane"></i>
                      </div>
                      <div
                        class="recapito_dettaglio d-inline-block align-middle"
                      >
                        Scrivici su Telegram<br />
                        <b></b>
                        <br />
                        <div class="text-muted" style="font-size: 0.9rem">
                          (orario / )
                        </div>
                      </div>
                    </div> -->
                  </CCardBody>
                </CCard>
              </CCol>
            </CRow>
          </CContainer>
        </div>
        <CButton
          @click="modale = false"
          color="dark"
          size="sm"
          variant="outline"
          style="margin-left: auto; margin-right: auto; display: flex"
        >
          Chiudi
        </CButton>
      </template>

      <template #footer-wrapper>
        <p></p>
      </template>
    </CModal>
    <CCard class="mb-0 h-100">
      <CCardHeader class="d-flex justify-content-between" style="border-bottom:1px solid lightgray !important;">
        <strong class="h3 titolo_gradient">{{ chisono.Divisione_UnitaOperativa }}</strong>
        <div class="card-header-actions"></div>
      </CCardHeader>
      <CCardHeader class="d-flex justify-content-between py-4">
        <div class="text-center w-100" style="color: #ef7a13;"><strong class="h3 ">ASSICURAZIONI</strong>
        </div>
      </CCardHeader>
      <CCardBody class="manager news_card py-0">
        <CListGroup class="contatto">
          <CListGroupItem
            v-for="(contatto, index) in recapiti_assicurazioni"
            :key="index"
            class="flex-column align-items-start grow"
          >
            <div
              class="d-flex w-100 py-2"
              style="text-transform: uppercase"
              @click="show_recapito(index, 'auto')"
            >
              <div
                v-show="contatto.FontAweSomeIcon"
                class="icona_contatto mr-3"
                v-html="contatto.FontAweSomeIcon"
              ></div>
              <div class="recapito_name">
                <strong
                  >{{ contatto.Descrizione }}
                  </strong
                >
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

        <CCardHeader class="d-flex justify-content-between py-4">
          <div class="text-center w-100" style="color: #ef7a13;"><strong class="h3">GAS E LUCE</strong>
          </div>
        </CCardHeader>

        <CListGroup class="contatto">
          <CListGroupItem
            v-for="(contatto, index) in recapiti_energy"
            :key="index"
            class="flex-column align-items-start grow"
          >
            <div
              class="d-flex w-100 justify-content-between py-2"
              style="text-transform: uppercase"
              @click="show_recapito(index, 'energy')"
            >
              <div
                v-show="contatto.FontAweSomeIcon"
                class="icona_contatto mr-3"
                v-html="contatto.FontAweSomeIcon"
              ></div>
              <div class="recapito_name">
                <strong>{{ contatto.Descrizione }} </strong>
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
// import axios from "axios";

export default {
  name: "AreaManager",
  data() {
    return {
      recapiti_assicurazioni: [],
      recapiti_energy: [],
      recapiti_operativi: JSON.parse(localStorage.getItem("RecapitiAby")),
      chisono: JSON.parse(localStorage.getItem("chisono_data")),
      modale: false,
      modale_recapiti: [],
      invio: false,
      inputTelefono: "",
    };
  },
  mounted() {
    this.recapiti_operativi.forEach((item) => {
      if (item.Area.Settore == "ASSICURAZIONI" && item.Area.RecapitoCommerciale)
        this.recapiti_assicurazioni.push({
          Descrizione: item.Area.DescrizioneArea,
          Email: item.Area.Email,
          FontAweSomeIcon: item.Area.FontAweSomeIcon,
          Telefono: item.Area.Telefono.NrTelefono,
          TelefonoOraMattina: item.Area.Telefono.OrariMattina,
          TelefonoOraPomeriggio: item.Area.Telefono.OrariPomeriggio,
          Telegram: item.Area.Telegram.NrTelegram,
        });
    });
    if (this.chisono.DirettoreCommerciale) {
      this.recapiti_assicurazioni.push({
        Descrizione: "Direttore Commerciale",
        Nome: this.chisono.DirettoreCommerciale,
        Email: this.chisono.DirettoreCommerciale_Email,
        Cell: this.chisono.DirettoreCommerciale_Cellulare,
        FontAweSomeIcon: '<i class="fas fa-user-tie"></i>',
        Telefono: "",
      });
    }
    if (this.chisono.AreaManager) {
      this.recapiti_assicurazioni.push({
        Descrizione: "Area Manager",
        Nome: this.chisono.AreaManager,
        Email: this.chisono.AreaManager_Email,
        Cell: this.chisono.AreaManager_Cellulare,
        FontAweSomeIcon: '<i class="fas fa-users"></i>',
        Telefono: "",
      });
    }
    this.recapiti_operativi.forEach((item) => {
      if (item.Area.Settore == "GAS&LUCE" && item.Area.RecapitoCommerciale)
        this.recapiti_energy.push({
          Descrizione: item.Area.DescrizioneArea,
          Email: item.Area.Email,
          FontAweSomeIcon: item.Area.FontAweSomeIcon,
          Telefono: item.Area.Telefono.NrTelefono,
          TelefonoOraMattina: item.Area.Telefono.OrariMattina,
          TelefonoOraPomeriggio: item.Area.Telefono.OrariPomeriggio,
        });
    });

    this.recapiti_energy.push(
      {
        Descrizione: "Direttore Commerciale",
        Nome: this.chisono.Energy_DirettoreCommerciale,
        Email: this.chisono.Energy_DirettoreCommerciale_Email,
        Cell: this.chisono.Energy_DirettoreCommerciale_Cellulare,
        FontAweSomeIcon: '<i class="fas fa-user-tie"></i>',
        Telefono: "",
      },
      {
        Descrizione: "Area Manager",
        Nome: this.chisono.Energy_AreaManager,
        Email: this.chisono.Energy_AreaManager_Email,
        Cell: this.chisono.Energy_AreaManager_Cellulare,
        FontAweSomeIcon: '<i class="fas fa-users"></i>',
        Telefono: "",
      }
    );
  },
  methods: {
    // invia_contatto(telefono, mailReparto, settore) {
    //   // console.log(telefono);
    //   if (telefono) {
    //     this.invio = true;
    //     // chiamo il servizio per inviare la mail
    //     this.user = JSON.parse(localStorage.getItem("chisono_data"));
    //     // console.log("Utente:" + this.user.Nominativo);
    //     // console.log("Ufficio" + this.user.UnitaOperativa);
    //     // console.log("Telefono" + telefono);
    //     // console.log("MailReparto" + mailReparto);

    //     let params = {
    //       Utente: this.user.Nominativo,
    //       Ufficio: this.user.UnitaOperativa,
    //       Telefono: telefono,
    //       MailReparto: mailReparto,
    //       Settore: settore,
    //     };
    //     try {
    //       axios
    //         .post(
    //           this.$custom_json.base_url +
    //             this.$custom_json.api_url +
    //             this.$custom_json.ep_api.richiesta_contatto,
    //           { params }
    //         )
    //         .then((response) => {
    //           console.log(response.data);
    //           this.invio = false;
    //           this.$alert(
    //             "Sarai ricontattato quanto prima",
    //             "Richiesta inviata correttamente",
    //             "success"
    //           ).then(
    //             // eslint-disable-next-line no-unused-vars
    //             (result) => {
    //               this.modale_contatto = false;
    //             }
    //           );
    //         });
    //     } catch (error) {
    //       console.log(error);
    //     }
    //     return;
    //   } else {
    //     this.$alert(
    //       "Verifica di aver inserito il numero corretto",
    //       "Numero telefonico errato",
    //       "warning"
    //     );
    //     return;
    //   }
    // },
    show_recapito(index, settore) {
      let array_contatto = [];
      this.modale = true;
      this.inputTelefono = "";
      // let Mail = this.recapiti[tipo].Area.Email.split(";");
      // console.log(Mail);
      switch (settore) {
        case "auto":
          array_contatto = this.recapiti_assicurazioni[index];
          break;
        case "energy":
          array_contatto = this.recapiti_energy[index];
          break;

        default:
          break;
      }
      this.modale_recapiti = array_contatto;
      // console.log(index);
    },
  },
};
</script>
<style scoped>
.contatto li:hover {
  cursor: pointer;
  background-color: #ef7a13;
  color: white;
}
.contatto li:hover .small_text {
  color: white;
}
.card-header {
  border-bottom: 0px !important;
}
.card-footer {
  border-top: 0px !important;
}

.manager {
  font-size: 1rem;
}

.manager .list-group-item {
  border-left: 0px !important;
  border-right: 0px !important;
  border-bottom: 0px !important;
  border-radius: 0px !important;
}

.manager li {
  border-top: 1px solid rgba(0, 0, 21, 0.125) !important;
}
.manager li:last-of-type {
  border-bottom: 1px solid rgba(0, 0, 21, 0.125) !important;
}

.manager p {
  font-size: 1.1rem;
  font-weight: 100;
}

.nome {
  font-size: 1.5rem;
  font-weight: 500;
  text-transform: capitalize;
}

.mail {
  text-transform: lowercase;
  font-size: 1.3rem;
  font-weight: bold;
}

.manager .fa-fw {
  color: #1f4b6b;
}

.titolo_gradient {
  background: -webkit-linear-gradient(#ef7918, #1f4b6b);
  background-clip: border-box;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  font-weight: 700;
}
.icona_contatto {
  position: relative;
  display: -webkit-inline-box;
  display: -ms-inline-flexbox;
  display: inline-flex;
  -webkit-box-align: center;
  -ms-flex-align: center;
  align-items: center;
  -webkit-box-pack: center;
  -ms-flex-pack: center;
  justify-content: center;
  border-radius: 50em;
  min-width: 50px;
  height: 50px;
  font-size: 14.4px;
  background-color: #1d4b6b;
  color: white;
  font-size: 1.5rem;
  -webkit-box-shadow: 0px 6px 10px 0px #8a8a8a;
  -moz-box-shadow: 0px 6px 10px 0px #8a8a8a;
  -o-box-shadow: 0px 6px 10px 0px #8a8a8a;
  box-shadow: 0px 6px 10px 0px #8a8a8a;
}
.icona_contatto_modale {
  position: relative;
  display: -webkit-inline-box;
  display: -ms-inline-flexbox;
  display: inline-flex;
  -webkit-box-align: center;
  -ms-flex-align: center;
  align-items: center;
  -webkit-box-pack: center;
  -ms-flex-pack: center;
  justify-content: center;
  border-radius: 50em;
  width: 50px;
  height: 50px;
  font-size: 14.4px;
  background-color: #1d4b6b;
  color: white;
  font-size: 1.5rem;
  -webkit-box-shadow: 0px 6px 10px 0px #8a8a8a;
  -moz-box-shadow: 0px 6px 10px 0px #8a8a8a;
  -o-box-shadow: 0px 6px 10px 0px #8a8a8a;
  box-shadow: 0px 6px 10px 0px #8a8a8a;
}
.recapito_dettaglio {
  font-size: 1.5rem;
  margin-left: 2rem;
  display: inline-block;
}

.small_text {
  font-size: 0.7rem;
  color: rgb(155, 155, 155);
}

.grow {
  transition: all 0.2s ease-in-out;
}
.grow:hover {
  transform: scale(1.1);
}
.titolo_recapito {
  font-size: 3rem;
  text-shadow: 1px 1px 2px #838383;
}
.right_arrow {
  margin-top: auto;
  margin-bottom: auto;
  margin-right: 0;
  margin-left: auto;
}
.riga_contatto {
  padding: 1rem;
  border-bottom: 1px solid rgb(249, 223, 195);
  padding-top: 2rem;
  padding-bottom: 2rem;
  display: block ruby;
}
.modal-footer {
  border: 0px !important;
}
.card-body {
  padding: 0 !important;
}

@media screen and (max-width: 600px) {
  .riga_contatto {
    display: grid !important;
  }
  .icona_contatto_modale {
    margin-left: auto;
    margin-right: auto !important;
    margin-bottom: 1rem;
  }
  .mail {
    font-size: 3vw !important;
  }
}
</style>