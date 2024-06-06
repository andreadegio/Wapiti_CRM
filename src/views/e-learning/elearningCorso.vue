<template>
    <v-app>
        <v-app-bar app style="background-color: white;">
            <img class="immagine" src="img/Aby-Academy_small.png" @click="$router.go(-1)" style="cursor: pointer;" />
            <h1 class="text-center" style="color: #1f4b6b">{{ course.corso }}</h1>
        </v-app-bar>
        <v-main>
            <v-row>
                <v-col cols="9">
                    <div v-if="!showQuiz">
                        <v-row v-if="selectedVideo" class="video-container">
                            <div class="video-wrapper">
                                <video id="videoPlayer" :src="selectedVideo.file" width="80%vw"
                                    :controls="selectedVideo.completed" disablePictureInPicture
                                    controlsList="nodownload" @timeupdate="updateProgress">
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
                        <v-row class="ml-3 mt-2" v-if="avanzamento < 100">
                            <v-col cols="12">
                                <h2 class="text-center">{{ quiz.title }}</h2>
                                <v-form @submit.prevent="submitQuiz">
                                    <div v-for="(question, index) in questions" :key="index"
                                        :class="getQuestionClass(question.id)">
                                        <p style="font-weight: bold;">{{ index + 1 }}. {{ question.question_text }}</p>
                                        <v-radio-group v-model="answers[question.id]" :key="question.id">
                                            <v-radio v-for="answer in question.answers" :key="answer.id"
                                                :label="answer.answer_text" :value="answer.id"
                                                :class="getAnswerClass(question.id, answer.id)"></v-radio>
                                        </v-radio-group>
                                    </div>
                                    <v-btn v-if="send_quiz_btn" type="submit" color="primary">Invia il
                                        test</v-btn>
                                </v-form>
                            </v-col>
                        </v-row>
                        <v-row class="ml-3 mt-2 text-center" v-else style="justify-content: center; display: grid;">
                            <h1 class="my-4" style="color: #1f4b6b">Test finale superato</h1><br>
                            <img src="video/academy/graduate.png" style="margin: 0 auto;">
                            <h1 class="text-center my-3" style="color: #1f4b6b">Voto: {{ course.votoQuiz }}</h1><br>
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
                                        Da vedere... </v-chip>
                                </div>
                            </div>
                        </v-list-item>
                        <v-list-item v-if="course.quiz" id="quiz" class="elencoVideo"
                            @click="getQuiz(course.id); showQuiz = true; selectedVideoIndex = null"
                            :class="{ 'selected': showQuiz, 'non-cliccabile': !quiz_btn }">
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
            quiz: [],
            quiz_btn: false,
            questions: [],
            answers: {},
            detailedAnswers: [],
            retry: true,
            send_quiz_btn: true,
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

            if (this.quiz.length == 0 || this.retry) {
                this.retry = false;

                let params = {
                    idCorso: Corso,
                };
                try {
                    const response = await axios.post(this.$custom_json.base_url +
                        this.$custom_json.api_url +
                        this.$custom_json.academy.getQuiz, params);

                    let allQuestions = response.data.questions;
                    this.quiz = response.data.quiz;

                    // Mischio le domande e prendo le prime 10
                    this.questions = this.shuffleArray(allQuestions).slice(0, 10);

                    // Mischio le risposte per ogni domanda
                    this.questions.forEach(question => {
                        question.answers = this.shuffleArray(question.answers);
                    });
                } catch (error) {
                    console.error(error);
                }
            }
        },


        shuffleArray(array) {
            for (let i = array.length - 1; i > 0; i--) {
                const j = Math.floor(Math.random() * (i + 1));
                [array[i], array[j]] = [array[j], array[i]];
            }
            return array;
        },
        allQuestionsAnswered() {
            return this.questions.every(question => this.answers[question.id] !== undefined);
        },
        async submitQuiz() {
            if (!this.allQuestionsAnswered()) {
                alert('Per favore rispondi a tutte le domande prima di inviare il quiz.');
                return;
            }
            let params = {
                quizId: this.quiz.id,
                courseId: this.course.id,
                userId: sessionStorage.getItem('learningUserId'),
                answers: Object.keys(this.answers).map(questionId => ({
                    questionId: parseInt(questionId),
                    answerId: this.answers[questionId]
                }))
            }
            try {
                await axios.post(this.$custom_json.base_url +
                    this.$custom_json.api_url +
                    this.$custom_json.academy.sendAnswers, params).then(response => {
                        const roundedScore = Math.round(response.data.score);
                        if (response.data.passed) {
                            // alert(`Hai superato il quiz rispondendo correttamente al ${roundedScore}% delle domande!`);
                            this.$alert("Hai superato il quiz rispondendo correttamente al " + roundedScore + "% delle domande!", "OK", "success").then(() => {
                                // aggiorno il completamento al 100%
                                this.avanzamento = 100;
                                this.send_quiz_btn = false;
                                this.displayResults(response.data.detailedAnswers);

                                // passo di stato il candidato 
                                this.avanzaCandidato();

                            });

                        } else {
                            this.$alert("Non hai superato il quiz. Hai risposto correttamente solo al " + roundedScore + "% delle domande, per superare il test devi raggiungere il 70% di risposte corrette", "", "error").then(() => {
                                //     alert(`Non hai superato il quiz. Hai risposto correttamente al ${roundedScore}% delle domande.`);
                                this.retry = true;
                                this.questions = [];
                                this.answers = [];
                                this.getQuiz(this.course.id);

                            });
                        }

                    });
            } catch (error) {
                console.error(error);
            }
        },
        displayResults(detailedAnswers) {
            this.detailedAnswers = detailedAnswers;
            this.renderQuiz();
        },
        getQuestionClass(questionId) {

            let answerDetail = undefined;

            for (let i = 0; i < this.detailedAnswers.length; i++) {

                if (this.detailedAnswers[i].questionId == questionId) {
                    answerDetail = this.detailedAnswers[i];
                    break;
                }
            }



            if (answerDetail) {
                return answerDetail.isCorrect ? 'correct' : 'incorrect';
            }
            return '';
        },


        getAnswerClass(questionId, answerId) {
            const answerDetail = this.detailedAnswers.find(detail => detail.questionId == questionId);
            if (answerDetail) {
                if (answerDetail.answerId == answerId) {

                    return answerDetail.isCorrect ? 'correct-answer' : 'incorrect-answer';
                }
                if (answerDetail.selected && answerDetail.answerId != answerId) {

                    return 'incorrect-selected';
                }
            }


            return '';
        },
        renderQuiz() {
            this.$forceUpdate();
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
                        this.$custom_json.academy.updateVideo, params);
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
                            this.quiz_btn = true;
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
                    this.$custom_json.academy.updateVideo, params);
            }
            catch (error) {
                console.log(error);
            }
        },
        calculateProgress() {
            if (this.course.superato) {
                this.avanzamento = 100
            } else {
                const completedVideos = this.video.filter(video => video.completed).length;
                const totalVideos = this.video.length;

                const totalItems = this.course.quiz == 1 ? totalVideos + 1 : totalVideos;
                if (totalItems === 0) {
                    this.avanzamento = 0; // Per evitare divisioni per zero
                }

                this.avanzamento = Math.round((completedVideos / totalItems) * 100);
            }
            return this.avanzamento;
        },
        async avanzaCandidato() {
            let params = {
                contatto: JSON.parse(sessionStorage.getItem("learningUtente")),
                notaFormazione: this.course.corso + " superato con esito positivo",
                utente: {
                    Nominativo: "SysAdmin",
                    idUtente: 14
                },
            };
            try {
                await axios
                    .post(
                        this.$custom_json.base_url +
                        this.$custom_json.api_url +
                        this.$custom_json.crm.completaElearning,
                        params
                    )
                    .then((response) => {
                        var message = response.data.message;
                        switch (response.data.esito) {
                            case "OK":
                                this.$alert(message, "Congratulazioni!", "success");
                                this.$emit("aggiorna_grid", this.step);
                                break;
                            case "KO":
                                this.$alert(message, "Attenzione", "warning");
                                break;
                        }
                    });
            } catch (error) {
                console.log(error);
            }
        },
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
            this.quiz_btn = true;
            const quizElement = document.getElementById('quiz');


            if (quizElement) {
                quizElement.classList.remove('non-cliccabile');
            }
        }
    }
}
</script>
<style scoped>
.correct {
    background-color: lightgreen !important;
}

.incorrect {
    background-color: lightcoral !important;
}

.correct-answer {
    color: green !important;
}

.incorrect-answer {
    color: red !important;
}

.incorrect-selected {
    color: red !important;
}

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
