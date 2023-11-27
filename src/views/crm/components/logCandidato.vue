<template>
  <v-timeline align-top dense>
    <v-timeline-item
      :color="
        item.action === 'NUOVO INSERIMENTO'
          ? 'green'
          : item.action === 'ELIMINATO'
          ? 'red'
          : getTimelineColor(index)
      "
      small
      v-for="(item, index) in listaLog"
      :key="item.id_log"
    >
      <v-row class="pt-1">
        <v-col cols="3">
          <strong>{{ item.data | formatDate }}</strong>
        </v-col>
        <v-col>
          <strong>{{ item.action }}</strong>
          <div class="text-caption">
            {{ item.desc }}
            <br /><cite style="font-size: 0.6rem; color: #1f4b6b !important">{{
              item.nome_user
            }}</cite>
          </div>
        </v-col>
      </v-row>
    </v-timeline-item>
    <!-- <v-timeline-item color="teal lighten-3" small>
        <v-row class="pt-1">
          <v-col cols="3">
            <strong>3-4pm</strong>
          </v-col>
          <v-col>
            <strong>Design Stand Up</strong>
            <div class="text-caption mb-2">Hangouts</div>
            <v-avatar>
              <v-img
                src="https://avataaars.io/?avatarStyle=Circle&topType=LongHairFrida&accessoriesType=Kurt&hairColor=Red&facialHairType=BeardLight&facialHairColor=BrownDark&clotheType=GraphicShirt&clotheColor=Gray01&graphicType=Skull&eyeType=Wink&eyebrowType=RaisedExcitedNatural&mouthType=Disbelief&skinColor=Brown"
              ></v-img>
            </v-avatar>
            <v-avatar>
              <v-img
                src="https://avataaars.io/?avatarStyle=Circle&topType=ShortHairFrizzle&accessoriesType=Prescription02&hairColor=Black&facialHairType=MoustacheMagnum&facialHairColor=BrownDark&clotheType=BlazerSweater&clotheColor=Black&eyeType=Default&eyebrowType=FlatNatural&mouthType=Default&skinColor=Tanned"
              ></v-img>
            </v-avatar>
            <v-avatar>
              <v-img
                src="https://avataaars.io/?avatarStyle=Circle&topType=LongHairMiaWallace&accessoriesType=Sunglasses&hairColor=BlondeGolden&facialHairType=Blank&clotheType=BlazerSweater&eyeType=Surprised&eyebrowType=RaisedExcited&mouthType=Smile&skinColor=Pale"
              ></v-img>
            </v-avatar>
          </v-col>
        </v-row>
      </v-timeline-item> -->
  </v-timeline>
</template>

<script>
// import axios from "axios";

