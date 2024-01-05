<template>
  <div>
    <div>
      <v-stepper v-model="e1" alt-labels>
        <v-stepper-header>
          <v-stepper-step color="warning" editable :complete="e1 > 1" step="1">
            Anagrafica
          </v-stepper-step>

          <v-divider></v-divider>

          <v-stepper-step color="warning" editable :complete="e1 > 2" step="2">
            Documenti
          </v-stepper-step>

          <v-divider></v-divider>

          <v-stepper-step color="warning" editable step="3">
            Note
          </v-stepper-step>
        </v-stepper-header>
        <v-stepper-items>
          <v-stepper-content step="1">
            <v-form>
              <v-radio-group v-model="tipoPersona" row class="pb-2" dense>
                <template v-slot:label>
                  <div>Tipologia</div>
                </template>
                <v-radio label="Persona Fisica" value="PF"></v-radio>
                <v-radio label="Persona Giuridica" value="PG"></v-radio>
              </v-radio-group>
              <v-row v-if="tipoPersona === 'PF'">
                <v-col cols="12" sm="4" md="4">
                  <v-text-field
                    dense
                    outlined
                    v-model="nome"
                    label="Nome *"
                  ></v-text-field>
                </v-col>
                <v-col cols="12" sm="4" md="4">
                  <v-text-field
                    dense
                    outlined
                    v-model="cognome"
                    label="Cognome *"
                  ></v-text-field>
                </v-col>
                <v-col cols="12" sm="4" md="4">
                  <v-text-field
                    dense
                    outlined
                    v-model="cf"
                    label="Codice Fiscale"
                  ></v-text-field>
                </v-col>
              </v-row>
              <v-row>
                <v-col v-if="tipoPersona === 'PG'" cols="12" sm="4" md="4">
                  <v-text-field
                    dense
                    outlined
                    v-model="ragioneSociale"
                    label="Ragione Sociale *"
                  ></v-text-field>
                </v-col>
                <v-col v-if="tipoPersona === 'PG'" cols="12" sm="4" md="4">
                  <v-text-field
                    dense
                    outlined
                    v-model="partitaIva"
                    label="Partita IVA *"
                  ></v-text-field>
                </v-col>
                <v-col v-if="tipoPersona === 'PG'" cols="12" sm="4" md="4">
                  <v-text-field
                    dense
                    outlined
                    v-model="referente"
                    label="Referente"
                  ></v-text-field>
                </v-col>
              </v-row>
              <section :class="{ disabled_input: tipoPersona === '' }">
                <v-row>
                  <v-col cols="12" sm="4" md="4">
                    <v-select
                      outlined
                      dense
                      v-model="tipologia"
                      :items="tipologiaOptions"
                      item-value="id_tipologia"
                      item-text="desc"
                      label="Tipologia *"
                    ></v-select
                  ></v-col>
                  <v-col cols="12" sm="2" md="2">
                    <v-radio-group
                      v-model="iscrittoRui"
                      row
                      class="iscrittoRui"
                      dense
                    >
                      <template v-slot:label>
                        <div>Iscritto al RUI</div>
                      </template>
                      <v-radio label="Si" value="si"></v-radio>
                      <v-radio label="No" value="no" checked></v-radio>
                    </v-radio-group>
                  </v-col>
                  <v-col cols="12" sm="3" md="3">
                    <v-text-field
                      dense
                      outlined
                      v-if="iscrittoRui === 'si'"
                      v-model="numeroIscrizione"
                      label="Numero Iscrizione"
                    ></v-text-field
                  ></v-col>
                  <v-col cols="12" sm="3" md="3">
                    <v-text-field
                      dense
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
                      dense
                      outlined
                      v-model="cellulare"
                      label="Cellulare"
                    ></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field
                      dense
                      outlined
                      v-model="telefono"
                      label="Telefono"
                    ></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field
                      dense
                      outlined
                      v-model="email"
                      label="Email *"
                    ></v-text-field>
                  </v-col>
                </v-row>
                <v-row>
                  <v-col cols="12" sm="4" md="4">
                    <v-text-field
                      dense
                      outlined
                      v-model="via"
                      label="Via"
                    ></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="4" md="4">
                    <v-text-field
                      dense
                      outlined
                      v-model="civico"
                      label="N° Civico"
                    ></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="4" md="4">
                    <v-text-field
                      outlined
                      dense
                      v-model="cap"
                      label="CAP"
                    ></v-text-field> </v-col
                ></v-row>
                <v-row>
                  <v-col cols="12" sm="4" md="4">
                    <v-text-field
                      outlined
                      dense
                      v-model="comune"
                      label="Comune"
                    ></v-text-field>
                  </v-col>
                  <v-col cols="12" md="4" sm="4">
                    <v-select
                      dense
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
                      dense
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
                      dense
                      outlined
                      prepend-inner-icon="mdi-facebook"
                      v-model="facebook"
                      label="Facebook"
                    ></v-text-field>
                  </v-col>
                  <v-col cols="12" sm="6" md="4">
                    <v-text-field
                      outlined
                      dense
                      prepend-inner-icon="mdi-linkedin"
                      v-model="linkedin"
                      label="Linkedin"
                    ></v-text-field>
                  </v-col>
                </v-row>
              </section>
            </v-form>
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn text @click="e1 > 1 ? (e1 = e1 - 1) : (e1 = 1)">
                Indietro
              </v-btn>
              <v-btn color="#1f4b6b" dark @click="e1 = 2"> Avanti </v-btn>
            </v-card-actions>
          </v-stepper-content>

          <v-stepper-content step="2">
            Disponi dei documenti per effettuare la registrazione del candidato?
            <v-radio-group v-model="disponeDocumenti" row dense>
              <v-radio label="Si" value="si"></v-radio>
              <v-radio label="No" value="no"></v-radio>
            </v-radio-group>
            <section v-if="disponeDocumenti == 'si'">
              <p>
                In questa pagina sono elencati i documenti necessari per poter
                procedere con il percorso di formazione e la successiva
                creazione del tuo utente per l'accesso alla piattaforma Abyway
              </p>
              <div
                v-for="(item, index) in fileRichiesti"
                style="padding-top: 10px; padding-bottom: 10px; width: 60%"
                :key="index"
              >
                <v-row>
                  <v-col cols="6" sm="6">
                    <div
                      :style="{
                        color:
                          item.validato == 0
                            ? 'orange'
                            : item.validato == 1
                            ? 'green'
                            : '',
                      }"
                    >
                      <strong>{{ item.label }}</strong
                      ><br />
                      <!-- <small v-if="item.label == 'Visura camerale'">
                        Non più vecchia di 6 mesi</small
                      >
                      <small
                        v-if="
                          item.label == 'Autocertificazione titolo di studio'
                        "
                      >
                        Diploma o Laurea</small
                      >
                      <small v-if="item.label == 'Polizza RC Professionale'">
                        <strong
                          >Se non disponi della copia contratto, scarica
                          l'autocertificazione per inviarci gli estremi di
                          polizza
                        </strong></small
                      > -->
                      <small v-if="item.label == 'Visura camerale'">
                        Non più vecchia di 6 mesi</small
                      >
                      <small
                        v-if="
                          item.label == 'Autocertificazione titolo di studio'
                        "
                      >
                        <u>Diploma o Laurea</u></small
                      >
                      <small v-if="item.label == 'Polizza RC Professionale'">
                        <strong
                          >Se non disponi della copia contratto, scarica
                          l'autocertificazione per inviarci gli estremi di
                          polizza -
                          <a
                            href="https://abyway-staging.navert.cloud/API/crm/pub/Moduli/Autocertificazione Polizza RC Professionale.pdf"
                            target="_blank"
                            ><u>Scarica modulo</u></a
                          >
                          -
                        </strong></small
                      >
                      <small v-if="item.label == 'Moduli dati intermediario'">
                        <strong
                          >Scarica il modulo da compilare -
                          <a
                            href="https://abyway-staging.navert.cloud/API/crm/pub/Moduli/MODULO DATI INTERMEDIARIO.pdf"
                            target="_blank"
                            ><u>Scarica modulo</u></a
                          >
                          -
                        </strong></small
                      >
                      <small
                        v-if="
                          item.label == 'Dichiarazione requisiti di onorabilità'
                        "
                      >
                        <strong
                          >Scarica il modulo da compilare -
                          <a
                            href="https://abyway-staging.navert.cloud/API/crm/pub/Moduli/DICHIARAZIONE REQUISITI ONORABILITA.pdf"
                            target="_blank"
                            ><u>Scarica modulo</u></a
                          >
                          -
                        </strong></small
                      >
                      <small
                        v-if="
                          item.label ==
                          'Autocertificazione casellario giudiziario e carichi pendenti'
                        "
                      >
                        <strong
                          >Scarica il modulo da compilare -
                          <a
                            href="https://abyway-staging.navert.cloud/API/crm/pub/Moduli/Dichiarazione_del_casellario_giudiziale_e_dei_carichi_pendenti_penali.pdf"
                            target="_blank"
                            ><u>Scarica modulo</u></a
                          >
                          -
                        </strong></small
                      >
                      <small
                        v-if="
                          item.label == 'Autocertificazione titolo di studio'
                        "
                      >
                        <strong
                          >Scarica il modulo da compilare -
                          <a
                            href="https://abyway-staging.navert.cloud/API/crm/pub/Moduli/AUTOCERTIFICAZIONE-DIPLOMA.pdf"
                            target="_blank"
                            ><u>Scarica modulo</u></a
                          >
                          -
                        </strong></small
                      >
                      <small v-if="item.label == 'Modulo censimento ufficio'">
                        <strong
                          >Scarica il modulo da compilare -
                          <a
                            href="https://abyway-staging.navert.cloud/API/crm/pub/Moduli/MODULO CENSIMENTO UFFICI.pdf"
                            target="_blank"
                            ><u>Scarica modulo</u></a
                          >
                          -
                        </strong></small
                      >
                      <small v-if="item.label == 'Modalità di incasso polizze'">
                        <strong
                          >Scarica il modulo da compilare -
                          <a
                            href="https://abyway-staging.navert.cloud/API/crm/pub/Moduli/DICHIARAZIONE MODALITA INCASSO POLIZZE.pdf"
                            target="_blank"
                            ><u>Scarica modulo</u></a
                          >
                          -
                        </strong></small
                      >
                    </div>
                  </v-col>
                  <v-col cols="6" sm="6" v-if="item.validato != null">
                    <div
                      :style="{
                        color:
                          item.validato == 0
                            ? 'orange'
                            : item.validato == 1
                            ? 'green'
                            : '',
                      }"
                    >
                      <i
                        class="far fa-pause-circle fa-2x"
                        v-if="item.validato == 0"
                      ></i>
                      <i
                        class="far fa-check-circle fa-2x"
                        v-else-if="item.validato == 1"
                      ></i>
                      &nbsp;{{
                        item.validato == 0
                          ? "In attesa di validazione"
                          : "Documento validato"
                      }}
                    </div>
                  </v-col>
                  <v-col cols="6" sm="6" v-else>
                    <v-file-input
                      small-chips
                      :name="item.tipo"
                      :disabled="item.disabled"
                    ></v-file-input>
                  </v-col>
                </v-row>
                <v-divider></v-divider>
              </div>
              <v-row justify="center">
                <!-- <v-col cols="12" class="text-center">
                  <v-btn @click="inviaFile" color="primary">Invia</v-btn>
                </v-col> -->
              </v-row>
            </section>
            <section v-else>
              <div>
                Scegliendo <strong>NO</strong> il candidato, a seguito di un
                primo contatto telefonico, riceverà le istruzioni per caricare
                in autonomia la documentazione necessaria.
              </div>
            </section>
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn text @click="e1 > 1 ? (e1 = e1 - 1) : (e1 = 1)">
                Indietro
              </v-btn>
              <v-btn color="#1f4b6b" dark @click="e1 = 3"> Avanti </v-btn>
            </v-card-actions>
          </v-stepper-content>

          <v-stepper-content step="3">
            Aggiungi eventuali note:
            <v-textarea
              clear-icon="mt-2"
              v-model="note"
              label="Note"
              dense
              outlined
            ></v-textarea>
            <div v-if="uploading" class="overlay">
              <v-progress-circular
                :size="70"
                :width="7"
                color="primary"
                indeterminate
              ></v-progress-circular>
            </div>
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn text @click="e1 > 1 ? (e1 = e1 - 1) : (e1 = 1)">
                Indietro
              </v-btn>
              <v-btn color="#1f4b6b" dark @click="salvaContatto()"
                ><i class="fas fa-save fa-2x"></i> &nbsp; Salva</v-btn
              ></v-card-actions
            >
          </v-stepper-content>
        </v-stepper-items>
      </v-stepper>
    </div>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      disponeDocumenti: "no",
      e1: 1,
      tipoPersona: "",
      nome: "",
      cognome: "",
      cf: "",
      ragioneSociale: "",
      partitaIva: "",
      referente: "",
      agenzia: "",
      provenienza: 8,
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
      userCRMInfo: JSON.parse(localStorage.getItem("userCRMInfo")),
      uploadedFiles: [],
      fileRichiesti: [],
      paramTipo: "", // USATO PER I QUERYPARAMETERS
      queryString: "", //USATO PER UPLOAD
      uploading: false,
    };
  },
  mounted() {
    this.getTipologia();
  },
  watch: {
    e1() {
      if (this.e1 == "2") {
        this.getFileRichiesti();
      }
    },
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
        id_segnalatore: this.userCRMInfo.id,
        nome_segnalatore:
          this.userCRMInfo.nome + " " + this.userCRMInfo.cognome,
        mail_segnalatore: this.userCRMInfo.mail,
        id_referente: this.userCRMInfo.id_referente,
        disponeDocumenti: this.disponeDocumenti,
      };
      // invio i dati al backend
      try {
        await axios
          .post(
            this.$custom_json.base_url +
              this.$custom_json.api_url +
              this.$custom_json.crm.newContattoSegnalatore,
            param
          )
          .then((response) => {
            var message = response.data.message;
            var lastInsert = response.data.lastInsert;
            switch (response.data.esito) {
              case "OK":
                this.inviaFile(lastInsert);
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
    inviaFile(lastId) {
      if (this.disponeDocumenti == "si") {
        const fileInputs = this.$el.querySelectorAll("input[type=file]");
        const formData = new FormData();
        let checkFiles = false;
        let totalFiles = 0;

        // Verifica se ci sono file caricati
        fileInputs.forEach((fileInput) => {
          if (fileInput.files.length > 0) {
            checkFiles = true;
            return; // Esci dal loop se almeno un file è stato caricato
          }
        });
        // Calcola il numero totale di file caricati
        fileInputs.forEach((fileInput) => {
          totalFiles += fileInput.files.length;
        });

        if (!checkFiles) {
          this.$alert("Candidato inserito senza documenti", "OK", "success");
          // Aggiungi un messaggio di feedback all'utente per informare che nessun file è stato caricato
          return; // Esci dalla funzione se nessun file è stato caricato
        }
        // Mostra una finestra di dialogo di conferma
        const confirmation = confirm(
          `Stai per inviare ${totalFiles} file. Vuoi procedere?`
        );

        if (!confirmation) {
          // Se l'utente annulla la conferma, interrompi l'invio dei file
          return;
        }
        this.uploading = true;
        fileInputs.forEach((fileInput) => {
          const files = fileInput.files;
          const inputName = fileInput.getAttribute("name"); // Ottieni il valore dell'attributo name

          for (let i = 0; i < files.length; i++) {
            const renamedFile = new File(
              [files[i]],
              `${inputName}.${files[i].name.split(".").pop()}`,
              {
                type: files[i].type,
              }
            );
            formData.append("files[]", renamedFile);
            formData.append("fileNames[]", renamedFile.name); // Aggiungi il nuovo nome del file
            formData.append("tipoFile[]", `${inputName}`);
          }
        });
        // Query string per l'upload
        this.queryString =
          "?id=" +
          lastId +
          "&t=" +
          this.paramTipo +
          "&i=" +
          (this.iscrittoRui == "si" ? 1 : 0);

        formData.append("queryParameters", this.queryString);

        fetch(this.$custom_json.urlUtils3, {
          method: "POST",
          body: formData,
        })
          .then((response) => {
            if (response.ok) {
              return response.text();
            }
            throw new Error("Errore durante la preparazione dei file.");
          })
          .then((data) => {
            // Gestione della risposta
            const risposta = JSON.parse(data);

            if (risposta.esito == "OK") {
              this.uploading = false;
              this.$alert("Caricamento avvenuto con successo", "OK", "success");
            } else {
              console.error(
                "Errore durante l'upload dei file:",
                risposta.message
              );
              // Aggiungi qui il tuo codice per mostrare un messaggio di errore all'utente
              // Ad esempio, mostra un alert o un messaggio visivo
            }
          })
          .catch((error) => {
            console.error("Errore durante la richiesta al server:", error);
          });
      } else {
        // non dispone dei documenti
        this.$alert("Candidato inserito senza documenti", "OK", "success");
      }
    },

    async getFileRichiesti() {
      switch (this.tipologia) {
        case "1":
          this.paramTipo = "BA";
          break;
        case "2":
          this.paramTipo = "BB";
          break;
        case "3":
          this.paramTipo = "BE";
          break;

        default:
          this.paramTipo = "BE";
          break;
      }
      let params = {
        t: this.paramTipo, // tipologia di rapporto - dominio: BE BA BB
        i: this.iscrittoRui == "si" ? 1 : 0, // flag iscritto / non iscritto
      };

      try {
        const response = await axios.post(
          this.$custom_json.base_url +
            this.$custom_json.api_url +
            this.$custom_json.crm.getListaDocs,
          params
        );
        this.fileRichiesti = response.data;
        // this.matchAndUpdateDocuments(); // Dopo aver recuperato fileRichiesti per tipologia di rapporto, fa il match
      } catch (error) {
        console.error("Errore durante il recupero dei files richiesti", error);
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
