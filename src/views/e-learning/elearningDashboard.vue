<template>
    <v-app>
        <v-app-bar app style="background-color: white;">
            <img class="immagine" src="img/Aby-Academy_small.png" />
            <h1 style="color: #1f4b6b">Aby Academy</h1>
        </v-app-bar>

        <v-main style="margin-top: 2rem; margin-left: 1rem; margin-right: 1rem;">
            <v-row>
                <v-col cols="12" md="1"></v-col> <!-- Spazio iniziale -->
                <v-col cols="12" md="2">
                    <div class="widget">
                        <div class="top_profile">
                            <div class="img_profile">
                                <img class="profilo" src="img/user_profile.png" />
                            </div>
                        </div>
                        <div class="bottom_profile">
                            <div class="profile_data text-center">
                                {{ benvenuto }}
                                <h2>{{ utente }}</h2>
                            </div>
                        </div>
                    </div>
                    <div class="strumenti_profile px-5">
                        <div class="menu_strumenti my-2">
                            <v-dialog v-model="dialog" transition="dialog-top-transition" max-width="600">
                                <template v-slot:activator="{ on, attrs }">
                                    <div class="btn_strumenti" v-bind="attrs" v-on="on">
                                        <i class="fas fa-envelope-open-text"></i>
                                        <p class="btn_strumenti">Contatta il tuo Tutor</p>
                                    </div>
                                </template>
                                <v-card>
                                    <v-toolbar color="primary" dark>Contatta il tutor</v-toolbar>
                                    <v-card-text>
                                        <v-form ref="form" v-model="valid" lazy-validation>
                                            <v-text-field v-model="subject"
                                                :rules="[v => !!v || 'L\'oggetto è richiesto']" label="Oggetto"
                                                required></v-text-field>
                                            <v-textarea v-model="message"
                                                :rules="[v => !!v || 'Il messaggio è richiesto']" label="Messaggio"
                                                required></v-textarea>
                                        </v-form>
                                    </v-card-text>
                                    <v-card-actions class="justify-end">
                                        <v-btn text @click="dialog = false">Annulla</v-btn>
                                        <v-btn color="primary" @click="sendEmail">Invia</v-btn>
                                    </v-card-actions>
                                </v-card>
                            </v-dialog>

                            <v-divider></v-divider>
                            <div class="btn_strumenti" @click="logout">
                                <i class="fas fa-sign-out-alt"></i>
                                <p class="btn_strumenti">Esci</p>
                            </div>
                        </div>
                    </div>
                </v-col>
                <v-col cols="12" md="8">
                    <div class="h3" style="color: #1f4b6b;"> Corsi disponibili</div>
                    <div class="corsi">
                        <v-row class="fill-height" v-if="loadingCourses">
                            <v-col cols="12" md="3" lg="3">
                                <div class="course-card">
                                    <v-skeleton-loader class="mx-auto" max-width="300" type="card"></v-skeleton-loader>
                                </div>
                            </v-col>
                            <v-col cols="12" md="3" lg="3">
                                <div class="course-card">
                                    <v-skeleton-loader class="mx-auto" max-width="300" type="card"></v-skeleton-loader>
                                </div>
                            </v-col>
                            <v-col cols="12" md="3" lg="3">
                                <div class="course-card">
                                    <v-skeleton-loader class="mx-auto" max-width="300" type="card"></v-skeleton-loader>
                                </div>
                            </v-col>

                        </v-row>
                        <v-row v-else class="fill-height">
                            <v-col cols="12" md="3" lg="3" v-for="course in courses" :key="course.id">
                                <router-link :to="{
                                    name: `E-learningCorso`,
                                    params: { course: course },
                                }" style="text-decoration: none; color: inherit;">
                                    <div class="course-card">
                                        <div class="card-container">

                                            <v-img :src="course.cover" class="course-image" height="200">
                                                <template v-slot:placeholder>
                                                    <v-row class="fill-height ma-0" align="center" justify="center">
                                                        <v-progress-circular indeterminate
                                                            color="grey lighten-5"></v-progress-circular>
                                                    </v-row>
                                                </template>
                                            </v-img>
                                            <img src="video/academy/graduate.png" class="badge_graduate"
                                                v-if="course.avanzamento == 100">
                                        </div>
                                        <div class="titoli">
                                            <div class="course-title mt-4">{{ course.corso }}</div>
                                            <div class="course-subtitle mt-3">{{ course.descrizione }}</div>
                                        </div>

                                        <v-progress-linear :value="course.avanzamento" class="mt-3"></v-progress-linear>
                                        <cite style="color: #1f4b6b !important;">{{
                                    course.avanzamento }}%
                                            completato</cite>
                                        <div class="course-info">
                                            <v-row>
                                                <v-col cols="6">
                                                    <div class="course-lessons">
                                                        <i class="fas fa-video"></i> &nbsp; {{ course.video.length }}
                                                        Video
                                                    </div>
                                                </v-col>
                                                <v-col cols="6">
                                                    <div class="course-duration">
                                                        <i class="fas fa-stopwatch"></i> &nbsp; {{ course.durata_totale
                                                        }}
                                                    </div>
                                                </v-col>
                                            </v-row>
                                        </div>
                                        <!--                                     
                                    <div>
                                        <v-btn text color="primary">Vai al corso</v-btn>

                                    </div> -->
                                    </div>
                                </router-link>
                            </v-col>
                        </v-row>
                    </div>

                </v-col>
                <v-col cols=" 12" md="1">
                </v-col> <!-- Spazio finale -->
            </v-row>
        </v-main>
    </v-app>
