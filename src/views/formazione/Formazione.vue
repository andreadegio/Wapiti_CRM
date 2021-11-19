<template>
  <div class="pt-2 formazione_style">
    <div class="row display-4 pb-3">
      <div class="col-12 text-center">Tutti i corsi a te riservati</div>
    </div>
    <div class="row">
      <div class="col-2 pl-5 text-center">
        <p>Totale corsi: {{ corsi.length }}</p>
        <!-- <p>Filtra per categoria:</p>
        <p>Filtra per settore:</p> -->
        <div class="mt-3" v-if="admin">
          <CLink to="AdminFormazione" style="color: #ef7a12 !important"
            ><CIcon name="cil-settings" /><strong> Gestione contenuti</strong>
          </CLink>
        </div>
      </div>
      <div class="col-10 ">
        <div class="row justify-content-center">
          <CCardGroup class="latest col-10">
            <div
              class="col-lg-4 col-sm-6 px-0"
              v-for="(item, index) in corsi"
              :key="index"
            >
              <CCard class="mx-1 card_materiale">
                <CLink
                  :to="{
                    name: 'Corso',
                    params: {
                      corso: item.titolo,
                      id: item.id,
                      lista_corsi: corsi,
                    },
                  }"
                >
                  <CCardImg
                    :src="$custom_json.base_url + item.copertina"
                    style="height: 15rem; object-fit: cover"
                    alt="- IMPOSSIBILE CARICARE -"
                  >
                  </CCardImg>
                  <CCardBody
                    class="py-1 px-2 card_post"
                    :style="{ '--bgColor': item.color_settore }"
                    style="min-height: 10rem"
                  >
                    <div class="text-uppercase settore_color pt-3">
                      <strong>
                        <u>{{ item.settore }}</u>
                      </strong>
                    </div>

                    <div class="titolo text-left pt-3">
                      {{ item.titolo }}
                    </div>
                    <div class="row dettagli pt-4 pb-5 text-center">
                      <div class="col-6">
                        <i class="far fa-calendar-alt"></i>
                        {{ item.data_ins | formatDate }}
                      </div>
                      <div class="col-6">
                        <i class="far fa-clock"></i> {{ item.durata }} minuti
                      </div>
                    </div>
                    <div class="text-right"></div>
                  </CCardBody>
                  <CCardFooter class="text-right py-2"
                    ><strong>Vai al corso...</strong>
                  </CCardFooter>
                </CLink>
              </CCard>
            </div>
          </CCardGroup>
        </div>
      </div>
      <div class="col-1"></div>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      admin: JSON.parse(localStorage.getItem("chisono_data")).Is_Sede,
      isEnergy: JSON.parse(localStorage.getItem("chisono_data"))
        .Abilitato_Energy,
      isAuto: JSON.parse(localStorage.getItem("chisono_data")).Abilitato_Auto,
      corsi: [],
      bgColor: "#1e2f56",
    };
  },
  mounted() {
    this.get_lista_corsi();
  },
  methods: {
    async get_lista_corsi() {
      // Chiamata per recuperare la lista dei corsi
      let params = {
        UO_tipo: JSON.parse(localStorage.getItem("chisono_data"))
          .UnitaOperativa_Tipo_ID,
        is_sede: JSON.parse(localStorage.getItem("chisono_data")).Is_Sede,
      };
      var lista_corsi = [];
      try {
        await axios
          .post(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.ep_api.lista_corsi,
            { params },
            {
              header: {
                "Content-Type": "multipart/form-data",
              },
            }
          )
          .then((response) => {
            lista_corsi = response.data;
          });
        this.corsi = lista_corsi.map((item, id) => {
          return { ...item, id };
        });
      } catch (error) {
        console.log("impossibile accedere al cloud");
      }
    },
  },
};
</script>

<style scoped>
.card_post::before {
  content: "";
  display: block;
  position: absolute;
  /* top: 0; */
  width: 50%;
  left: 0;
  height: 8px;
  background: linear-gradient(
    to right,
    var(--bgColor) 60%,
    rgba(255, 255, 255, 0) 100%
  );
  /* border-top: 8px solid var(--bgColor); */
}
.latest a:hover {
  text-decoration: none;
}
.settore_color {
  color: var(--bgColor);
  opacity: 0.5;
}
.titolo {
  font-size: 1.8rem !important;
  max-width: 80%;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  letter-spacing: 0.05rem;
}

.dettagli {
  font-size: 0.8rem !important;
  text-transform: uppercase;
  letter-spacing: 0.025em;
  color: #ef7a12 !important;
}
.card-img,
.card-img-bottom {
  border-bottom-right-radius: 0 !important;
  border-bottom-left-radius: 0 !important;
}
.formazione_style {
  display: grid;
  overflow: hidden;
}
</style>

