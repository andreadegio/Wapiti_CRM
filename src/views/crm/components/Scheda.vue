<template>
  <div>
    <v-list three-line subheader>
      <v-subheader class="display-1"
        >Candidato {{ candidato.candidate }}
        <v-btn color="warning" fab x-small dark class="ml-2">
          <v-icon>mdi-alarm</v-icon>
        </v-btn>
      </v-subheader>
      <v-list-item>
        <v-list-item-content>
          <v-list-item-title>Provenienza</v-list-item-title>
          <v-list-item-subtitle>{{
            candidato.contact_origin
          }}</v-list-item-subtitle>
        </v-list-item-content>
      </v-list-item>
      <v-list-item>
        <v-list-item-content>
          <v-list-item-title>Tipologia</v-list-item-title>
          <v-list-item-subtitle>{{ candidato.type }}</v-list-item-subtitle>
        </v-list-item-content>
      </v-list-item>
    </v-list>

    <!-- <v-timeline align-top dense>
      <v-timeline-item color="pink" small>
        <v-row class="pt-1">
          <v-col cols="3">
            <strong>5pm</strong>
          </v-col>
          <v-col>
            <strong>New Icon</strong>
            <div class="text-caption">Mobile App</div>
          </v-col>
        </v-row>
      </v-timeline-item>

      <v-timeline-item color="teal lighten-3" small>
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
      </v-timeline-item>

      <v-timeline-item color="pink" small>
        <v-row class="pt-1">
          <v-col cols="3">
            <strong>12pm</strong>
          </v-col>
          <v-col>
            <strong>Lunch break</strong>
          </v-col>
        </v-row>
      </v-timeline-item>

      <v-timeline-item color="teal lighten-3" small>
        <v-row class="pt-1">
          <v-col cols="3">
            <strong>9-11am</strong>
          </v-col>
          <v-col>
            <strong>Finish Home Screen</strong>
            <div class="text-caption">Web App</div>
          </v-col>
        </v-row>
      </v-timeline-item>
    </v-timeline> -->
  </div>
</template>
<script>
export default {
  name: "scheda",
  props: {
    candidato: {
      type: Object,
      required: true,
    },
  },
};
</script>
<style scoped></style>
