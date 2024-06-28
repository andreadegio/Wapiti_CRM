<template>
    <v-app>
        <v-app-bar app color="white">
            <img class="immagine" src="img/Aby-Academy_small.png" @click="$router.go(-1)" style="cursor: pointer;" />
            <v-spacer></v-spacer>
            <h1 class="text-center course-title" style="color: #1f4b6b; margin: 0;">{{ course.corso }}</h1>
            <v-spacer></v-spacer>
        </v-app-bar>
        <v-main>
            <v-container>
                <v-row>
                    <v-col cols="12" md="9">
                        <div v-if="!showQuiz">
                            <v-row v-if="selectedVideo" class="video-container" justify="center">
                                <v-col cols="12">
                                    <div class="video-wrapper">
                                        <video v-if="userAbyway" id="videoPlayer" :src="selectedVideo.file"
                                            class="video-player" controlsList="nodownload" controls
                                            @timeupdate="updateProgress">
                                            <source :src="selectedVideo.file" type="video/mp4">
                                            Il tuo browser non supporta il tag video.
                                        </video>
                                        <video v-else id="videoPlayer" :src="selectedVideo.file" class="video-player"
                                            :controls="selectedVideo.completed" controlsList="nodownload"
                                            @timeupdate="updateProgress" disablePictureInPicture>
                                            <source :src="selectedVideo.file" type="video/mp4">
                                            Il tuo browser non supporta il tag video.
                                        </video>
                                        <progress id="progressBar" max="100" style="width: 100%" value="0"></progress>
                                        <div class="video-time">{{ currentTime }} / {{ totalTime }}</div>
                                    </div>
                                    <div class="controls-wrapper">
                                        <div class="controls">
                                            <v-btn @click="rewindVideo" fab small dark color="light-blue darken-4">
                                                <v-icon>mdi-rewind</v-icon>
                                            </v-btn>
                                            <v-btn @click="playPauseVideo" class="mx-2" fab dark large color="warning">
                                                <v-icon>{{ isPlaying ? 'mdi-pause' : 'mdi-play' }}</v-icon>
                                            </v-btn>
                                            <v-btn v-if="userAbyway || selectedVideo.completed" @click="forwardVideo"
                                                fab dark small color="light-blue darken-4">
                                                <v-icon>mdi-fast-forward</v-icon>
                                            </v-btn>
                                        </div>
                                    </div>
                                </v-col>
                            </v-row>
                            <v-row v-else class="d-flex align-center justify-center"
                                style="min-height: 400px; background-color: #474747; padding: 1rem;">
                                <div>
                                    <p class="h3 text-center" style="color: white;">Seleziona un video</p>
                                </div>
                            </v-row>
                            <v-row style="padding: 1rem;">
                                <v-tabs color="deep-orange">
                                    <v-tab v-if="$vuetify.breakpoint.mdAndDown">
                                        <v-icon>mdi-video</v-icon> &nbsp;
                                        <span>Contenuto del corso</span>
                                    </v-tab>
                                    <v-tab v-if="selectedVideo">
                                        <v-icon>mdi-book</v-icon> &nbsp;
                                        <span>Descrizione</span>
                                    </v-tab>

                                    <!-- TAB DEI VIDEO -->
                                    <v-tab-item v-if="$vuetify.breakpoint.mdAndDown">
                                        <div>
                                            <div>
                                                <small>Avanzamento: {{ avanzamento }}% <v-progress-linear
                                                        :value="calculateProgress()"></v-progress-linear></small>
                                            </div>
                                        </div>
                                        <v-list v-if="!userAbyway">
                                            <v-list-item v-for="(video, index) in video" :key="index"
                                                @click="selectVideo(video, index); showQuiz = false;"
                                                :class="{ 'selected': index === selectedVideoIndex, 'non-cliccabile': !video.active }"
                                                class="elencoVideo">
                                                <div>
                                                    <div class="h5">
                                                        {{ index + 1 }}. &nbsp; {{ video.titolo }}
                                                    </div>
                                                    <div>
                                                        <i class="far fa-play-circle"></i> &nbsp;durata: {{ video.durata
                                                        }}
                                                        <v-chip v-if="video.completed" class="ma-2" small color="green"
                                                            text-color="white">Completato</v-chip>
                                                        <v-chip v-if="video.active && !video.completed" class="ma-2"
                                                            small color="orange" text-color="white">Da
                                                            vedere...</v-chip>
                                                    </div>
                                                </div>
                                            </v-list-item>
                                            <v-list-item v-if="course.quiz" id="quiz" class="elencoVideo"
                                                @click="getQuiz(course.id); showQuiz = true; scrollToTop(); selectedVideo = null; selectedVideoIndex = null"
                                                :class="{ 'selected': showQuiz, 'non-cliccabile': !quiz_btn }">
                                                <div>
                                                    <div class="h5">Quiz Finale</div>
                                                    <div>
                                                        <i class="fas fa-user-graduate"></i> &nbsp;Quiz di fine corso
                                                    </div>
                                                </div>
                                            </v-list-item>
                                        </v-list>
                                        <v-list v-else>
                                            <v-list-item v-for="(video, index) in video" :key="index"
                                                @click="selectVideo(video, index); showQuiz = false;"
                                                :class="{ 'selected': index === selectedVideoIndex }"
                                                class="elencoVideo">
                                                <div>
                                                    <div class="h5">{{ index + 1 }}. &nbsp; {{ video.titolo }}</div>
                                                    <div>
                                                        <i class="far fa-play-circle"></i> &nbsp;durata: {{ video.durata
                                                        }}
                                                        <v-chip v-if="video.completed" class="ma-2" small color="green"
                                                            text-color="white">Completato</v-chip>
                                                        <v-chip v-if="video.active && !video.completed" class="ma-2"
                                                            small color="orange" text-color="white">Da
                                                            vedere...</v-chip>
                                                    </div>
                                                </div>
                                            </v-list-item>
                                            <v-list-item v-if="course.quiz" id="quiz" class="elencoVideo"
                                                @click="getQuiz(course.id); showQuiz = true; scrollToTop(); selectedVideo = null; selectedVideoIndex = null"
                                                :class="{ 'selected': showQuiz }">
                                                <div>
                                                    <div class="h5">Quiz Finale</div>
                                                    <div>
                                                        <i class="fas fa-user-graduate"></i> &nbsp;Quiz di fine corso
                                                    </div>
                                                </div>
                                            </v-list-item>
                                        </v-list>
                                    </v-tab-item>
                                    <!-- TAB DESCRIZIONE -->
                                    <v-tab-item>
                                        <div class="mt-3 ml-2 " v-if="selectedVideo">{{ selectedVideo.descrizione }}
                                        </div>
                                    </v-tab-item>

                                </v-tabs>
                                <!-- <v-col cols="12" id="descrizione" v-if="selectedVideo">
                                    <p class="h3">Descrizione</p>
                                    <p v-if="selectedVideo">{{ selectedVideo.descrizione }}</p>
                                </v-col> -->
                            </v-row>
                        </div>
                        <div v-else>
                            <v-row class="ml-3 mt-2" v-if="avanzamento < 100">
                                <v-col cols="12">
                                    <h2 class="text-center">{{ quiz.title }}</h2>
                                    <v-form @submit.prevent="submitQuiz">
                                        <div v-for="(question, index) in questions" :key="index"
                                            :class="getQuestionClass(question.id)">
                                            <p style="font-weight: bold;">{{ index + 1 }}. {{ question.question_text }}
                                            </p>
                                            <v-radio-group v-model="answers[question.id]" :key="question.id">
                                                <v-radio v-for="answer in question.answers" :key="answer.id"
                                                    :label="answer.answer_text" :value="answer.id"
                                                    :class="getAnswerClass(question.id, answer.id)"></v-radio>
                                            </v-radio-group>
                                        </div>
                                        <v-btn v-if="send_quiz_btn" type="submit" color="primary">Invia il test</v-btn>
                                    </v-form>
                                    <v-btn v-if="continua_btn" type="submit" color="primary"
                                        @click="continua_btn_click()">Prosegui</v-btn>
                                </v-col>
                            </v-row>
                            <v-row class="ml-3 mt-2 text-center" v-else style="justify-content: center; display: grid;">
                                <div ref="resultContent" :class="{ 'no-animations': disableAnimations }">
                                    <h1 class="my-4 animate__animated animate__wobble animate__delay-500ms"
                                        style="color: #1f4b6b">Test finale superato</h1><br>
                                    <img class="animate__animated animate__zoomIn" src="video/academy/graduate.png"
                                        style="margin: 0 auto;">
                                    <div class="mt-2 animate__animated animate__pulse animate__infinite">
                                        <h1 class="text-center my-3 " style="color: #1f4b6b">Voto: {{ course.votoQuiz }}
                                        </h1>
                                    </div><br>
                                </div>
                                <v-btn v-if="userAbyway" @click="captureAndShare" color="#1f4b6b" class="mt-4"
                                    style="color: white;">Condividi il tuo risultato! <v-icon right dark>
                                        mdi-share-variant
                                    </v-icon></v-btn>
                                <a ref="downloadLink" style="display: none;">Scarica immagine</a>
                                <v-btn v-if="userAbyway" class="mt-3" color="warning"
                                    @click="course.superato = 0">Ripeti il quiz!</v-btn>
                            </v-row>
                            <v-row style="padding: 1rem;">
                                <v-tabs color="deep-orange">
                                    <v-tab v-if="$vuetify.breakpoint.mdAndDown">
                                        <v-icon>mdi-video</v-icon> &nbsp;
                                        <span>Contenuto del corso</span>
                                    </v-tab>
                                    <v-tab v-if="selectedVideo">
                                        <v-icon>mdi-book</v-icon> &nbsp;
                                        <span>Descrizione</span>
                                    </v-tab>

                                    <!-- TAB DEI VIDEO -->
                                    <v-tab-item v-if="$vuetify.breakpoint.mdAndDown">
                                        <div>
                                            <div>
                                                <small>Avanzamento: {{ avanzamento }}% <v-progress-linear
                                                        :value="calculateProgress()"></v-progress-linear></small>
                                            </div>
                                        </div>
                                        <v-list v-if="!userAbyway">
                                            <v-list-item v-for="(video, index) in video" :key="index"
                                                @click="selectVideo(video, index); showQuiz = false;"
                                                :class="{ 'selected': index === selectedVideoIndex, 'non-cliccabile': !video.active }"
                                                class="elencoVideo">
                                                <div>
                                                    <div class="h5">
                                                        {{ index + 1 }}. &nbsp; {{ video.titolo }}
                                                    </div>
                                                    <div>
                                                        <i class="far fa-play-circle"></i> &nbsp;durata: {{ video.durata
                                                        }}
                                                        <v-chip v-if="video.completed" class="ma-2" small color="green"
                                                            text-color="white">Completato</v-chip>
                                                        <v-chip v-if="video.active && !video.completed" class="ma-2"
                                                            small color="orange" text-color="white">Da
                                                            vedere...</v-chip>
                                                    </div>
                                                </div>
                                            </v-list-item>
                                            <v-list-item v-if="course.quiz" id="quiz" class="elencoVideo"
                                                @click="getQuiz(course.id); showQuiz = true; scrollToTop(); selectedVideo = null; selectedVideoIndex = null"
                                                :class="{ 'selected': showQuiz, 'non-cliccabile': !quiz_btn }">
                                                <div>
                                                    <div class="h5">Quiz Finale</div>
                                                    <div>
                                                        <i class="fas fa-user-graduate"></i> &nbsp;Quiz di fine corso
                                                    </div>
                                                </div>
                                            </v-list-item>
                                        </v-list>
                                        <v-list v-else>
                                            <v-list-item v-for="(video, index) in video" :key="index"
                                                @click="selectVideo(video, index); showQuiz = false;"
                                                :class="{ 'selected': index === selectedVideoIndex }"
                                                class="elencoVideo">
                                                <div>
                                                    <div class="h5">{{ index + 1 }}. &nbsp; {{ video.titolo }}</div>
                                                    <div>
                                                        <i class="far fa-play-circle"></i> &nbsp;durata: {{ video.durata
                                                        }}
                                                        <v-chip v-if="video.completed" class="ma-2" small color="green"
                                                            text-color="white">Completato</v-chip>
                                                        <v-chip v-if="video.active && !video.completed" class="ma-2"
                                                            small color="orange" text-color="white">Da
                                                            vedere...</v-chip>
                                                    </div>
                                                </div>
                                            </v-list-item>
                                            <v-list-item v-if="course.quiz" id="quiz" class="elencoVideo"
                                                @click="getQuiz(course.id); scrollToTop(); showQuiz = true; selectedVideo = null; selectedVideoIndex = null"
                                                :class="{ 'selected': showQuiz }">
                                                <div>
                                                    <div class="h5">Quiz Finale</div>
                                                    <div>
                                                        <i class="fas fa-user-graduate"></i> &nbsp;Quiz di fine corso
                                                    </div>
                                                </div>
                                            </v-list-item>
                                        </v-list>
                                    </v-tab-item>
                                    <!-- TAB DESCRIZIONE -->
                                    <v-tab-item>
                                        <div class="mt-3 ml-2 " v-if="selectedVideo">{{ selectedVideo.descrizione }}
                                        </div>
                                    </v-tab-item>

                                </v-tabs>
                            </v-row>
                        </div>
                    </v-col>
                    <v-col v-if="!$vuetify.breakpoint.mdAndDown" cols="12" md="3" id="sidebar-corso">
                        <div>
                            <p class="h3 mb-0">Contenuto del corso</p>
                            <div>
                                <small>Avanzamento: {{ avanzamento }}% <v-progress-linear
                                        :value="calculateProgress()"></v-progress-linear></small>
                            </div>
                        </div>
                        <v-list v-if="!userAbyway">
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
                                        <v-chip v-if="video.completed" class="ma-2" small color="green"
                                            text-color="white">Completato</v-chip>
                                        <v-chip v-if="video.active && !video.completed" class="ma-2" small
                                            color="orange" text-color="white">Da vedere...</v-chip>
                                    </div>
                                </div>
                            </v-list-item>
                            <v-list-item v-if="course.quiz" id="quiz" class="elencoVideo"
                                @click="getQuiz(course.id); showQuiz = true; scrollToTop(); selectedVideoIndex = null"
                                :class="{ 'selected': showQuiz, 'non-cliccabile': !quiz_btn }">
                                <div>
                                    <div class="h5">Quiz Finale</div>
                                    <div>
                                        <i class="fas fa-user-graduate"></i> &nbsp;Quiz di fine corso
                                    </div>
                                </div>
                            </v-list-item>
                        </v-list>
                        <v-list v-else>
                            <v-list-item v-for="(video, index) in video" :key="index"
                                @click="selectVideo(video, index); showQuiz = false;"
                                :class="{ 'selected': index === selectedVideoIndex }" class="elencoVideo">
                                <div>
                                    <div class="h5">{{ index + 1 }}. &nbsp; {{ video.titolo }}</div>
                                    <div>
                                        <i class="far fa-play-circle"></i> &nbsp;durata: {{ video.durata }}
                                        <v-chip v-if="video.completed" class="ma-2" small color="green"
                                            text-color="white">Completato</v-chip>
                                        <v-chip v-if="video.active && !video.completed" class="ma-2" small
                                            color="orange" text-color="white">Da vedere...</v-chip>
                                    </div>
                                </div>
                            </v-list-item>
                            <v-list-item v-if="course.quiz" id="quiz" class="elencoVideo"
                                @click="getQuiz(course.id); showQuiz = true; scrollToTop(); selectedVideo = null; selectedVideoIndex = null"
                                :class="{ 'selected': showQuiz }">
                                <div>
                                    <div class="h5">Quiz Finale</div>
                                    <div>
                                        <i class="fas fa-user-graduate"></i> &nbsp;Quiz di fine corso
                                    </div>
                                </div>
                            </v-list-item>
                        </v-list>
                    </v-col>
                </v-row>
            </v-container>
        </v-main>
    </v-app>