</template>
<script>
import axios from "axios";
export default {
    name: "AbyAcademy",

    data() {
        return {
            dialog: false,
            valid: false,
            subject: '',
            message: '',
            loadingCourses: true,
            benvenuto: "",
            utente: "",
            courses: [],
        };
    },
    async created() {
        this.setBenvenuto();
        // Recupera le informazioni sui corsi
        await this.fetchCourses();

        // Recupera le informazioni dell'utente
        await this.fetchUserInfo();

        // Recupera l'avanamento del corso;
        await this.fetchAvanzamento();

        // Nascondi il loader dopo che entrambe le richieste sono state completate
        setTimeout(() => { this.loadingCourses = false }, 1000);
        // this.loadingCourses = false;

    },
    methods: {
        sendEmail() {
            if (this.$refs.form.validate()) {

                console.log('Oggetto:', this.subject);
                console.log('Messaggio:', this.message);
                this.dialog = false;
            }
        },
        logout() {

            console.log('Logout');
        },
        async fetchAvanzamento() {
            let totalCompletedVideos = 0;
            let totalVideos = 0;
            let avanzamento = 0;
            let quizAvailable = false;

            // Itera su ciascun corso e calcola il numero di video completati e il numero totale di video
            this.courses.forEach(course => {
                totalCompletedVideos += course.video.filter(video => video.completed).length;
                totalVideos += course.video.length;
                course.quiz == 1 ? quizAvailable = true : quizAvailable = false;
            });
            if (totalVideos === 0) {
                avanzamento = 0; // Per evitare divisioni per zero
            } else {
                quizAvailable ? totalVideos = totalVideos + 1 : totalVideos;
                avanzamento = Math.round((totalCompletedVideos / (totalVideos)) * 100);
            }

            // Aggiungi l'avanzamento a ciascun corso
            this.courses.forEach(course => {
                if (course.superato == 1) {
                    course.avanzamento = 100;
                } else {
                    course.avanzamento = avanzamento;
                }
            });

            return;
        },
        setBenvenuto() {
            const now = new Date();
            const hour = now.getHours();
            if (hour >= 5 && hour < 12) {
                this.benvenuto = "Buongiorno";
            } else if (hour >= 12 && hour < 18) {
                this.benvenuto = "Buon pomeriggio";
            } else {
                this.benvenuto = "Buona sera";
            }
        },
        async fetchCourses() {
            let params = {
                id: sessionStorage.getItem('learningUserId')
            };
            try {
                // Effettua la chiamata al backend per recuperare i corsi disponibili
                await axios.post(this.$custom_json.base_url +
                    this.$custom_json.api_url +
                    this.$custom_json.academy.getElearningCourses, params).then(response => {
                        // Assegna i dati ricevuti dalla chiamata alla variabile courses
                        this.courses = response.data;
                    })
            } catch (error) {
                // Gestisci gli errori, ad esempio mostrando un messaggio all'utente
                console.error('Errore durante il recupero dei corsi:', error);
            }
        },
        async fetchUserInfo() {
            try {
                // Recupera l'ID dell'utente dal sessionStorage
                const userId = sessionStorage.getItem('learningUserId');
                // Effettua la chiamata al backend per recuperare le informazioni dell'utente

                await axios.post(this.$custom_json.base_url
                    + this.$custom_json.api_url +
                    this.$custom_json.academy.getUserInfoById,
                    { id: userId })
                    .then(response => {
                        // Assegna i dati ricevuti dalla chiamata alla variabile user
                        sessionStorage.setItem('learningUtente', JSON.stringify(response.data.utente));
                        response.data.utente[0].pf_pg == "PF" ? this.utente = response.data.utente[0].nome + " " + response.data.utente[0].cognome : this.utente = response.data.utente[0].rag_soc;
                    })
            } catch (error) {
                // Gestisci gli errori, ad esempio mostrando un messaggio all'utente
                console.error('Errore durante il recupero delle informazioni dell\'utente:', error);
            }
        }
    },
    mounted() {

    }
};
</script>

