<template >
  <div>
    <CModal
      color="dark"
      centered
      :show.sync="show_profile"
      style="z-index: 30"
      size="lg"
    >
      <template #header style="background-color: #1f4b6b !important">
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
                  <CCardBody>
                    <h1>{{ user.Nominativo }}</h1>
                    <p class="text-muted"></p>
                    <p>Unità Operativa: {{ user.UnitaOperativa }}</p>
                    <p>Intermediario: {{ user.Intermediario }}</p>
                    <p>
                      Abilitazione Auto: {{ user.Abilitato_Auto ? "SI" : "NO" }}
                    </p>
                    <p>
                      Abilitazione Rami: {{ user.Abilitato_Rami ? "SI" : "NO" }}
                    </p>
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
      <template #header style="background-color: #1f4b6b !important">
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
            id="user_option"
            class="c-avatar"
            v-c-tooltip="{ content: 'OPZIONI', placement: 'bottom-end' }"
          >
            <CIcon name="cil-user" style="margin-right: 0 !important" />
            <!-- <img src="img/avatars/7.jpg" class="c-avatar-img" /> -->
          </div>
        </CHeaderNavLink>
      </template>
      <CDropdownHeader tag="div" class="text-center" color="light">
        <strong>Account</strong>
      </CDropdownHeader>
      <CDropdownItem @click="Get_user()">
        <CIcon name="cil-user" /> Profilo
      </CDropdownItem>
      <!-- <CDropdownItem>
        <CIcon name="cil-bell" /> Updates
        <CBadge color="info" class="mfs-auto">{{
          itemsCount
        }}</CBadge> </CDropdownItem> -->
        
        <!-- 
    <CDropdownItem>
      <CIcon name="cil-envelope-open" /> Messages
      <CBadge color="success" class="mfs-auto">{{ itemsCount }}</CBadge>
    </CDropdownItem>
    <CDropdownItem>
      <CIcon name="cil-task" /> Tasks
      <CBadge color="danger" class="mfs-auto">{{ itemsCount }}</CBadge>
    </CDropdownItem>
    <CDropdownItem>
      <CIcon name="cil-comment-square" /> Comments
      <CBadge color="warning" class="mfs-auto">{{ itemsCount }}</CBadge>
    </CDropdownItem> -->
      <!-- <CDropdownHeader
      tag="div"
      class="text-center"
      color="light"
    >
      <strong>Settings</strong>
    </CDropdownHeader>
    
    <CDropdownItem>
      <CIcon name="cil-settings" /> Settings
    </CDropdownItem>
    <CDropdownItem>
      <CIcon name="cil-dollar" /> Payments
      <CBadge color="secondary" class="mfs-auto">{{ itemsCount }}</CBadge>
    </CDropdownItem>
    <CDropdownItem>
      <CIcon name="cil-file" /> Projects
      <CBadge color="primary" class="mfs-auto">{{ itemsCount }}</CBadge>
    </CDropdownItem>
    <CDropdownDivider/>
    <CDropdownItem>
      <CIcon name="cil-shield-alt" /> Lock Account
    </CDropdownItem> -->
      <CDropdownItem @click="Logout()">
        <!-- <CHeaderNavLink to="login"> -->
        <CIcon :content="$options.logout_ico" /> Logout
        <!-- </CHeaderNavLink> -->
      </CDropdownItem>
    </CDropdown>
  </div>
</template>

<script>
import { cilAccountLogout } from "@coreui/icons";
import store from "../store";
export default {
  name: "TheHeaderDropdownAccnt",
  logout_ico: cilAccountLogout,
  data() {
    return {
      user: [
        {
          idUtente: "",
          idAnagrafica: "",
          Nominativo: "",
          idUnitaOperativa: "",
          UnitaOperativa: "",
          idIntermediarioUO: "",
          Intermediario: "",
          Is_Sede: false,
          Abilitato_Auto: true,
          Abilitato_Rami: true,
          Stato: "OK",
        },
      ],
      logout_modale: false,
      show_profile: false,
      url_logout: "",
      itemsCount: 42,
    };
  },

  methods: {
    Get_user() {
      this.user = JSON.parse(localStorage.getItem("chisono_data"));
      this.show_profile = true;
    },

    Logout() {
      // // funzione di logout. Viene chiamata la pagina del broker e dopo 5 secondi viene effettuato il redirect alla login
      this.logout_modale = true;
      store.commit("user_logout");
      setTimeout(() => {
        window.open(this.$custom_json.logout_url, "_self");
      }, 3000);
    },
  },
};
</script>

<style scoped>
#user_option {
  background-color: #0b4a9b;
  color: white;
}
#user_option:hover {
  background-color: rgb(239, 122, 18);
}
.c-icon {
  margin-right: 0.3rem;
}
</style>