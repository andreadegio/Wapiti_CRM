<template>
    <div id="cover" class="min-vh-100" style="
      background: rgb(255, 255, 255) url('img/filigranaAmministrazione.jpg') no-repeat scroll
        0% 0%;
    ">
        <div style="text-align: center;" class="py-5">

        </div>
        <CRow>
            <CCol sm="1">

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
            <CCol sm="1">

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
            urlAmministrazioneNext2: localStorage.getItem("urlAmministrazioneNext2"),
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

                        await this.amministrazioneNext2();

                        if (this.urlAmministrazioneNext2) {
                            window.location.href = this.urlAmministrazioneNext2;
                        } else {
                            window.location.href = localStorage.getItem("urlAmministrazioneNext2");
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
        loginEnergy() {
            // console.log("invio il form di login");
            // Creo un form
            var EnergyForm = document.createElement("form");
            EnergyForm.name = "formLogin";
            EnergyForm.target = "_self";
            EnergyForm.method = "POST";
            EnergyForm.action = this.$custom_json.amministrazione.energia;

            // Creo l'input per l'user
            var EnergyFormUser = document.createElement("input");
            EnergyFormUser.type = "hidden";
            EnergyFormUser.name = "user";
            EnergyFormUser.value = localStorage.getItem("user");

            // Creo l'input per la passwd
            var EnergyFormPwd = document.createElement("input");
            EnergyFormPwd.type = "hidden";
            EnergyFormPwd.name = "password";
            EnergyFormPwd.value = localStorage.getItem("pwd");

            // Creo l'input per il token
            var EnergyFormToken = document.createElement("input");
            EnergyFormToken.type = "hidden";
            EnergyFormToken.name = "72aeb0fc-7bd8-11e5-b78d-00505693441e";
            EnergyFormToken.value = "securetoken";

            // Aggiungo i campi al form
            EnergyForm.appendChild(EnergyFormUser);
            EnergyForm.appendChild(EnergyFormPwd);
            EnergyForm.appendChild(EnergyFormToken);

            // Aggiungo il form al dom
            document.body.appendChild(EnergyForm);

            // Invio la richiesta
            EnergyForm.submit();
        },
        // attiva/disattiva il loader, emettendo un evento
        // che viene ascoltato da TheContainer
        // se specificato un timeout, il loader torna allo stato precedente
        setLoading(is_loading, timeout_ms = null) {
            this.$emit("set-loading", is_loading, timeout_ms);
        },
        async amministrazioneNext2() {
            // =================== ACCESSO AREA AMMINISTRAZIONE PER ABYNEXT 2 ===============================
            let amministrazioneUrlNext2 = this.$custom_json.amministrazione.rami;
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
                    "urlAmministrazioneNext2",
                    amministrazioneUrlNext2 + "token=" + response.data.token
                );
            } catch (error) {
                console.log("impossibile recuperare jwt rami " + error);
            }
        },
    }
}
</script>
<style scoped>
#cover {
    background-size: cover !important;
    background-position: right !important;
    max-width: none !important;
}
</style>
