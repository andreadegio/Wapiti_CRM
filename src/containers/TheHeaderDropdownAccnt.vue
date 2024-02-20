<template>
  <div>
    <CModal
      color="dark"
      centered
      :show.sync="show_profile"
      style="z-index: 30"
      size="lg"
    >
      <template #header>
        <strong style="text-transform: uppercase">Profilo Utente</strong>
        <CButton class="close" @click="show_profile = false">
          <!-- <button type="button" class="close" aria-label="Close"> -->
          <span aria-hidden="true">&times;</span>
        </CButton>
      </template>
      <template>
        <div class="d-flex align-items-center">
          <CContainer fluid>
            <CRow class="justify-content-center">
              <CCol md="10">
                <CCard>
                  <CCardBody align="center">
                    <h1>{{ user.Nominativo }}</h1>
                    <div>
                      <p><b>E-mail:</b> {{ user.Email }}</p>
                      <p v-show="user.UnitaOperativa_Email != ''">
                        <b>E-mail unità operativa:</b>
                        {{ user.UnitaOperativa_Email }}
                      </p>

                      <p class="text-muted"></p>
                      <p><b>Unità Operativa:</b> {{ user.UnitaOperativa }}</p>

                      <p><b>Intermediario:</b> {{ user.Intermediario }}</p>
                      <p
                        style="text-transform: capitalize"
                        v-show="user.DirettoreCommerciale"
                      >
                        <b>Direttore Commerciale:</b>
                        {{ user.DirettoreCommerciale | capitalize }} (<em
                          style="text-transform: lowercase"
                          >{{ user.DirettoreCommerciale_Email }}</em
                        >)
                      </p>
                      <p
                        style="text-transform: capitalize"
                        v-show="user.AreaManager"
                      >
                        <b>Area Manager:</b>
                        {{ user.AreaManager | capitalize }} (<em
                          style="text-transform: lowercase"
                          >{{ user.AreaManager_Email }}</em
                        >)
                      </p>
                    </div>
                    <div
                      class="pt-3 pb-2 text-center text-uppercase"
                      style="font-weight: bold"
                    >
                      Piattaforme operative abilitate:
                    </div>

                    <CRow class="py-4" style="justify-content: center">
                      <CCol sm="3" class="text-center mx-2 border">
                        <CRow align-horizontal="center" class="bg-broker"
                          ><span class="py-3 intestazione_accessi">
                            <i class="fas fa-car-alt fa-3x"></i>
                            <br />
                            Piattaforma<br />Assicurazioni</span
                          ></CRow
                        >
                        <CRow align-horizontal="center"
                          ><div
                            v-show="user.Abilitato_Auto"
                            class="py-3"
                            style="color: green"
                          >
                            <i class="fas fa-check fa-3x"></i>
                          </div>
                          <div
                            v-show="!user.Abilitato_Auto"
                            class="py-3"
                            style="color: red"
                          >
                            <i class="fas fa-times fa-3x"></i></div
                        ></CRow>
                      </CCol>
                      <CCol sm="3" class="text-center mx-2 border">
                        <CRow align-horizontal="center" class="bg-rami"
                          ><span class="py-3 intestazione_accessi">
                            <i class="fas fa-user-tie fa-3x"></i>
                            <br />
                            Piattaforma<br />Professionisti</span
                          ></CRow
                        >
                        <CRow align-horizontal="center"
                          ><div
                            v-show="user.Abilitato_Rami"
                            class="py-3"
                            style="color: green"
                          >
                            <i class="fas fa-check fa-3x"></i>
                          </div>
                          <div
                            v-show="!user.Abilitato_Rami"
                            class="py-3"
                            style="color: red"
                          >
                            <i class="fas fa-times fa-3x"></i></div
                        ></CRow>
                      </CCol>
                      <CCol sm="3" class="text-center mx-2 border">
                        <CRow align-horizontal="center" class="bg-energy"
                          ><span class="py-3 intestazione_accessi">
                            <i class="far fa-lightbulb fa-3x"></i>
                            <br />
                            Piattaforma<br />Gas & Luce</span
                          ></CRow
                        >
                        <CRow align-horizontal="center"
                          ><div
                            v-show="user.Abilitato_Energy"
                            class="py-3"
                            style="color: green"
                          >
                            <i class="fas fa-check fa-3x"></i>
                          </div>
                          <div
                            v-show="!user.Abilitato_Energy"
                            class="py-3"
                            style="color: red"
                          >
                            <i class="fas fa-times fa-3x"></i></div
                        ></CRow>
                      </CCol>
                    </CRow>
                  </CCardBody>
                </CCard>
              </CCol>
            </CRow>
          </CContainer>
        </div>
      </template>

      <template #footer>
        <CButton
          @click="show_profile = false"
          color="dark"
          size="sm"
          variant="outline"
        >
          Chiudi
        </CButton>
      </template>
    </CModal>

    <CModal
      id="logout_modale"
      color="dark"
      centered
      :show.sync="logout_modale"
      style="z-index: 30"
      size="sm"
      :closeOnBackdrop="false"
    >
      <template #header>
        <strong style="text-transform: uppercase">Logout</strong>
      </template>
      <template>
        <div class="d-flex align-items-center">
          <CContainer fluid>
            <CRow class="justify-content-center">
              <img src="img/logout.gif" />
              <span class="text-center"
                ><strong
                  >Chiusura in corso...<br />Attendi 5 secondi e sarai
                  reindirizzato alla pagina di login.</strong
                >
              </span>
            </CRow>
          </CContainer>
        </div>
      </template>

      <template #footer>
        <span></span>
      </template>
    </CModal>

    <CDropdown
      inNav
      class="c-header-nav-items"
      placement="bottom-end"
      add-menu-classes="pt-0"
    >
      <template #toggler>
        <CHeaderNavLink>
          <div
            @click="aggiornaSede()"
            id="user_option"
            class="c-avatar"
            v-c-tooltip="{ content: 'OPZIONI', placement: 'bottom-end' }"
          >
            <CIcon name="cil-user" style="margin-right: 0 !important" />
            <!-- <img src="img/avatars/7.jpg" class="c-avatar-img" /> -->
          </div>
        </CHeaderNavLink>
      </template>
      <CDropdownHeader tag="div" class="text-center" color="light" v-if="admin">
        <strong>Utility</strong>
      </CDropdownHeader>
      <CDropdownItem to="/Crm" v-if="accessoCRM">
        <i class="fas fa-address-book"></i> <span class="pl-1">CRM</span>
      </CDropdownItem>
      <!-- <CDropdownItem to="/Calendario" v-if="admin">
        <i class="far fa-calendar-alt"></i>
        <span class="pl-1">Appuntamenti</span>
      </CDropdownItem> -->
      <CDropdownItem to="/Accessi_stat" v-if="admin">
        <i class="far fa-chart-bar"> </i> <span class="pl-1">Accessi</span>
      </CDropdownItem>
      <CDropdownItem
        href="https://www.abyway.it/Monitor/GestioneMonitor.html"
        target="_blank"
        v-if="admin"
      >
        <i class="fas fa-tv"></i> <span class="pl-1">Gestione TV</span>
      </CDropdownItem>
      <CDropdownHeader tag="div" class="text-center" color="light" v-if="user.Is_Abilitato_Elearning">
        <strong>Formazione</strong>
      </CDropdownHeader>
      <CDropdownItem
        :href="$custom_json.url_elearning_rami"
        target="_blank"
        v-if="user.Is_Abilitato_Elearning"
      >
      <i class="fas fa-graduation-cap"></i> <span class="pl-1">E-learning</span>
      </CDropdownItem>

      <CDropdownHeader tag="div" class="text-center" color="light">
        <strong>Account</strong>
      </CDropdownHeader>
      <CDropdownItem to="/GeneratoreFirme" v-if="firma">
        <i class="fas fa-file-signature"></i>
        <span class="pl-1">Genera Firma</span>
      </CDropdownItem>
      <CDropdownItem @click="Get_user()">
        <CIcon name="cil-user" /> Profilo
      </CDropdownItem>
      <CDropdownItem @click="Logout()">
        <!-- <CHeaderNavLink to="login"> -->
        <CIcon :content="$options.logout_ico" /> Logout
        <!-- </CHeaderNavLink> -->
      </CDropdownItem>
    </CDropdown>
  </div>
