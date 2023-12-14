<template>
  <div>
    <div class="text-center display-1">NUOVO CONTATTO</div>
    <div>
      <v-container>
        <v-form>
          <v-radio-group v-model="tipoPersona" row class="pb-2">
            <template v-slot:label>
              <div>Tipologia</div>
            </template>
            <v-radio label="Persona Fisica" value="PF"></v-radio>
            <v-radio label="Persona Giuridica" value="PG"></v-radio>
          </v-radio-group>
          <v-row v-if="tipoPersona === 'PF'">
            <v-col cols="12" sm="4" md="4">
              <v-text-field
                outlined
                v-model="nome"
                label="Nome *"
              ></v-text-field>
            </v-col>
            <v-col cols="12" sm="4" md="4">
              <v-text-field
                outlined
                v-model="cognome"
                label="Cognome *"
              ></v-text-field>
            </v-col>
            <v-col cols="12" sm="4" md="4">
              <v-text-field
                outlined
                v-model="cf"
                label="Codice Fiscale"
              ></v-text-field>
            </v-col>
          </v-row>
          <v-row>
            <v-col v-if="tipoPersona === 'PG'" cols="12" sm="4" md="4">
              <v-text-field
                outlined
                v-model="ragioneSociale"
                label="Ragione Sociale *"
              ></v-text-field>
            </v-col>
            <v-col v-if="tipoPersona === 'PG'" cols="12" sm="4" md="4">
              <v-text-field
                outlined
                v-model="partitaIva"
                label="Partita IVA *"
              ></v-text-field>
            </v-col>
            <v-col v-if="tipoPersona === 'PG'" cols="12" sm="4" md="4">
              <v-text-field
                outlined
                v-model="referente"
                label="Referente"
              ></v-text-field>
            </v-col>
          </v-row>
          <section :class="{ disabled_input: tipoPersona === '' }">
            <v-row>
              <v-col cols="12" sm="4" md="4">
                <v-text-field
                  outlined
                  v-model="agenzia"
                  label="Agenzia"
                ></v-text-field>
              </v-col>
              <v-col cols="12" sm="4" md="4">
                <v-select
                  id="originOption"
                  outlined
                  v-model="provenienza"
                  :items="originiOptions"
                  item-value="id_origin"
                  item-text="desc"
                  label="Origine del contatto"
                ></v-select>
                <div class="nuova_origine" @click="addOriginOption()">
                  <i class="fas fa-plus-circle fa-2x"> </i>
                  <p style="margin-left: 0.5rem">Aggiungi nuova origine</p>
                </div>
              </v-col>
              <v-col cols="12" sm="4" md="4">
                <v-select
                  outlined
                  v-model="tipologia"
                  :items="tipologiaOptions"
                  item-value="id_tipologia"
                  item-text="desc"
                  label="Tipologia"
                ></v-select
              ></v-col>
              <!-- <v-col cols="12" sm="3" md="3">
                  <v-select
                    outlined
                    v-model="priorita"
                    :items="['Alta', 'Normale']"
                    label="Priorità"
                  ></v-select>
                </v-col> -->
            </v-row>
            <v-row>
              <v-col cols="12" sm="2" md="2">
                <v-radio-group v-model="iscrittoRui" row class="iscrittoRui">
                  <template v-slot:label>
                    <div>Iscritto al RUI</div>
                  </template>
                  <v-radio label="Si" value="si"></v-radio>
                  <v-radio label="No" value="no" checked></v-radio>
                </v-radio-group>
              </v-col>
              <v-col cols="12" sm="3" md="3">
                <v-text-field
                  outlined
                  v-if="iscrittoRui === 'si'"
                  v-model="numeroIscrizione"
                  label="Numero Iscrizione"
                ></v-text-field
              ></v-col>
              <v-col cols="12" sm="3" md="3">
                <v-text-field
                  outlined
                  v-if="iscrittoRui === 'si'"
                  v-model="dataIscrizione"
                  label="Data Iscrizione"
                  type="date"
                ></v-text-field>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols="12" sm="6" md="4">
                <v-text-field
                  outlined
                  v-model="cellulare"
                  label="Cellulare"
                ></v-text-field>
              </v-col>
              <v-col cols="12" sm="6" md="4">
                <v-text-field
                  outlined
                  v-model="telefono"
                  label="Telefono"
                ></v-text-field>
              </v-col>
              <v-col cols="12" sm="6" md="4">
                <v-text-field
                  outlined
                  v-model="email"
                  label="Email"
                ></v-text-field>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols="12" sm="4" md="4">
                <v-text-field outlined v-model="via" label="Via"></v-text-field>
              </v-col>
              <v-col cols="12" sm="4" md="4">
                <v-text-field
                  outlined
                  v-model="civico"
                  label="N° Civico"
                ></v-text-field>
              </v-col>
              <v-col cols="12" sm="4" md="4">
                <v-text-field
                  outlined
                  v-model="cap"
                  label="CAP"
                ></v-text-field> </v-col
            ></v-row>
            <v-row>
              <v-col cols="12" sm="4" md="4">
                <v-text-field
                  outlined
                  v-model="comune"
                  label="Comune"
                ></v-text-field>
              </v-col>
              <v-col cols="12" md="4" sm="4">
                <v-select
                  outlined
                  id="province"
                  v-model="provincia"
                  @change="updateRegion"
                  :items="province"
                  label="Provincia"
                ></v-select>
              </v-col>
              <v-col cols="12" md="4" sm="4">
                <v-text-field
                  outlined
                  readonly
                  id="regione"
                  v-model="regione"
                  label="Regione"
                ></v-text-field>
              </v-col>
            </v-row>
            <v-row class="border mb-4">
              <v-col cols="12" sm="6" md="4" class="text-center h5">
                Profili social:
              </v-col>
              <v-col cols="12" sm="6" md="4">
                <v-text-field
                  outlined
                  prepend-inner-icon="mdi-facebook"
                  v-model="facebook"
                  label="Facebook"
                ></v-text-field>
              </v-col>
              <v-col cols="12" sm="6" md="4">
                <v-text-field
                  outlined
                  prepend-inner-icon="mdi-linkedin"
                  v-model="linkedin"
                  label="Linkedin"
                ></v-text-field>
              </v-col>
            </v-row>
            <v-row>
              <v-textarea v-model="note" label="Note" outlined></v-textarea>
            </v-row>
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="#1f4b6b" dark @click="salvaContatto()"
                ><i class="fas fa-save fa-2x"></i> &nbsp; Salva</v-btn
              >
            </v-card-actions>
          </section>
        </v-form>
      </v-container>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      tipoPersona: "",
      nome: "",
      cognome: "",
      cf: "",
      ragioneSociale: "",
      partitaIva: "",
      referente: "",
      agenzia: "",
      provenienza: "",
      tipologia: "",
      priorita: "Normale",
      iscrittoRui: "no",
      cellulare: "",
      telefono: "",
      email: "",
      linkedin: "",
      facebook: "",
      via: "",
      civico: "",
      comune: "",
      provincia: "",
      regione: "",
      cap: "",
      numeroIscrizione: "",
      dataIscrizione: null,
      note: "",
      originiOptions: [],
      tipologiaOptions: [],
      province: [
        { text: "Agrigento (AG)", value: "Agrigento (AG)" },
        { text: "Alessandria (AL)", value: "Alessandria (AL)" },
        { text: "Ancona (AN)", value: "Ancona (AN)" },
        { text: "Aosta (AO)", value: "Aosta (AO)" },
        { text: "Arezzo (AR)", value: "Arezzo (AR)" },
        { text: "Ascoli Piceno (AP)", value: "Ascoli Piceno (AP)" },
        { text: "Asti (AT)", value: "Asti (AT)" },
        { text: "Avellino (AV)", value: "Avellino (AV)" },
        { text: "Bari (BA)", value: "Bari (BA)" },
        {
          text: "Barletta-Andria-Trani (BT)",
          value: "Barletta-Andria-Trani (BT)",
        },
        { text: "Belluno (BL)", value: "Belluno (BL)" },
        { text: "Benevento (BN)", value: "Benevento (BN)" },
        { text: "Bergamo (BG)", value: "Bergamo (BG)" },
        { text: "Biella (BI)", value: "Biella (BI)" },
        { text: "Bologna (BO)", value: "Bologna (BO)" },
        { text: "Bolzano (BZ)", value: "Bolzano (BZ)" },
        { text: "Brescia (BS)", value: "Brescia (BS)" },
        { text: "Brindisi (BR)", value: "Brindisi (BR)" },
        { text: "Cagliari (CA)", value: "Cagliari (CA)" },
        { text: "Caltanissetta (CL)", value: "Caltanissetta (CL)" },
        { text: "Campobasso (CB)", value: "Campobasso (CB)" },
        { text: "Carbonia-Iglesias (CI)", value: "Carbonia-Iglesias (CI)" },
        { text: "Caserta (CE)", value: "Caserta (CE)" },
        { text: "Catania (CT)", value: "Catania (CT)" },
        { text: "Catanzaro (CZ)", value: "Catanzaro (CZ)" },
        { text: "Chieti (CH)", value: "Chieti (CH)" },
        { text: "Como (CO)", value: "Como (CO)" },
        { text: "Cosenza (CS)", value: "Cosenza (CS)" },
        { text: "Cremona (CR)", value: "Cremona (CR)" },
        { text: "Crotone (KR)", value: "Crotone (KR)" },
        { text: "Cuneo (CN)", value: "Cuneo (CN)" },
        { text: "Enna (EN)", value: "Enna (EN)" },
        { text: "Fermo (FM)", value: "Fermo (FM)" },
        { text: "Ferrara (FE)", value: "Ferrara (FE)" },
        { text: "Firenze (FI)", value: "Firenze (FI)" },
        { text: "Foggia (FG)", value: "Foggia (FG)" },
        { text: "Forlì-Cesena (FC)", value: "Forlì-Cesena (FC)" },
        { text: "Frosinone (FR)", value: "Frosinone (FR)" },
        { text: "Genova (GE)", value: "Genova (GE)" },
        { text: "Gorizia (GO)", value: "Gorizia (GO)" },
        { text: "Grosseto (GR)", value: "Grosseto (GR)" },
        { text: "Imperia (IM)", value: "Imperia (IM)" },
        { text: "Isernia (IS)", value: "Isernia (IS)" },
        { text: "La Spezia (SP)", value: "La Spezia (SP)" },
        { text: "L'Aquila (AQ)", value: "L'Aquila (AQ)" },
        { text: "Latina (LT)", value: "Latina (LT)" },
        { text: "Lecce (LE)", value: "Lecce (LE)" },
        { text: "Lecco (LC)", value: "Lecco (LC)" },
        { text: "Livorno (LI)", value: "Livorno (LI)" },
        { text: "Lodi (LO)", value: "Lodi (LO)" },
        { text: "Lucca (LU)", value: "Lucca (LU)" },
        { text: "Macerata (MC)", value: "Macerata (MC)" },
        { text: "Mantova (MN)", value: "Mantova (MN)" },
        { text: "Massa-Carrara (MS)", value: "Massa-Carrara (MS)" },
        { text: "Matera (MT)", value: "Matera (MT)" },
        { text: "Medio Campidano (VS)", value: "Medio Campidano (VS)" },
        { text: "Messina (ME)", value: "Messina (ME)" },
        { text: "Milano (MI)", value: "Milano (MI)" },
        { text: "Modena (MO)", value: "Modena (MO)" },
        { text: "Monza e Brianza (MB)", value: "Monza e Brianza (MB)" },
        { text: "Napoli (NA)", value: "Napoli (NA)" },
        { text: "Novara (NO)", value: "Novara (NO)" },
        { text: "Nuoro (NU)", value: "Nuoro (NU)" },
        { text: "Ogliastra (OG)", value: "Ogliastra (OG)" },
        { text: "Olbia-Tempio (OT)", value: "Olbia-Tempio (OT)" },
        { text: "Oristano (OR)", value: "Oristano (OR)" },
        { text: "Padova (PD)", value: "Padova (PD)" },
        { text: "Palermo (PA)", value: "Palermo (PA)" },
        { text: "Parma (PR)", value: "Parma (PR)" },
        { text: "Pavia (PV)", value: "Pavia (PV)" },
        { text: "Perugia (PG)", value: "Perugia (PG)" },
        { text: "Pesaro e Urbino (PU)", value: "Pesaro e Urbino (PU)" },
        { text: "Pescara (PE)", value: "Pescara (PE)" },
        { text: "Piacenza (PC)", value: "Piacenza (PC)" },
        { text: "Pisa (PI)", value: "Pisa (PI)" },
        { text: "Pistoia (PT)", value: "Pistoia (PT)" },
        { text: "Pordenone (PN)", value: "Pordenone (PN)" },
        { text: "Potenza (PZ)", value: "Potenza (PZ)" },
        { text: "Prato (PO)", value: "Prato (PO)" },
        { text: "Ragusa (RG)", value: "Ragusa (RG)" },
        { text: "Ravenna (RA)", value: "Ravenna (RA)" },
        { text: "Reggio Calabria (RC)", value: "Reggio Calabria (RC)" },
        { text: "Reggio Emilia (RE)", value: "Reggio Emilia (RE)" },
        { text: "Rieti (RI)", value: "Rieti (RI)" },
        { text: "Rimini (RN)", value: "Rimini (RN)" },
        { text: "Roma (RM)", value: "Roma (RM)" },
        { text: "Rovigo (RO)", value: "Rovigo (RO)" },
        { text: "Salerno (SA)", value: "Salerno (SA)" },
        { text: "Sassari (SS)", value: "Sassari (SS)" },
        { text: "Savona (SV)", value: "Savona (SV)" },
        { text: "Siena (SI)", value: "Siena (SI)" },
        { text: "Siracusa (SR)", value: "Siracusa (SR)" },
        { text: "Sondrio (SO)", value: "Sondrio (SO)" },
        { text: "Taranto (TA)", value: "Taranto (TA)" },
        { text: "Teramo (TE)", value: "Teramo (TE)" },
        { text: "Terni (TR)", value: "Terni (TR)" },
        { text: "Torino (TO)", value: "Torino (TO)" },
        { text: "Trapani (TP)", value: "Trapani (TP)" },
        { text: "Trento (TN)", value: "Trento (TN)" },
        { text: "Treviso (TV)", value: "Treviso (TV)" },
        { text: "Trieste (TS)", value: "Trieste (TS)" },
        { text: "Udine (UD)", value: "Udine (UD)" },
        { text: "Varese (VA)", value: "Varese (VA)" },
        { text: "Venezia (VE)", value: "Venezia (VE)" },
        {
          text: "Verbano-Cusio-Ossola (VB)",
          value: "Verbano-Cusio-Ossola (VB)",
        },
        { text: "Vercelli (VC)", value: "Vercelli (VC)" },
        { text: "Verona (VR)", value: "Verona (VR)" },
        { text: "Vibo Valentia (VV)", value: "Vibo Valentia (VV)" },
        { text: "Vicenza (VI)", value: "Vicenza (VI)" },
        { text: "Viterbo (VT)", value: "Viterbo (VT)" },
      ],
      blackListProv: [
        "Napoli (NA)",
        "Caserta (CE)",
        "Matera (MT)",
        "Crotone (KR)",
        "Foggia (FG)",
      ],
      blackListCity: [
        { "Roma (RM)": ["Ostia"] },
        { "Salerno (SA)": ["Salerno", "Pontecagnano", "Eboli"] },
        { "Cosenza (CS)": ["Cassano Allo Jonio", "Scalea", "Praia a Mare"] },
        {
          "Vibo Valentia (VV)": [
            "San Calogero",
            "Joppolo",
            "Jonadi",
            "Rombiolo",
            "Mileto",
          ],
        },
        { "Catanzaro (CZ)": ["Guardavalle"] },
        {
          "Reggio Calabria (RC)": [
            "San Luca",
            "Africo",
            "Bovalino",
            "Benestare",
            "Natile",
            "Bianco",
            "Platì",
            "San Ferdinando",
          ],
        },
        {
          "Catania (CT)": ["Adrano", "Gravina", "Misterbianco"],
        },
        {
          "Siracusa (SR)": ["Lentini", "Carlentini", "Priolo"],
        },
        { "Trapani (TP)": ["Castelvetrano", "Castellammare del Golfo"] },
        { "Caltanisetta (CL)": ["Gela", "Niscemi"] },
      ],
      checkblacklist: false,
    };
  },
  mounted() {
    this.getProvenienze();
    this.getTipologia();
  },
  watch: {
    provincia() {
      this.isBlackList(this.provincia);
      this.isBlackListCity(this.provincia);
    },
    tipoPersona() {
      // Inizializzo i campi se passo da una tipologia all'altra
      this.nome = "";
      this.cognome = "";
      this.cf = "";
      this.ragioneSociale = "";
      this.partitaIva = "";
      this.referente = "";
    },
    iscrittoRui() {
      this.numeroIscrizione = "";
      this.dataIscrizione = null;
    },
  },
  methods: {
    isBlackList(prov) {
      if (this.blackListProv.includes(prov)) {
        console.log("provincia in blacklist");
        this.$alert(
          "Questa provincia rientra nella blacklist, non sarà possibile inserire il candidato",
          "Attenzione",
          "warning"
        );
        this.checkblacklist = true;
      } else {
        this.checkblacklist = false;
      }
    },
    isBlackListCity(prov) {
      let found = false;
      let blacklistedCities = [];

      for (let i = 0; i < this.blackListCity.length; i++) {
        const entry = this.blackListCity[i];
        const province = Object.keys(entry)[0]; // Ottieni la chiave (provincia)
        const cities = entry[province]; // Ottieni le città associate alla provincia

        if (province.includes(prov)) {
          found = true;
          blacklistedCities = cities;
          break; // Interrompi il ciclo una volta trovata la corrispondenza
        }
      }

      if (found) {
        //   console.log("Provincia in blacklist:", prov);
        //   console.log("Città sulla blacklist:", blacklistedCities);
        this.$alert(
          `La provincia ${prov} rientra nella blacklist. Le città sulla blacklist sono: ${blacklistedCities.join(
            ", "
          )}`,
          "Attenzione",
          "warning"
        );
        this.checkblacklist = true;
      } else {
        this.checkblacklist = false;
      }
    },
    updateRegion() {
      // mappatura delle province alle regioni:
      const provinceToRegionMap = {
        "Agrigento (AG)": "Sicilia",
        "Alessandria (AL)": "Piemonte",
        "Ancona (AN)": "Marche",
        "Aosta (AO)": "Valle d'Aosta",
        "Arezzo (AR)": "Toscana",
        "Ascoli Piceno (AP)": "Marche",
        "Asti (AT)": "Piemonte",
        "Avellino (AV)": "Campania",
        "Bari (BA)": "Puglia",
        "Barletta-Andria-Trani (BT)": "Puglia",
        "Belluno (BL)": "Veneto",
        "Benevento (BN)": "Campania",
        "Bergamo (BG)": "Lombardia",
        "Biella (BI)": "Piemonte",
        "Bologna (BO)": "Emilia-Romagna",
        "Bolzano (BZ)": "Trentino-Alto Adige",
        "Brescia (BS)": "Lombardia",
        "Brindisi (BR)": "Puglia",
        "Cagliari (CA)": "Sardegna",
        "Caltanissetta (CL)": "Sicilia",
        "Campobasso (CB)": "Molise",
        "Carbonia-Iglesias (CI)": "Sardegna",
        "Caserta (CE)": "Campania",
        "Catania (CT)": "Sicilia",
        "Catanzaro (CZ)": "Calabria",
        "Chieti (CH)": "Abruzzo",
        "Como (CO)": "Lombardia",
        "Cosenza (CS)": "Calabria",
        "Cremona (CR)": "Lombardia",
        "Crotone (KR)": "Calabria",
        "Cuneo (CN)": "Piemonte",
        "Enna (EN)": "Sicilia",
        "Fermo (FM)": "Marche",
        "Ferrara (FE)": "Emilia-Romagna",
        "Firenze (FI)": "Toscana",
        "Foggia (FG)": "Puglia",
        "Forlì-Cesena (FC)": "Emilia-Romagna",
        "Frosinone (FR)": "Lazio",
        "Genova (GE)": "Liguria",
        "Gorizia (GO)": "Friuli-Venezia Giulia",
        "Grosseto (GR)": "Toscana",
        "Imperia (IM)": "Liguria",
        "Isernia (IS)": "Molise",
        "La Spezia (SP)": "Liguria",
        "L'Aquila (AQ)": "Abruzzo",
        "Latina (LT)": "Lazio",
        "Lecce (LE)": "Puglia",
        "Lecco (LC)": "Lombardia",
        "Livorno (LI)": "Toscana",
        "Lodi (LO)": "Lombardia",
        "Lucca (LU)": "Toscana",
        "Macerata (MC)": "Marche",
        "Mantova (MN)": "Lombardia",
        "Massa-Carrara (MS)": "Toscana",
        "Matera (MT)": "Basilicata",
        "Medio Campidano (VS)": "Sardegna",
        "Messina (ME)": "Sicilia",
        "Milano (MI)": "Lombardia",
        "Modena (MO)": "Emilia-Romagna",
        "Monza e Brianza (MB)": "Lombardia",
        "Napoli (NA)": "Campania",
        "Novara (NO)": "Piemonte",
        "Nuoro (NU)": "Sardegna",
        "Ogliastra (OG)": "Sardegna",
        "Olbia-Tempio (OT)": "Sardegna",
        "Oristano (OR)": "Sardegna",
        "Padova (PD)": "Veneto",
        "Palermo (PA)": "Sicilia",
        "Parma (PR)": "Emilia-Romagna",
        "Pavia (PV)": "Lombardia",
        "Perugia (PG)": "Umbria",
        "Pesaro e Urbino (PU)": "Marche",
        "Pescara (PE)": "Abruzzo",
        "Piacenza (PC)": "Emilia-Romagna",
        "Pisa (PI)": "Toscana",
        "Pistoia (PT)": "Toscana",
        "Pordenone (PN)": "Friuli-Venezia Giulia",
        "Potenza (PZ)": "Basilicata",
        "Prato (PO)": "Toscana",
        "Ragusa (RG)": "Sicilia",
        "Ravenna (RA)": "Emilia-Romagna",
        "Reggio Calabria (RC)": "Calabria",
        "Reggio Emilia (RE)": "Emilia-Romagna",
        "Rieti (RI)": "Lazio",
        "Rimini (RN)": "Emilia-Romagna",
        "Roma (RM)": "Lazio",
        "Rovigo (RO)": "Veneto",
        "Salerno (SA)": "Campania",
        "Sassari (SS)": "Sardegna",
        "Savona (SV)": "Liguria",
        "Siena (SI)": "Toscana",
        "Siracusa (SR)": "Sicilia",
        "Sondrio (SO)": "Lombardia",
        "Taranto (TA)": "Puglia",
        "Teramo (TE)": "Abruzzo",
        "Terni (TR)": "Umbria",
        "Torino (TO)": "Piemonte",
        "Trapani (TP)": "Sicilia",
        "Trento (TN)": "Trentino-Alto Adige",
        "Treviso (TV)": "Veneto",
        "Trieste (TS)": "Friuli-Venezia Giulia",
        "Udine (UD)": "Friuli-Venezia Giulia",
        "Varese (VA)": "Lombardia",
        "Venezia (VE)": "Veneto",
        "Verbano-Cusio-Ossola (VB)": "Piemonte",
        "Vercelli (VC)": "Piemonte",
        "Verona (VR)": "Veneto",
        "Vibo Valentia (VV)": "Calabria",
        "Vicenza (VI)": "Veneto",
        "Viterbo (VT)": "Lazio",
      };

      this.regione = provinceToRegionMap[this.provincia];
    },
    async addOriginOption() {
      // Aggiungo un origine nella select
      this.$prompt("Inserisci una nuova origine").then((text) => {
        if (text) {
          // this.originiOptions.push(text);
          // Aggiungo il valore sul db
          let param = {
            nuovaOrigine: text,
          };
          try {
            axios
              .post(
                this.$custom_json.base_url +
                  this.$custom_json.api_url +
                  this.$custom_json.crm.addSource,
                param
              )
              .then((response) => {
                var message = response.data.message;
                switch (response.data.esito) {
                  case "OK":
                    this.$alert(
                      "Nuova origine inserita correttamente",
                      "OK",
                      "success"
                    );
                    this.getProvenienze();
                    break;
                  case "KO":
                    this.$alert(message, "Attenzione", "warning");
                    break;
                }
              });
          } catch (error) {
            this.$alert(text, "Attenzione", "warning");
          }
        }
      });
    },
    async getProvenienze() {
      try {
        await axios
          .get(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.crm.getSource
          )
          .then((response) => {
            this.originiOptions = response.data;
          });
      } catch (error) {
        console.error(error);
      }
    },
    async getTipologia() {
      try {
        await axios
          .get(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.crm.getTipo
          )
          .then((response) => {
            this.tipologiaOptions = response.data;
          });
      } catch (error) {
        console.error(error);
      }
    },
    async salvaContatto() {
      // Controllo se siamo in presenza di blacklist
      if (this.checkblacklist) {
        this.$alert(
          "Non è possibile aggiungere questo contatto in quanto la zona è sulla blacklist",
          "Attenzione",
          "warning"
        );
        return;
      }
      // Controllo campi obbligatori
      if (this.tipoPersona === "PF") {
        if (
          !this.nome ||
          !this.cognome ||
          (!this.telefono && !this.cellulare && !this.email)
        ) {
          this.$alert(
            "Compila i campi obbligatori per Persona Fisica.",
            "Attenzione",
            "warning"
          );
          return;
        }
      } else if (this.tipoPersona === "PG") {
        if (
          !this.ragioneSociale ||
          (!this.telefono && !this.cellulare && !this.email) ||
          !this.partitaIva
        ) {
          this.$alert(
            "Compila i campi obbligatori per Persona Giuridica.",
            "Attenzione",
            "warning"
          );
          return;
        }
      }
      // Controllo formale dei dati
      var param = {
        utente: JSON.parse(localStorage.getItem("chisono_data")).Nominativo,
        idUtente: JSON.parse(localStorage.getItem("chisono_data")).idUtente,
        tipo_persona: this.tipoPersona,
        nome: this.nome,
        cognome: this.cognome,
        codiceFiscale: this.cf,
        ragioneSociale: this.ragioneSociale,
        partitaIva: this.partitaIva,
        referente: this.referente,
        agenzia: this.agenzia,
        provenienza: this.provenienza,
        tipologia: this.tipologia,
        priorita: this.priorita,
        iscrittoRui: this.iscrittoRui,
        cellulare: this.cellulare,
        telefono: this.telefono,
        email: this.email,
        linkedin: this.linkedin,
        facebook: this.facebook,
        via: this.via,
        civico: this.civico,
        comune: this.comune,
        provincia: this.provincia,
        regione: this.regione,
        cap: this.cap,
        numeroIscrizione: this.numeroIscrizione,
        dataIscrizione: this.dataIscrizione,
        note: this.note,
      };
      // invio i dati al backend
      try {
        await axios
          .post(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.crm.newContatto,
            param
          )
          .then((response) => {
            var message = response.data.message;
            switch (response.data.esito) {
              case "OK":
                this.$alert(message, "OK", "success");
                this.$emit("showgrid", "default");
                break;
              case "KO":
                this.$alert(message, "Attenzione", "warning");
                break;
            }
          });
      } catch (error) {
        console.log("Errore di comunicazione con il back-end");
      }
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
