<template>
    <v-app>
        <v-app-bar app>
            <h1 class="text-center">Corso di formazione per la piattaforma Abyway</h1>
        </v-app-bar>
        <v-main>
            <v-row>
                <v-col cols="9" style="height: 100%;">
                    <v-row
                        style="background-color: #474747; display: flex; align-items: center; justify-content: center;  padding: 1rem; ">

                        <video id="videoPlayer" controls disabled width="80%vw">
                            <source src="video/accademy/dashboard.mp4" type="video/mp4">
                            Il tuo browser non supporta il tag video.
                        </video>
                    </v-row>
                    <v-row style="padding: 1rem;">
                        <p class="h2">Descrizione</p>
                        <p>Lorem ipsum dolor sit, amet consectetur adipisicing elit. Magni illo exercitationem
                            repudiandae sunt natus soluta cupiditate doloremque dolor quasi? Nam perferendis, maxime
                            quas facilis illum repudiandae velit temporibus doloribus molestias!</p>

                    </v-row>
                </v-col>
                <v-col cols="3" id="sidebar-corso">
                    <p class="h2">Contenuto del corso</p>
                    <v-list>
                        <v-list-item v-for="(corso, index) in video" :key="index">
                            <i class="far fa-play-circle"></i> &nbsp;{{ index + 1 }}. &nbsp; {{ corso.titolo }}

                        </v-list-item>
                        <v-divider></v-divider>
                    </v-list>
                </v-col>
            </v-row>
        </v-main>
    </v-app>
</template>
<script>
export default {
    name: 'VideoFormazione',
    data() {
        return {
            video: [{
                id: 1,
                titolo: "Dashboard Abyway",
                descrizione: "Video introduttivo alla dashboard di Abyway.",
                durata: "9'36\"",
                file: "video/accademy/dashboard.mp4",
            },
            {
                id: 2,
                titolo: "Area Statistiche",
                descrizione: "Video introduttivo alle statistiche.",
                durata: "3'04\"",
                file: "video/accademy/dashboard.mp4",
            }
            ],
        }
    },
    mounted() {
        const videoPlayer = document.getElementById('videoPlayer');

        videoPlayer.addEventListener('play', () => {
            // Traccia l'inizio della riproduzione del video
            console.log("video avviato");
        });

        videoPlayer.addEventListener('pause', () => {
            // Traccia la pausa del video
            console.log("video in pausa");
        });

        videoPlayer.addEventListener('ended', () => {
            // Traccia la fine della riproduzione del video
            console.log("fine del video");
        });
    }
}
</script>
<style scoped>
#sidebar-corso {
    /* background-color: brown; */
    padding: 1rem;
    overflow: auto;
    position: fixed;
    height: 100%;
    z-index: 1;
    right: 0;
}
</style>
