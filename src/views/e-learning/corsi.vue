<template>
    <v-app>
        <v-app-bar app>
            <h1 class="text-center">Corso</h1>
        </v-app-bar>
        <v-main>
            <v-row>
                <v-col cols="9" style="background-color: blue; height: 100%;">
                    <v-row style="background-color: red; display: flex;  padding: 1rem;">
                        Video
                        <video id="videoPlayer" controls disabled>
                            <source src="video/accademy/dashboard.mp4" type="video/mp4">
                            Il tuo browser non supporta il tag video.
                        </video>
                    </v-row>
                    <v-row style="background-color: green;  padding: 1rem;">
                        Descrizione
                    </v-row>
                </v-col>
                <v-col cols="3" id="sidebar-corso">
                    Elenco
                </v-col>
            </v-row>
        </v-main>
    </v-app>
</template>
<script>
export default {
    name: 'MainLayout',
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
    background-color: brown;
    padding: 1rem;
    overflow: auto;
    position: fixed;
    height: 100%;
    z-index: 1;
    right: 0;
}
</style>