</template>

<script>
import axios from "axios";
import { cilAccountLogout } from "@coreui/icons";
import store from "../store";
export default {
  name: "MenuUser",
  logout_ico: cilAccountLogout,
  data() {
    return {
      admin: false,
      firma: false,
      logout_modale: false,
      show_profile: false,
      url_logout: "",
      user: JSON.parse(localStorage.getItem("chisono_data")),
      userCRMInfo: [],
    };
  },
  computed: {
    accessoCRM() {
      console.log(this.userCRMInfo.idbroker);
      return this.userCRMInfo.idbroker ? true : false;
    },
  },
  mounted() {
    this.getUserCRMInfo();
  },
  methods: {
    async getUserCRMInfo() {
      let param = {
        idUtente: this.user["idUtente"],
      };
      try {
        await axios
          .post(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.crm.accessoCRM,
            param
          )
          .then((response) => {
            this.userCRMInfo = response.data;
            localStorage.setItem(
              "userCRMInfo",
              JSON.stringify(this.userCRMInfo)
            );
          });
      } catch (error) {
        console.error(error);
      }
    },
    aggiornaSede() {
      this.admin = JSON.parse(localStorage.getItem("chisono_data")).Is_Sede;
      this.firma = JSON.parse(
        localStorage.getItem("chisono_data")
      ).Is_Abilitato_Genera_Firma_Aziendale;
      // console.log("agg_sede");
    },
    Get_user() {
      this.show_profile = true;
    },

    Logout() {
      // // funzione di logout. Viene chiamata la pagina del broker e di energy e dopo 2 secondi viene effettuato il redirect alla login
      this.logout_modale = true;

      let aua = localStorage.getItem("AUA");
      if (aua === true) {
        console.log("AUA_logout");
        store.commit("user_logout");
        setTimeout(() => {
          window.open(this.$custom_json.logout_url_energy, "_self");
          window.open(this.$custom_json.logout_aua_url, "_self");
        }, 2000);
      } else {
        store.commit("user_logout");
        setTimeout(() => {
          window.open(this.$custom_json.logout_url_energy, "_self");
          window.open(this.$custom_json.logout_url, "_self");
        }, 2000);
      }
    },
  },
};
</script>
