<template>
    <v-app>
        <v-app-bar app style="background-color: white;">
            <img class="immagine" src="img/Aby-Accademy_small.png" />
            <h1 class="text-center" style="color: #1f4b6b">{{ course.corso }}</h1>
        </v-app-bar>
        <v-main>
            <v-row>
                <v-col cols="9">
                    <div v-if="!showQuiz">
                        <v-row v-if="selectedVideo" class="video-container">
                            <div class="video-wrapper">
                                <video id="videoPlayer" :src="selectedVideo.file" width="80%vw" :controls="false"
                                    controlsList="nodownload" @timeupdate="updateProgress">
                                    <!-- disablePictureInPicture -->
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
                    </div>
                    <div v-else>
                        <v-row class="ml-3 mt-2">
                            <v-col cols="12">
                                <h2 class="text-center">{{ quiz.title }}</h2>
                                <v-form @submit.prevent="submitQuiz">
                                    <div v-for="(question, index) in questions" :key="index">
                                        <p style="font-weight: bold;">{{ index + 1 }}. {{ question.question_text }}</p>
                                        <v-radio-group v-model="answers[question.id]" :key="question.id">
                                            <v-radio v-for="answer in question.answers" :key="answer.id"
                                                :label="answer.answer_text" :value="answer.id"></v-radio>
                                        </v-radio-group>
                                    </div>
                                    <v-btn type="submit" color="primary">Invia il test</v-btn>
                                </v-form>
                            </v-col>
                        </v-row>
                    </div>

                </v-col>
                <v-col cols="3" id="sidebar-corso">
                    <div>
                        <div>
                            <p class="h3 mb-0">Contenuto del corso</p>
                        </div>
                        <div style="max-width: 100px;"><small>Avanzamento: {{ avanzamento }}% <v-progress-linear
                                    :value="calculateProgress()"></v-progress-linear></small>
                        </div>
                    </div>
                    <v-list>
                        <v-list-item v-for="(video, index) in video" :key="index"
                            @click="selectVideo(video, index); showQuiz = false;"
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
                        <v-list-item v-if="course.quiz" id="quiz" class="elencoVideo"
                            @click="getQuiz(course.id); showQuiz = true; selectedVideoIndex = null"
                            :class="{ 'selected': showQuiz, 'non-cliccabile': !quiz }">
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
import axios from 'axios';
export default {
    name: 'VideoFormazione',
    data() {
        return {
            isPlaying: false,
            selectedVideo: null,
            selectedVideoIndex: null,
            currentTime: '0:00',
            totalTime: '0:00',
            avanzamento: 0,
            video: this.course.video,
            showQuiz: false,
            quiz: false,
            questions: [],
            answers: {}
        }
    },
    props: {
        course: {
            type: Object,
            required: true
        }
    },

    methods: {
        async getQuiz(Corso) {
            // console.log("id corso" + Corso);
            let params = {
                idCorso: Corso,
            };
            try {

                await axios.post(this.$custom_json.base_url +
                    this.$custom_json.api_url +
                    this.$custom_json.accademy.getQuiz, params).then(response => {
                        this.quiz = response.data.quiz;
                        this.questions = response.data.questions;
                    });
            } catch (error) {
                console.error(error);
            }
        },
        async submitQuiz() {
            let params = {
                quizId: this.quiz.id,
                userId: sessionStorage.getItem('learningUserId'),
                answers: Object.keys(this.answers).map(questionId => ({
                    questionId: parseInt(questionId),
                    answerId: this.answers[questionId]
                }))
            }
            try {
                await axios.post(this.$custom_json.base_url +
                    this.$custom_json.api_url +
                    this.$custom_json.accademy.sendAnswers, params).then(response => {

                        alert(`Your score: ${response.data.score}%`);
                    });
            } catch (error) {
                console.error(error);
            }
        },
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
            // Assicurati che il video sia caricato prima di calcolare la percentuale
            if (videoPlayer.duration && isFinite(videoPlayer.duration) && isFinite(videoPlayer.currentTime)) {
                const percentage = Math.floor((100 / videoPlayer.duration) * videoPlayer.currentTime);
                progressBar.value = percentage;
            } else {
                progressBar.value = 0; // Imposta un valore di default se i dati non sono validi
            }

            // Calcolo il tempo corrente del video
            const currentMinutes = Math.floor(videoPlayer.currentTime / 60);
            const currentSeconds = Math.floor(videoPlayer.currentTime % 60);
            // Aggiorno il valore della variabile per visualizzare il tempo corrente
            this.currentTime = `${currentMinutes}:${currentSeconds.toString().padStart(2, '0')}`;
        },
        async saveCurrentTime() {


            if (this.selectedVideo) {
                const videoPlayer = document.getElementById('videoPlayer');
                const currentTime = videoPlayer.currentTime;
                const timeInMinutes = Math.floor(currentTime / 60);
                const timeInSeconds = Math.floor(currentTime % 60);
                const timestampInizio = `${timeInMinutes}:${timeInSeconds}`;
                // Aggiorna o aggiungi il valore timestampInizio nell'oggetto videoResumed
                const index = this.course.video.findIndex(item => item.id === this.selectedVideo.id);
                if (index !== -1) {
                    this.course.video[index].timestampInizio = timestampInizio;
                } else {
                    this.course.video.push({
                        id_video: this.selectedVideo.id,
                        timestampInizio: timestampInizio
                    });
                }
                try {
                    // Salva il tempo corrente del video in riproduzione e sul db
                    let params = {
                        idUser: sessionStorage.getItem('learningUserId'),
                        idVideo: this.selectedVideo.id,
                        idCorso: this.course.id,
                        tipo: "TIME",
                        timestampInizio: timestampInizio,
                    };
                    await axios.post(this.$custom_json.base_url +
                        this.$custom_json.api_url +
                        this.$custom_json.accademy.updateVideo, params);
                }
                catch (error) {
                    // console.log(error);
                }
            }

        },
        async endedVideo() {
            // Salva il completamento del video in corso
            if (this.selectedVideo) {
                // Aggiorno il completamento del video e sblocco quello successivo
                const index = this.video.findIndex(item => item.id === this.selectedVideo.id);
                if (index !== -1) {
                    this.video[index].completed = true;
                    if (index + 1 < this.video.length) {
                        this.video[index + 1].active = true;
                    } else {
                        // console.log("Questo è l'ultimo video della lista.");
                        // ABILITO IL QUIZ
                        this.quiz = true;

                        this.$alert("Hai completato tutti i video del corso di formazione, adesso puoi eseguire il quiz finale", "OK", "success");
                        const quizElement = document.getElementById('quiz');
                        if (quizElement) {
                            quizElement.classList.remove('non-cliccabile');


                        }
                    }
                } else {
                    // console.log("video non trovato");
                }
            }
            try {
                // Salva il tempo corrente del video in riproduzione e sul db
                let params = {
                    idUser: sessionStorage.getItem('learningUserId'),
                    idVideo: this.selectedVideo.id,
                    idCorso: this.course.id,
                    tipo: "COMPLETED",
                };
                await axios.post(this.$custom_json.base_url +
                    this.$custom_json.api_url +
                    this.$custom_json.accademy.updateVideo, params);
            }
            catch (error) {
                console.log(error);
            }
        },
        calculateProgress() {
            const completedVideos = this.video.filter(video => video.completed).length;
            const totalVideos = this.video.length;

            const totalItems = this.course.quiz == 1 ? totalVideos + 1 : totalVideos;
            if (totalItems === 0) {
                this.avanzamento = 0; // Per evitare divisioni per zero
            }
            // console.log("completati " + completedVideos + " totali " + this.video.length);
            // if (completedVideos === this.video.length) {
            //     this.quiz = true;

            //     this.$alert("Hai completato tutti i video del corso di formazione, adesso puoi eseguire il quiz finale", "OK", "success");
            //     const quizElement = document.getElementById('quiz');


            //     if (quizElement) {
            //         quizElement.classList.remove('non-cliccabile');
            //     }
            // }

            this.avanzamento = Math.round((completedVideos / totalItems) * 100);
            return this.avanzamento;
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
                        // console.log("video " + this.selectedVideo.titolo + " avviato");
                    });
                    videoPlayer.addEventListener('pause', () => {
                        // Traccia la pausa del video
                        // console.log("video in pausa");
                        this.saveCurrentTime();
                    });
                    videoPlayer.addEventListener('ended', () => {
                        // Traccia la fine della riproduzione del video
                        // console.log("fine del video");
                        this.endedVideo();

                    });
                    videoPlayer.onloadedmetadata = () => {
                        // Calcolo la durata totale del video
                        const totalMinutes = Math.floor(videoPlayer.duration / 60);
                        const totalSeconds = Math.floor(videoPlayer.duration % 60);
                        // Aggiorno il valore della variabile per visualizzare la durata totale
                        this.totalTime = `${totalMinutes}:${totalSeconds.toString().padStart(2, '0')}`;
                    };


                    // Controlla se l'ID del video è presente in videoResumed
                    const resumedVideo = this.selectedVideo;

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
        const completedVideos = this.video.filter(video => video.completed).length;
        if (completedVideos === this.video.length) {
            this.quiz = true;
            const quizElement = document.getElementById('quiz');


            if (quizElement) {
                quizElement.classList.remove('non-cliccabile');
            }
        }
    }
}
</script>
<style scoped>
.immagine {
    height: inherit;
    background-color: white;
    margin-right: 1rem;
}

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
    opacity: 0.5;
    pointer-events: none;

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
