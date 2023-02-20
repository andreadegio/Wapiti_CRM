<template>
  <div class="pt-3">
    <div class="display-4 text-center pb-5">Calendario Appuntamenti</div>
    <v-app>
      <v-main>
        <v-container>
          <v-row class="fill-height">
            <v-col>
              <v-sheet height="64">
                <v-toolbar flat>
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
                  <v-toolbar-title v-if="$refs.calendar">
                    {{ $refs.calendar.title }}
                  </v-toolbar-title>
                  <v-spacer></v-spacer>
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
                ></v-calendar>
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

    <div class="py-3">Legenda:</div>
  </div>
</template>

<script>
export default {
  data: () => ({
    focus: "",
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
        start: "2023-02-17 09:15",
        end: "2023-02-17 10:30",
        color: "green darken-2",
        details: "Riunione con Aby Point Aulla per gas e luce",
        timed: true,
      },
      {
        name: "Presentazione AbyOne",
        start: "2023-02-11 15:45",
        end: "2023-02-11 17:30",
        details:"Riunione per la presentazione di AbyOne",
        color: "blue darken-4",
        timed: false,
      },
      {
        name: "Riunione Aby Next",
        start: "2023-02-22 15:45",
        end: "2023-02-22 17:30",
        details:"Riunione per la presentazione di Aby Next",
        color: "orange darken-3",
        timed: false,
      },
      // {
      //   name: "Festa",
      //   start: "2023-02-19",
      //   color: "red",
      //   timed: false,
      // },
    ],
    // colors: [
    //   "blue",
    //   "indigo",
    //   "deep-purple",
    //   "cyan",
    //   "green",
    //   "orange",
    //   "grey darken-1",
    // ],
    // names: [
    //   "Meeting",
    //   "Holiday",
    //   "PTO",
    //   "Travel",
    //   "Event",
    //   "Birthday",
    //   "Conference",
    //   "Party",
    // ],
  }),
  mounted() {
    this.$refs.calendar.checkChange();
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

<style>
</style>