</template>

<script>
import "animate.css";
import html2canvas from 'html2canvas';
import axios from 'axios';
export default {
    name: 'VideoFormazione',
    data() {
        return {
            disableAnimations: false,
            isPlaying: false,
            selectedVideo: null,
            selectedVideoIndex: null,
            currentTime: '0:00',
            totalTime: '0:00',
            avanzamento: 0,
            video: this.corso_scelto.video,
            showQuiz: false,
            quiz: [],
            quiz_btn: false,
            questions: [],
            answers: {},
            detailedAnswers: [],
            retry: true,
            send_quiz_btn: true,
            userAbyway: sessionStorage.getItem("AbywayLearning"),
            continua_btn: false,
            courses: [],
            course: this.corso_scelto,
        }
    },
    props: {
        corso_scelto: {
            type: Object,
            required: true
        }
    },
    created() {
        this.$on('quiz-completed', this.handleQuizCompletion);
    },
    methods: {
        async handleQuizCompletion(courseId) {
            // Recupera le informazioni sui corsi
            await this.fetchCourses();

            // Recupera le informazioni dell'utente
            await this.fetchUserInfo();

            // Recupera l'avanamento del corso;
            await this.fetchAvanzamento();
            // Logica per gestire il completamento del quiz
            const updatedCourse = this.courses.find(c => c.id === courseId);
            if (updatedCourse) {
                this.course = { ...updatedCourse };
            }
        },
        async fetchCourses() {
            if (sessionStorage.getItem("AbywayLearning")) {
                // Accedo da abyway
                this.utente = sessionStorage.getItem("Nominativo");
                // console.log("provengo da Abywyay");
                let params = {
                    id: sessionStorage.getItem('learningUserId'),
                    abywayLearning: sessionStorage.getItem("AbywayLearning"),
                    utente: localStorage.getItem("chisono_data")
                };
                try {
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

            }
            else {
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
            }
        },
        async fetchUserInfo() {
            try {
                // Recupera l'ID dell'utente dal sessionStorage
                const userId = sessionStorage.getItem('learningUserId');
                // Effettua la chiamata al backend per recuperare le informazioni dell'utente
                if (sessionStorage.getItem("AbywayLearning")) {
                    // Accedo da abyway
                    this.utente = sessionStorage.getItem("Nominativo");
                } else {
                    await axios.post(this.$custom_json.base_url
                        + this.$custom_json.api_url +
                        this.$custom_json.academy.getUserInfoById,
                        { id: userId })
                        .then(response => {
                            // Assegna i dati ricevuti dalla chiamata alla variabile user
                            sessionStorage.setItem('learningUtente', JSON.stringify(response.data.utente));
                            response.data.utente[0].pf_pg == "PF" ? this.utente = response.data.utente[0].nome + " " + response.data.utente[0].cognome : this.utente = response.data.utente[0].rag_soc;
                        })
                }

            } catch (error) {
                // Gestisci gli errori, ad esempio mostrando un messaggio all'utente
                console.error('Errore durante il recupero delle informazioni dell\'utente:', error);
            }
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
        continua_btn_click() {
            // emit per aggiornare il corso
            this.$emit('quiz-completed', this.course.id);
        },
        async captureAndShare() {
            this.disableAnimations = true;
            await this.$nextTick(); // Assicurarsi che le modifiche al DOM siano completate

            const resultContent = this.$refs.resultContent;
            const canvas = await html2canvas(resultContent);

            this.disableAnimations = false;

            canvas.toBlob(blob => {
                const file = new File([blob], 'result.png', { type: 'image/png' });
                const dataTransfer = new DataTransfer();
                dataTransfer.items.add(file);

                const shareData = {
                    files: dataTransfer.files,
                    title: 'Ho superato il ' + this.course.corso + '!',
                    text: `Ho ottenuto un voto di ${this.course.votoQuiz} nel test finale. Condividi anche tu il tuo risultato!`
                };

                if (navigator.canShare && navigator.canShare(shareData)) {
                    navigator.share(shareData).catch(error => {
                        console.error('Sharing failed', error);
                        this.downloadImage(blob);
                    });
                } else {
                    this.downloadImage(blob);
                }
            });
        },
        downloadImage(blob) {
            const url = URL.createObjectURL(blob);
            const downloadLink = this.$refs.downloadLink;
            downloadLink.href = url;
            downloadLink.download = 'result.png';
            downloadLink.style.display = 'block';
            downloadLink.click();
            downloadLink.style.display = 'none';
            URL.revokeObjectURL(url);
        },

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
                abywayLearning: this.userAbyway,
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

                                this.continua_btn = true;



                                // passo di stato il candidato 
                                if (!this.userAbyway) {
                                    this.avanzaCandidato();
                                }


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
            // Scroll alla parte superiore della pagina
            this.scrollToTop();

        },
        scrollToTop() {
            window.scrollTo({
                top: 0,
                behavior: 'smooth' // Scroll smooth, opzionale
            });
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
        forwardVideo() {
            const videoPlayer = document.getElementById('videoPlayer');
            videoPlayer.currentTime += 5; // Andare avanti di 5 secondi
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
                    // Salva il tempo corrente del video in riproduzione sul db
                    let params = {
                        idUser: sessionStorage.getItem('learningUserId'),
                        idVideo: this.selectedVideo.id,
                        idCorso: this.course.id,
                        tipo: "TIME",
                        timestampInizio: timestampInizio,
                        abywayLearning: this.userAbyway,
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
                        if (!this.userAbyway) {
                            this.$alert("Hai completato tutti i video del corso di formazione, adesso puoi eseguire il quiz finale", "OK", "success");
                        } else {
                            this.$alert("Hai visualizzato tutti i video del corso", "OK", "success");
                        }

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
                    abywayLearning: this.userAbyway,
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
                                // this.$emit("aggiorna_grid", this.step);
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

/* 
#sidebar-corso {
    background-color: white;
    padding: 1rem;
    overflow: auto;
    position: fixed;
    height: 100%;
    z-index: 1;
    right: 0;
    box-shadow: -3px 0px 5px #aaaaaa;
} */

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
    width: 100%;
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

.no-animations * {
    animation: none !important;
    transition: none !important;
}

.video-player {
    width: 100%;
}

.course-title {
    font-size: 3vw;

    max-width: 100%;

}

@media (max-width: 600px) {
    .video-wrapper {
        width: 100%;
    }

    .video-player {
        width: 100%;
    }

    .controls-wrapper {
        display: flex;
        justify-content: center;
        width: 100%;
    }

    .controls {
        display: flex;
        justify-content: space-around;
        width: 100%;
    }
}
</style>
