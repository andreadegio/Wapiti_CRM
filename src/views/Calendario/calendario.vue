<template>
  <div class="pt-3">
    <v-app v-if="addNew">
      <v-dialog
        v-model="addNew"
        fullscreen
        hide-overlay
        transition="dialog-bottom-transition"
        scrollable
      >
        <v-card tile>
          <v-toolbar flat dark color="primary">
            <v-btn icon dark @click="addNew = false">
              <v-icon>mdi-close</v-icon>
            </v-btn>
            <v-toolbar-title>Nuovo Appuntamento</v-toolbar-title>
            <v-spacer></v-spacer>
            <v-toolbar-items>
              <v-btn dark text @click="addNew = false"> Salva </v-btn>
            </v-toolbar-items>
          </v-toolbar>
          <v-card-text>
            <newMeeting />
            <v-divider></v-divider>
          </v-card-text>

          <div style="flex: 1 1 auto"></div>
        </v-card>
      </v-dialog>
    </v-app>
    <div v-if="!addNew">
      <div class="display-4 text-center pb-5">Calendario Appuntamenti</div>
      <v-app>
        <v-main>
          <v-container>
            <v-row class="fill-height">
              <v-col>
                <v-sheet height="64">
                  <v-toolbar flat>
                    <v-btn
                      dark
                      class="btn_add"
                      color="blue darken-4"
                      @click="addNew = true"
                    >
                      Nuovo Appuntamento
                    </v-btn>
                    <v-btn
                      outlined
                      class="mr-4"
                      color="grey darken-2"
                      @click="setToday"
                    >
                      Oggi
                    </v-btn>
                    <v-btn fab text small color="grey darken-2" @click="prev">
                      <v-icon small> mdi-chevron-left </v-icon>
                    </v-btn>
                    <v-btn fab text small color="grey darken-2" @click="next">
                      <v-icon small> mdi-chevron-right </v-icon>
                    </v-btn>
                    <v-toolbar-title class="text-capitalize">
                      {{ $refs.calendar ? $refs.calendar.title : meseCorrente }}
                    </v-toolbar-title>
                    <v-spacer> </v-spacer>
                    <v-menu bottom right>
                      <template v-slot:activator="{ on, attrs }">
                        <v-btn
                          outlined
                          color="grey darken-2"
                          v-bind="attrs"
                          v-on="on"
                        >
                          <span>{{ typeToLabel[type] }}</span>
                          <v-icon right> mdi-menu-down </v-icon>
                        </v-btn>
                      </template>
                      <v-list>
                        <v-list-item @click="type = 'day'">
                          <v-list-item-title>Giornaliero</v-list-item-title>
                        </v-list-item>
                        <v-list-item @click="type = 'week'">
                          <v-list-item-title>Settimana</v-list-item-title>
                        </v-list-item>
                        <v-list-item @click="type = 'month'">
                          <v-list-item-title>Mese</v-list-item-title>
                        </v-list-item>
                      </v-list>
                    </v-menu>
                  </v-toolbar>
                </v-sheet>
                <v-sheet height="600">
                  <v-calendar
                    ref="calendar"
                    v-model="focus"
                    color="primary"
                    :events="events"
                    :event-color="getEventColor"
                    :type="type"
                    locale="it"
                    first-time="07:00"
                    :weekdays="weekday"
                    @click:event="showEvent"
                    @click:more="viewDay"
                    @click:date="viewDay"
                  >
                  </v-calendar>
                  <v-menu
                    v-model="selectedOpen"
                    :close-on-content-click="false"
                    :activator="selectedElement"
                    offset-x
                  >
                    <v-card color="grey lighten-4" min-width="350px" flat>
                      <v-toolbar :color="selectedEvent.color" dark>
                        <v-btn icon>
                          <v-icon>mdi-pencil</v-icon>
                        </v-btn>
                        <v-toolbar-title
                          v-html="selectedEvent.name"
                        ></v-toolbar-title>
                        <v-spacer></v-spacer>
                        <v-btn icon>
                          <v-icon>mdi-heart</v-icon>
                        </v-btn>
                        <v-btn icon>
                          <v-icon>mdi-dots-vertical</v-icon>
                        </v-btn>
                      </v-toolbar>
                      <v-card-text>
                        <span v-html="selectedEvent.details"></span>
                        <div>
                          <v-list lines="two">
                            <v-list-subheader>Partecipanti</v-list-subheader>

                            <v-list-item
                              v-for="item in selectedEvent.partecipanti"
                              :key="item.id"
                            >
                              <v-list-item-content>
                                {{ item.nome }}
                                <br />{{ item.stato }}
                              </v-list-item-content>
                            </v-list-item>
                          </v-list>
                        </div>
                      </v-card-text>
                      <v-card-actions>
                        <v-btn
                          text
                          color="secondary"
                          @click="selectedOpen = false"
                        >
                          Chiudi
                        </v-btn>
                      </v-card-actions>
                    </v-card>
                  </v-menu>
                </v-sheet>
              </v-col>
            </v-row>
          </v-container>
        </v-main>
      </v-app>
    </div>
  </div>
