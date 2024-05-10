<template>
    <v-app>
        <v-app-bar app>
            <h1 class="text-center">Corso di formazione per la piattaforma Abyway</h1>
        </v-app-bar>
        <v-main>
            <v-row>
                <v-col cols="9">
                    <v-row v-if="selectedVideo" class="video-container">
                        <div class="video-wrapper">
                            <video id="videoPlayer" :src="selectedVideo.file" width="80%vw" controlsList="nodownload"
                                @timeupdate="updateProgress">
                                <source :src="selectedVideo.file" type="video/mp4">
                                Il tuo browser non supporta il tag video.
                            </video>
                            <progress id="progressBar" max="100" style="width: 80%" value="0"></progress>
                            <div class="video-time">{{ currentTime }} / {{ totalTime }}</div>
                        </div>
                        <div class="controls-wrapper">
                            <div class="controls">
                                <v-btn @click="rewindVideo" fab dark large color="warning">
                                    <v-icon>mdi-rewind</v-icon>
                                </v-btn>
                                <v-btn @click="playPauseVideo" class="mx-2" fab dark large color="warning">
                                    <v-icon>{{ isPlaying ? 'mdi-pause' : 'mdi-play' }}</v-icon>
                                </v-btn>
                            </div>
                        </div>
                    </v-row>

                    <v-row v-else
                        style="min-height: 400px; background-color: #474747; display: flex; align-items: center; justify-content: center;  padding: 1rem; ">
                        <div>
                            <p class="h3" style="color: white; justify-content: center;">Seleziona un video</p>
                        </div>
                        <div>
                            <video id="videoPlayer" width="80%vw" controlsList="nodownload">
                            </video>
                        </div>
                    </v-row>
                    <v-row style="padding: 1rem;">
                        <div>
                            <p class="h3">Descrizione</p>
                            <p v-if="selectedVideo">{{ selectedVideo.descrizione }}</p>
                        </div>
                    </v-row>
                </v-col>
                <v-col cols="3" id="sidebar-corso">
                    <div>
                        <div>
                            <p class="h3 mb-0">Contenuto del corso</p>
                        </div>
                        <div style="max-width: 100px;"><small>Avanzamento: 50% <v-progress-linear
                                    value="50"></v-progress-linear></small></div>
                    </div>
                    <v-list>
                        <v-list-item v-for="(video, index) in video" :key="index" @click="selectVideo(video, index)"
                            :class="{ 'selected': index === selectedVideoIndex, 'non-cliccabile': !video.active }"
                            class="elencoVideo">
                            <div>
                                <div class="h5">
                                    {{ index + 1 }}. &nbsp; {{ video.titolo }}
                                </div>
                                <div>
                                    <i class="far fa-play-circle"></i> &nbsp;durata: {{ video.durata }}
                                    <v-chip v-if="video.completed" class="ma-2" small color="green" text-color="white">
                                        Completato </v-chip>
                                    <v-chip v-if="video.active && !video.completed" class="ma-2" small color="orange"
                                        text-color="white">
                                        In corso... </v-chip>
                                </div>
                            </div>
                        </v-list-item>
                        <v-list-item class="elencoVideo non-cliccabile">
                            <div>
                                <div class="h5">
                                    Quiz Finale
                                </div>
                                <div>
                                    <i class="fas fa-user-graduate"></i> &nbsp;Quiz di fine corso

                                </div>
                            </div>
                        </v-list-item>
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
            isPlaying: false,
            selectedVideo: null,
            selectedVideoIndex: null,
            currentTime: '0:00',
            totalTime: '0:00',
            video: [{
                id: 1,
                titolo: "Dashboard Abyway",
                descrizione: "Video formativo per l'uso della dashboard di Abyway.",
                durata: "9'36\"",
                file: "video/accademy/dashboard.mp4",
                active: true,
                completed: true,
            },
            {
                id: 2,
                titolo: "Simulazione su veicolo",
                descrizione: "Video formativo per effettuare simulazioni.",
                durata: "3'04\"",
                file: "video/accademy/Simulazione su nuovo veicolo.mp4",
                active: true,
                completed: false,
            },
            {
                id: 3,
                titolo: "Stampe contratti e certificati",
                descrizione: "Video formativo per la stampa contratti e certificati.",
                durata: "15'44\"",
                file: "video/accademy/Stampa copia contratto e certificato.mp4",
                active: false,
                completed: false,
            },
            {
                id: 4,
                titolo: "Acquisto",
                descrizione: "Video formativo per l'acquisto di un preventivo.",
                durata: "22'39\"",
                file: "video/accademy/Acquisto.mp4",
                active: false,
                completed: false
            }
            ],
            videoResumed: [{
                id_video: 2,
                timestampInizio: '00:30',

            }],
        }
    },
    methods: {
        selectVideo(video, index) {
            this.selectedVideoIndex = index;
            this.selectedVideo = video;
            this.isPlaying = false;
            this.currentTime = '0:00';

        },
        playPauseVideo() {
            const videoPlayer = document.getElementById('videoPlayer');
            if (this.isPlaying) {
                videoPlayer.pause();
            } else {
                videoPlayer.play();
            }
            this.isPlaying = !this.isPlaying;
        },
        rewindVideo() {
            const videoPlayer = document.getElementById('videoPlayer');
            videoPlayer.currentTime -= 5; // Andare indietro di 5 secondi
        },
        updateProgress() {
            const videoPlayer = document.getElementById('videoPlayer');
            const progressBar = document.getElementById('progressBar');
            const percentage = Math.floor((100 / videoPlayer.duration) * videoPlayer.currentTime);
            progressBar.value = percentage;
            // Calcolo il tempo corrente del video
            const currentMinutes = Math.floor(videoPlayer.currentTime / 60);
            const currentSeconds = Math.floor(videoPlayer.currentTime % 60);
            // Aggiorno il valore della variabile per visualizzare il tempo corrente
            this.currentTime = `${currentMinutes}:${currentSeconds.toString().padStart(2, '0')}`;
        }

    },
    watch: {
        selectedVideo() {
            this.isPlaying = false;
            // Aspetta che l'elemento video sia stato montato nel DOM prima di aggiungere gli event listener
            this.$nextTick(() => {
                if (this.selectedVideo) {
                    const videoPlayer = document.getElementById('videoPlayer');
                    videoPlayer.addEventListener('play', () => {
                        // Traccia l'inizio della riproduzione del video
                        console.log("video " + this.selectedVideo.titolo + " avviato");
                    });
                    videoPlayer.addEventListener('pause', () => {
                        // Traccia la pausa del video
                        console.log("video in pausa");
                    });
                    videoPlayer.addEventListener('ended', () => {
                        // Traccia la fine della riproduzione del video
                        console.log("fine del video");
                    });
                    videoPlayer.onloadedmetadata = () => {
                        // Calcolo la durata totale del video
                        const totalMinutes = Math.floor(videoPlayer.duration / 60);
                        const totalSeconds = Math.floor(videoPlayer.duration % 60);
                        // Aggiorno il valore della variabile per visualizzare la durata totale
                        this.totalTime = `${totalMinutes}:${totalSeconds.toString().padStart(2, '0')}`;
                    };


                    // Controlla se l'ID del video è presente in videoResumed
                    const resumedVideo = this.videoResumed.find(item => item.id_video === this.selectedVideo.id);
                    if (resumedVideo) {
                        const videoPlayer = document.getElementById('videoPlayer');
                        const timeParts = resumedVideo.timestampInizio.split(':');
                        const seconds = (+timeParts[0]) * 60 + (+timeParts[1]); // Converti in secondi
                        videoPlayer.currentTime = seconds;
                    }

                }
            });
        }
    },
    mounted() {



    }
}
</script>
<style scoped>
#sidebar-corso {
    background-color: white;
    padding: 1rem;
    overflow: auto;
    position: fixed;
    height: 100%;
    z-index: 1;
    right: 0;
    box-shadow: -3px 0px 5px #aaaaaa;
}

.elencoVideo {
    border-bottom: 1px solid !important;
    padding: 0.8rem 0 0.8rem 1rem;
}

.selected {
    background-color: lightseagreen
}

.non-cliccabile {
    cursor: not-allowed;
    /* Cambia il cursore del mouse a "non consentito" */
    opacity: 0.5;
    /* Opacità ridotta per indicare che non è interattivo */
    pointer-events: none;
    /* Disabilita gli eventi del mouse */
}

.video-time {
    color: white;
    font-size: 14px;
    margin-top: 0px;
    margin-bottom: 5px;
    text-align: center;
}


.video-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    background-color: #474747;
    padding: 1rem;
}

.video-wrapper {
    text-align: center;
    position: relative;
}

.controls-wrapper {
    display: flex;
    justify-content: center;
    align-items: center;
}

.controls {
    display: flex;
    align-items: center;
}
</style>