export default {
  props: {
    candidato: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      listaLog: [
        {
          id_log: 3,
          id_anagrafica: 1,
          id_user: 14,
          nome_user: "ROSSI BRUNO CESARE",
          data: "2023-11-10 17:19:05",
          action: "NUOVO INSERIMENTO",
          desc: "NUOVO INSERIMENTO",
        },
        {
          id_log: 7,
          id_anagrafica: 1,
          id_user: 14,
          nome_user: "ROSSI BRUNO CESARE",
          data: "2023-11-14 10:11:18",
          action: "PASSAGGIO DI STATO",
          desc: "CONTATTO VIA MAIL - Passaggio di stato da 2 a 12 (Contatti Social / Email)",
        },
        {
          id_log: 9,
          id_anagrafica: 1,
          id_user: 14,
          nome_user: "ROSSI BRUNO CESARE",
          data: "2023-11-14 12:04:21",
          action: "PASSAGGIO DI STATO",
          desc: "PRIMO CONTATTO - Passaggio di stato da 1 a 9 (attesa documenti)",
        },
        {
          id_log: 14,
          id_anagrafica: 1,
          id_user: 14,
          nome_user: "ROSSI BRUNO CESARE",
          data: "2023-11-17 15:27:45",
          action: "PASSAGGIO DI STATO",
          desc: "PRIMO CONTATTO - Passaggio di stato da 1 a 9 (attesa documenti)",
        },
        {
          id_log: 15,
          id_anagrafica: 1,
          id_user: 14,
          nome_user: "ROSSI BRUNO CESARE",
          data: "2023-11-17 15:35:14",
          action: "PASSAGGIO DI STATO",
          desc: "PRIMO CONTATTO - Passaggio di stato da 1 a 9 (attesa documenti)",
        },
        {
          id_log: 16,
          id_anagrafica: 1,
          id_user: 14,
          nome_user: "ROSSI BRUNO CESARE",
          data: "2023-11-17 15:40:02",
          action: "PASSAGGIO DI STATO",
          desc: "PRIMO CONTATTO - Passaggio di stato da 1 a 9 (attesa documenti)",
        },
        {
          id_log: 17,
          id_anagrafica: 1,
          id_user: 14,
          nome_user: "ROSSI BRUNO CESARE",
          data: "2023-11-17 15:43:05",
          action: "PASSAGGIO DI STATO",
          desc: "PRIMO CONTATTO - Passaggio di stato da 1 a 9 (attesa documenti)",
        },
        {
          id_log: 18,
          id_anagrafica: 1,
          id_user: 14,
          nome_user: "ROSSI BRUNO CESARE",
          data: "2023-11-17 16:17:02",
          action: "PASSAGGIO DI STATO",
          desc: "PRIMO CONTATTO - Passaggio di stato da 1 a 9 (attesa documenti)",
        },
        {
          id_log: 19,
          id_anagrafica: 1,
          id_user: 14,
          nome_user: "ROSSI BRUNO CESARE",
          data: "2023-11-17 16:26:13",
          action: "PASSAGGIO DI STATO",
          desc: "PRIMO CONTATTO - Passaggio di stato da 1 a 9 (attesa documenti)",
        },
        {
          id_log: 20,
          id_anagrafica: 1,
          id_user: 14,
          nome_user: "ROSSI BRUNO CESARE",
          data: "2023-11-17 17:37:37",
          action: "PASSAGGIO DI STATO",
          desc: "PRIMO CONTATTO - Passaggio di stato da 1 a 9 (attesa documenti)",
        },
        {
          id_log: 21,
          id_anagrafica: 1,
          id_user: 14,
          nome_user: "ROSSI BRUNO CESARE",
          data: "2023-11-17 17:44:01",
          action: "PASSAGGIO DI STATO",
          desc: "PRIMO CONTATTO - Passaggio di stato da 1 a 9 (attesa documenti)",
        },
        {
          id_log: 22,
          id_anagrafica: 1,
          id_user: 14,
          nome_user: "ROSSI BRUNO CESARE",
          data: "2023-11-17 17:44:09",
          action: "PASSAGGIO DI STATO",
          desc: "PRIMO CONTATTO - Passaggio di stato da 1 a 9 (attesa documenti)",
        },
        {
          id_log: 23,
          id_anagrafica: 1,
          id_user: 14,
          nome_user: "ROSSI BRUNO CESARE",
          data: "2023-11-17 17:45:16",
          action: "PASSAGGIO DI STATO",
          desc: "PRIMO CONTATTO - Passaggio di stato da 1 a 9 (attesa documenti)",
        },
        {
          id_log: 24,
          id_anagrafica: 1,
          id_user: 14,
          nome_user: "ROSSI BRUNO CESARE",
          data: "2023-11-17 17:46:02",
          action: "PASSAGGIO DI STATO",
          desc: "PRIMO CONTATTO - Passaggio di stato da 1 a 9 (attesa documenti)",
        },
        {
          id_log: 28,
          id_anagrafica: 1,
          id_user: 14,
          nome_user: "ROSSI BRUNO CESARE",
          data: "2023-11-24 11:55:18",
          action: "RICHIAMA",
          desc: "RICHIAMARE - Passaggio di stato da 1 a 2 (Richiama)",
        },
        {
          id_log: 29,
          id_anagrafica: 1,
          id_user: 14,
          nome_user: "ROSSI BRUNO CESARE",
          data: "2023-11-24 11:58:19",
          action: "RICHIAMA",
          desc: "RICHIAMARE - Passaggio di stato da 1 a 2 (Richiama)",
        },
        {
          id_log: 31,
          id_anagrafica: 1,
          id_user: 14,
          nome_user: "ROSSI BRUNO CESARE",
          data: "2023-11-24 12:01:23",
          action: "RICHIAMA",
          desc: "RICHIAMARE - Passaggio di stato da 1 a 2 (Richiama)",
        },
        {
          id_log: 34,
          id_anagrafica: 1,
          id_user: 14,
          nome_user: "ROSSI BRUNO CESARE",
          data: "2023-11-24 15:28:14",
          action: "ELIMINATO",
          desc: "CANDIDATO ELIMINATO",
        },
      ],
    };
  },
  computed: {
    getTimelineColor() {
      return (index) => (index % 2 === 0 ? "#1f4b6b" : "teal lighten-3");
    },
  },
};
</script>
<style scoped>
.iscrittoRui {
  margin-top: 0px !important;
  padding-top: 0px !important;
}
.disabled_input {
  pointer-events: none;
  opacity: 0.5;
}
.nuova_origine {
  cursor: pointer;
  color: #1976d2;
  display: flex;
  vertical-align: middle;
  top: -1rem;
  position: relative;
  font-size: 1rem;
  font-weight: 500;
  /* border: 1px solid #1976d2; */
  /* border-radius: 5px; */
  padding: 0.5rem;
  padding-bottom: 0.5rem;
  padding-bottom: 0.1rem !important;
  width: fit-content;
}
</style>
