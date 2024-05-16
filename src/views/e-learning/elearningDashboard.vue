<template>
    <v-app>
        <v-app-bar app>
            <img class="immagine" src="img/Aby-Accademy_small.png" />
            <h1 style="color: #1f4b6b">Aby Accademy</h1>
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
                    <div class="strumenti_profile pl-5">
                        <div class="menu_strumenti my-2">
                            <i class="fas fa-envelope-open-text"></i>
                            <p> Contatta il Tutor</p><br />
                            <v-divider></v-divider>
                            <i class="fas fa-sign-out-alt"></i>
                            <p>Esci</p><br />
                        </div>
                    </div>
                </v-col>
                <v-col cols="12" md="8">
                    <div class="h3" style="color: #1f4b6b;"> Corsi disponibili</div>
                    <div class="corsi">
                        <v-row class="fill-height">
                            <v-col cols="12" md="3" lg="3" v-for="course in courses" :key="course.id">
                                <div class="course-card">
                                    <div class="card-container">

                                        <v-img :src="course.image" class="course-image" height="200">
                                            <template v-slot:placeholder>
                                                <v-row class="fill-height ma-0" align="center" justify="center">
                                                    <v-progress-circular indeterminate
                                                        color="grey lighten-5"></v-progress-circular>
                                                </v-row>
                                            </template>
                                        </v-img>
                                    </div>
                                    <div class="titoli">
                                        <div class="course-title mt-4">{{ course.title }}</div>
                                        <div class="course-subtitle mt-3">{{ course.instructor }}</div>
                                    </div>
                                    <v-divider></v-divider>
                                    <div class="course-info">
                                        <v-row>
                                            <v-col cols="6">
                                                <div class="course-lessons">
                                                    <i class="fas fa-video"></i> &nbsp; {{ course.lessons }}
                                                    Video
                                                </div>
                                            </v-col>
                                            <v-col cols="6">
                                                <div class="course-duration">
                                                    <i class="fas fa-stopwatch"></i> &nbsp; {{ course.duration.hours
                                                    }} h {{ course.duration.minutes
                                                    }} min
                                                </div>
                                            </v-col>
                                        </v-row>
                                    </div>
                                    <!--                                     
                                    <div>
                                        <v-btn text color="primary">Vai al corso</v-btn>

                                    </div> -->
                                </div>
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
export default {

    data() {
        return {
            benvenuto: "",
            utente: this.$store.state.loggedInUser,
            courses: [
                {
                    id: 1,
                    image: "https://dreamslms-wp.dreamstechnologies.com/wp-content/uploads/2023/01/course-15-4.jpg",
                    title: "Corso di Formazione",
                    instructor: "Corso per abilitazione utente",
                    lessons: 4,
                    duration: {
                        hours: 2,
                        minutes: 30
                    },
                    rating: 4,
                    ratingCount: 1
                },
                // Add more courses here
            ]
        };
    },
    created() {
        this.setBenvenuto();
    },
    methods: {
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
        }
    },
    mounted() {

    }
};
</script>

<style scoped>
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

@media only screen and (max-width: 960px) {
    .widget {
        margin-bottom: 2rem;
        /* Aggiunge spazio tra il widget e l'elenco dei corsi */
    }
}
</style>