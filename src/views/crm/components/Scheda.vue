<template>
  <div>
    <v-list three-line subheader>
      <v-subheader class="display-1"
        >{{ candidato.candidate }}
        <!-- <v-btn color="warning" fab x-small dark class="ml-2">
          <v-icon>mdi-alarm</v-icon>
        </v-btn> -->
        <p style="margin-bottom: 0px !important; margin-left: 1rem">
          <v-tooltip bottom>
            <template v-slot:activator="{ on, attrs }">
              <v-btn
                small
                icon
                outlined
                color="#1f4b6b"
                v-bind="attrs"
                v-on="on"
              >
                <i class="fas fa-pencil-alt"></i>
              </v-btn>
            </template>
            <span>Modifica contatto</span>
          </v-tooltip>
        </p>
      </v-subheader>
      <v-row
        class="mt-2"
        style="background-color: #b2dfdb; border-radius: 10px"
      >
        <v-col v-if="candidato.tipologia === 'PG'"
          ><v-list-item>
            <v-list-item-content>
              <v-list-item-title>Referente</v-list-item-title>
              <v-list-item-subtitle>{{
                candidato.referente
              }}</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </v-col>
        <v-col>
          <v-list-item>
            <v-list-item-content>
              <v-list-item-title>Telefono</v-list-item-title>
              <v-list-item-subtitle>{{ candidato.tel }}</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </v-col>
        <v-col>
          <v-list-item>
            <v-list-item-content>
              <v-list-item-title>Cellulare</v-list-item-title>
              <v-list-item-subtitle>{{ candidato.cel }}</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </v-col>
        <v-col>
          <v-list-item>
            <v-list-item-content>
              <v-list-item-title>Mail</v-list-item-title>
              <v-list-item-subtitle>{{ candidato.mail }}</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </v-col>
      </v-row>

      <v-row>
        <v-col>
          <v-list-item>
            <v-list-item-content>
              <v-list-item-title>Tipo</v-list-item-title>

              <v-list-item-subtitle v-if="candidato.tipologia === 'PF'"
                ><i class="far fa-user"></i>
                Persona Fisica
              </v-list-item-subtitle>
              <v-list-item-subtitle v-else-if="candidato.tipologia === 'PG'"
                ><i class="far fa-building"></i> Persona
                Giuridica</v-list-item-subtitle
              >
            </v-list-item-content>
          </v-list-item>
        </v-col>
        <v-col>
          <v-list-item>
            <v-list-item-content v-if="candidato.tipologia === 'PF'">
              <v-list-item-title>Codice Fiscale</v-list-item-title>
              <v-list-item-subtitle>{{ candidato.cf }}</v-list-item-subtitle>
            </v-list-item-content>
            <v-list-item-content v-else-if="candidato.tipologia === 'PG'">
              <v-list-item-title>Partita IVA</v-list-item-title>
              <v-list-item-subtitle>{{ candidato.piva }}</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </v-col>
        <v-col>
          <v-list-item>
            <v-list-item-content>
              <v-list-item-title>Iscrizione RUI</v-list-item-title>
              <v-list-item-subtitle>{{ candidato.type }}</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </v-col>
        <v-col>
          <v-list-item>
            <v-list-item-content>
              <v-list-item-title>Provenienza</v-list-item-title>
              <v-list-item-subtitle>{{
                candidato.contact_origin
              }}</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </v-col>
      </v-row>
      <v-row>
        <v-col>
          <v-list-item>
            <v-list-item-content>
              <v-list-item-title>Regione</v-list-item-title>
              <v-list-item-subtitle>{{
                candidato.region
              }}</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </v-col>
        <v-col>
          <v-list-item>
            <v-list-item-content>
              <v-list-item-title>Provincia</v-list-item-title>
              <v-list-item-subtitle>{{
                candidato.provincia
              }}</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </v-col>
        <v-col>
          <v-list-item>
            <v-list-item-content>
              <v-list-item-title>Cap e Comune</v-list-item-title>
              <v-list-item-subtitle>{{
                candidato.cap + " " + candidato.comune
              }}</v-list-item-subtitle>
            </v-list-item-content>
          </v-list-item>
        </v-col>
        <v-col>
          <v-list-item>
            <v-list-item-content>
              <v-list-item-title>Indirizzo</v-list-item-title>
              <v-list-item-subtitle
                >{{ candidato.via + " " + candidato.civico }}
                <a
                  target="_blank"
                  :href="
                    'https://maps.google.com/maps?q=' +
                    candidato.via +
                    ' ' +
                    candidato.civico +
                    ' ' +
                    candidato.cap +
                    ' ' +
                    candidato.comune
                  "
                >
                  - <i class="fas fa-map-marker-alt"></i> Localizza su maps</a
                ></v-list-item-subtitle
              >
            </v-list-item-content>
          </v-list-item>
        </v-col>
      </v-row>
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
<style scoped>
.col {
  padding: 0 !important;
}
</style>