<style scoped>
.badge_graduate {
    position: absolute;
    width: 50px;
    left: auto;
    right: 2rem;
    top: 20vh;
}

.course-card {
    margin-bottom: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    border: 1px solid #d1d4d6;
    padding: 1rem;
}

.card-container {
    overflow: hidden;
    border-radius: 10px;
}

.course-image {
    width: 100%;
    border-radius: 10px;
    transform: translateZ(0);
    transition: all 2000ms cubic-bezier(.19, 1, .22, 1) 0ms;
    cursor: pointer;
}

.course-image:hover {
    transform: scale(1.15);
    transition: all 2000ms cubic-bezier(.19, 1, .22, 1) 0ms;
}

.course-title {
    font-size: 18px;
    font-weight: 600;
    color: #1f4b6b;
    cursor: pointer;
}

.course-title:hover {
    transition: all 1000ms cubic-bezier(.19, 1, .22, 1) 0ms;
    color: #ef7918;
}

.course-subtitle {
    font-size: 14px;
    color: #818181;
    font-weight: 300;
}

.course-info {
    padding: 16px;
    color: #1f4b6b;
}

.course-lessons,
.course-duration {
    display: flex;
    align-items: center;
    font-size: 12px;
}

.course-icon {
    margin-right: 8px;
}

.immagine {
    height: inherit;
    background-color: white;
    margin-right: 1rem;
}

.profilo {
    width: 140px;
}

.widget {
    background-color: white;
    border: 1px solid #d1d4d6;
    border-radius: 10px;
}

.top_profile {
    padding: 1rem;
    min-height: 110px;
    background: #ef7918;
    border-top-left-radius: 10px;
    border-top-right-radius: 10px;
}

.img_profile {
    border-radius: 50%;
    position: absolute;
    top: 45px;
    left: 50%;
    transform: translateX(-50%);
    background-color: white;
    border: 5px solid #ffffff;
}

.bottom_profile {
    padding-top: 95px;
}

.profile_data {
    color: #1f4b6b;
}

.strumenti_profile {
    background-color: white;
    border: 1px solid #d1d4d6;
    border-radius: 10px;
    margin-top: 2rem;
    color: #1f4b6b;
}

.menu_strumenti {
    color: #1f4b6b;
    font-size: 18px;
}

.menu_strumenti p {
    color: #1f4b6b;
    font-size: 1rem;
    font-weight: 400;
    padding-left: 10px;
    margin-bottom: 0px !important;

}

.menu_strumenti svg,
.menu_strumenti p {
    display: inline-block;
    vertical-align: middle;
}

.btn_strumenti:hover {
    color: #ef7918;
    cursor: pointer;
}

@media only screen and (max-width: 960px) {
    .widget {
        margin-bottom: 2rem;
        /* Aggiunge spazio tra il widget e l'elenco dei corsi */
    }
}
</style>