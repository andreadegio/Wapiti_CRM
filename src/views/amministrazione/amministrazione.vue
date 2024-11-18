<template>
    <div>
        <div style="text-align: center;" class="py-5">
            <h1>Area amministrativa</h1>
        </div>
        <CRow>
            <CCol>

            </CCol>
            <CCol>
                <!-- BROKERNET RCA -->
                <div class="col-sm">
                    <CCardLink target="_self" @click="accesso('broker')">
                        <CCard class="text-center elevation-6 portali-btn grow" body-wrapper style="
                      height: 200px;
                      background-image: url('img/buttons/auto.png');
                      background-position: center;
                      z-index: 0;
                      background-size: cover;
                    ">
                            <CCardTitle class="grow titolo_piattaforme">
                                <span class="portali">Amministrazione</span>
                                <h1 class="pulsante_portali">RC AUTO</h1>
                            </CCardTitle>
                        </CCard>
                    </CCardLink>
                </div>
            </CCol>
            <CCol>
                <!-- ABYNEXT2 RAMI -->
                <div v-if="isRami && isNext2" class="col-sm">
                    <CCardLink @click="accesso('ramiNext')" target="_self">
                        <CCard class="text-center elevation-6 portali-btn grow" body-wrapper style="
                      height: 200px;
                      background-image: url('img/buttons/rami.png');
                      background-position: center;
                      z-index: 0;
                      background-size: cover;
                    ">
                            <CCardTitle class="grow titolo_piattaforme">
                                <span class="portali">Amministrazione</span>
                                <h1 class="pulsante_portali">ALTRI RAMI</h1>
                            </CCardTitle>
                        </CCard>
                    </CCardLink>
                </div>
            </CCol>
            <CCol>
                <!-- ABY ENEREGY GAS LUCE -->
                <div class="col-sm" v-if="isEnergy">
                    <CCardLink @click="accesso('energy')">
                        <CCard class="text-center elevation-6 portali-btn grow" body-wrapper style="
                  height: 200px;
                  background-image: url('img/buttons/energy.png');
                  background-position: center;
                  z-index: 0;
                  background-size: cover;
                ">
                            <CCardTitle class="grow titolo_piattaforme">
                                <span class="portali">Amministrazione</span>
                                <h1 class="pulsante_portali">ENERGIA</h1>
                            </CCardTitle>
                        </CCard>
                    </CCardLink>
                </div>
            </CCol>
            <CCol>

            </CCol>
        </CRow>
    </div>
</template>
<script>
import axios from "axios";
export default {
    name: "Amministrazione",

    data() {
        return {
            isRami: JSON.parse(localStorage.getItem("chisono_data")).Abilitato_Rami,
            isEnergy: JSON.parse(localStorage.getItem("chisono_data")).Abilitato_Energy,
            isNext2: true,
        }
    },
    methods: {
        async accesso(settore) {

            try {

                switch (settore) {
                    case "broker":
                        window.location.href = this.$custom_json.amministrazione.auto;
                        break;
                    case "energy":
                        this.loginEnergy();
                        break;

                    case "ramiNext":
                        this.setLoading(false, 10 * 1000);

                        await this.abyNext2();

                        if (this.urlRamiNext2) {
                            window.location.href = this.urlRamiNext2;
                        } else {
                            window.location.href = localStorage.getItem("urlRamiNext2");
                        }

                        break;
                    default:
                        break;
                }

            } catch (error) {
                console.log(error);
            }
            // alert("uno in più per " + settore + " è entrato " + this.userID);
        },
        async abyNext2() {
            // =================== ACCESSO PER ABYNEXT 2 ===============================
            let baseUrlNext2 = this.$custom_json.ep_api.baseUrlNext2;
            try {
                let userID = localStorage.getItem("userID");
                var paramNext2 = {
                    id: userID,
                    user: "sdfghblzs",
                    pwd: "lkdfasvdfg"
                };
                var response = await axios
                    .post(
                        this.$custom_json.base_url +
                        this.$custom_json.api_url +
                        this.$custom_json.ep_api.getUrlNext2,
                        paramNext2
                    );

                localStorage.setItem(
                    "urlRamiNext2",
                    baseUrlNext2 + "?token=" + response.data.token
                );
            } catch (error) {
                console.log("impossibile recuperare jwt rami " + error);
            }
        },
    }
}
</script>