</template>

<script>
import newMeeting from "./components/nuovoAppuntamento.vue";

export default {
  name: "Calendar",
  components: {
    newMeeting,
  },
  data: () => ({
    addNew: false, // per triggerare l'apertura del'interfaccia di inserimento
    dialog2: false,
    focus: "",
    meseCorrente: "",
    type: "month",
    typeToLabel: {
      month: "Mese",
      week: "Settimana",
      day: "Giornaliero",
    },
    weekday: [1, 2, 3, 4, 5, 6, 0],
    selectedEvent: {},
    selectedElement: null,
    selectedOpen: false,
    events: [
      {
        name: "Riunione Gas e luce",
        start: "2023-03-24 09:15",
        end: "2023-03-24 10:30",
        color: "green darken-2",
        details: "Riunione con Aby Point Aulla per gas e luce",
        timed: true,
        partecipanti: [
          {
            id: 1,
            nome: "Mario Rossi",
            email: "mario.rossi@example.com",
            UO: "Aby Point Aulla",
            disponibile: true,
            stato: "Confermato",
          },
          {
            id: 2,
            nome: "Paolo Verdi",
            email: "paolo.verdi@example.com",
            UO: "Aby Point La Spezia",
            disponibile: true,
            stato: "In attesa",
          },
        ],
      },
      {
        name: "Presentazione AbyOne",
        start: "2023-02-11 15:45",
        end: "2023-02-11 17:30",
        details: "Riunione per la presentazione di AbyOne",
        color: "blue darken-4",
        timed: false,
      },
      {
        name: "Riunione Aby Next",
        start: "2023-02-22 15:45",
        end: "2023-02-22 17:30",
        details: "Riunione per la presentazione di Aby Next",
        color: "orange darken-3",
        timed: false,
      },
    ],
  }),
  mounted() {
    this.$refs.calendar.checkChange();
    const mesi = [
      "Gennaio",
      "Febbraio",
      "Marzo",
      "Aprile",
      "Maggio",
      "Giugno",
      "Luglio",
      "Agosto",
      "Settembre",
      "Ottobre",
      "Novembre",
      "Dicembre",
    ];
    const dataCorrente = new Date();
    const dataCorrenteMese = dataCorrente.getMonth();
    this.meseCorrente = mesi[dataCorrenteMese];
  },
  methods: {
    viewDay({ date }) {
      this.focus = date;
      this.type = "day";
    },
    getEventColor(event) {
      return event.color;
    },
    setToday() {
      this.focus = "";
    },
    prev() {
      this.$refs.calendar.prev();
    },
    next() {
      this.$refs.calendar.next();
    },
    showEvent({ nativeEvent, event }) {
      const open = () => {
        this.selectedEvent = event;
        this.selectedElement = nativeEvent.target;
        requestAnimationFrame(() =>
          requestAnimationFrame(() => (this.selectedOpen = true))
        );
      };

      if (this.selectedOpen) {
        this.selectedOpen = false;
        requestAnimationFrame(() => requestAnimationFrame(() => open()));
      } else {
        open();
      }
      nativeEvent.stopPropagation();
    },
    // updateRange({ start, end }) {
    //   // const events = [];
    //   // const min = new Date(`${start.date}T00:00:00`);
    //   // const max = new Date(`${end.date}T23:59:59`);
    //   // const days = (max.getTime() - min.getTime()) / 86400000;
    //   // const eventCount = this.rnd(days, days + 20);
    //   // for (let i = 0; i < eventCount; i++) {
    //   //   const allDay = this.rnd(0, 3) === 0;
    //   //   const firstTimestamp = this.rnd(min.getTime(), max.getTime());
    //   //   const first = new Date(firstTimestamp - (firstTimestamp % 900000));
    //   //   const secondTimestamp = this.rnd(2, allDay ? 288 : 8) * 900000;
    //   //   const second = new Date(first.getTime() + secondTimestamp);
    //   //   events.push({
    //   //     name: this.names[this.rnd(0, this.names.length - 1)],
    //   //     start: first,
    //   //     end: second,
    //   //     color: this.colors[this.rnd(0, this.colors.length - 1)],
    //   //     timed: !allDay,
    //   //   });
    //   // }
    //   // this.events = events;
    // },
    // rnd(a, b) {
    //   return Math.floor((b - a + 1) * Math.random()) + a;
    // },
  },
};
</script>
<style scoped>
.btn_add {
  position: absolute;
  left: 50%;
  right: auto;
}
</style>

