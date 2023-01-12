<template>
  <div id="firma_ABY" style="font-family: Montserrat">
    <table width="100%" style="color: #575756">
      <tbody>
        <tr>
          <td rowspan="4" width="281">
            <img
              src="https://www.aby.it/team/aby/sign/img/Logo_Aby.png"
              alt="Aby"
            />
          </td>
          <td width="1%"></td>
          <td
            rowspan="2"
            width="30%"
            style="
              font-family: Montserrat;
              font-weight: 600;
              color: #1f4b6b;
              text-transform: capitalize;
              font-size: 28px;
            "
          >
            <span>{{ recapiti.nome != "" ? recapiti.nome : "Nome Cognome" }}</span>
            <div
              style="
              font-family: Montserrat;
                font-weight: 500;
                text-transform: capitalize;
                font-size: 18px;
                color: #575756;
              "
              v-if="recapiti.mostra_ruolo"
            >
              <i
                >{{ recapiti.ruolo != "" ? recapiti.ruolo : "Ruolo Aziendale" }}&nbsp;<br />{{
                  recapiti.ruolo2 != "" ? recapiti.ruolo2 : ""
                }}</i
              >
            </div>
          </td>
          <td width="2%"></td>
          <td rowspan="4">
            <table
              width="100%"
              style="color: #575756; line-height: 2rem; font-weight: 500;font-family: Montserrat;"
            >
              <tbody>
                <tr>
                  <td rowspan="5">
                    <img
                      src="https://www.aby.it/team/aby/sign/img/lineaVerticale.png"
                      width="3"
                      height="79"
                      alt=""
                    />
                  </td>
                  <td style="text-align: center; font-family: Montserrat;">
                    <img
                      src="https://www.aby.it/team/aby/sign/img/Telefono.png"
                      alt=""
                    />
                  </td>
                  <td valign="middle" style="font-family: Montserrat;">
                    {{
                      recapiti.sel_telefono
                        ? recapiti.telefono
                        : "+39 02 86882871"
                    }}&nbsp;{{
                      recapiti.sel_interno
                        ? "(interno " + recapiti.interno + ")"
                        : ""
                    }}
                  </td>
                </tr>
                <tr v-if="recapiti.sel_cell">
                  <td style="text-align: center; font-family: Montserrat;">
                    <img
                      src="https://www.aby.it/team/aby/sign/img/Mobile.png"
                      alt="Cell"
                    />
                  </td>
                  <td>{{ recapiti.cellulare }}</td>
                </tr>
                <tr v-if="recapiti.sel_mail">
                  <td style="text-align: center; font-family: Montserrat;">
                    <img
                      src="https://www.aby.it/team/aby/sign/img/Mail.png"
                      alt=""
                    />
                  </td>
                  <td style="text-decoration: none; color: #575756; font-family: Montserrat;">
                    <a
                      :href="'mailto:' + recapiti.mail"
                      style="text-decoration: none; color: #575756"
                      >{{ recapiti.mail }}</a
                    >
                  </td>
                </tr>
                <tr>
                  <td style="text-align: center; font-family: Montserrat;">
                    <img
                      src="https://www.aby.it/team/aby/sign/img/Geo.png"
                      alt=""
                    />
                  </td>
                  <td v-if="recapiti.sel_indirizzo">
                    <a
                      :href="'https://maps.google.com/?q=' + recapiti.indirizzo"
                      style="text-decoration: none; color: #575756; font-family: Montserrat;"
                    >
                      {{ recapiti.indirizzo }}</a
                    >
                  </td>
                  <td v-else>
                    <a
                      href="https://maps.google.com/?q=Via Monte Napoleone 8, 20121 Milano (MI)"
                      style="text-decoration: none; color: #575756; font-family: Montserrat;"
                      target="_blank"
                    >
                      Via Monte Napoleone 8, 20121 Milano (MI)
                    </a>
                  </td>
                </tr>
                <tr>
                  <td style="text-align: center; font-family: Montserrat;">
                    <img
                      src="https://www.aby.it/team/aby/sign/img/Web.png"
                      alt=""
                    />
                  </td>
                  <td style="font-weight: 500; font-family: Montserrat;">
                    <a
                      href="https://www.aby.it"
                      target="_blank"
                      style="text-decoration: none; color: #575756"
                      >www.aby.it</a
                    >
                  </td>
                </tr>
              </tbody>
            </table>
          </td>
        </tr>
        <tr>
          <td width="1%"></td>
          <td width="2%"></td>
        </tr>
      </tbody>
    </table>
    <table width="100%">
      <tr>
        <td
          align="center"
          background="https://www.aby.it/team/aby/sign/img/lineaOrizzontale.png"
          style="background-repeat: no-repeat; background-position: center"
        >
          <a href="https://www.facebook.com/GruppoAby"
            ><img
              style="padding: 5px"
              src="https://www.aby.it/team/aby/sign/img/facebook.png"
              alt="" /></a
          >&nbsp;<a href="https://www.instagram.com/abybrokersrl/"
            ><img
              style="padding: 5px"
              src="https://www.aby.it/team/aby/sign/img/Instagram.png"
              alt="" /></a
          >&nbsp;<a href="https://www.linkedin.com/company/aby-broker/"
            ><img
              style="padding: 5px"
              src="https://www.aby.it/team/aby/sign/img/Linkedin.png"
              alt="" /></a
          >&nbsp;
        </td>
      </tr>
    </table>
    <div align="center" style="font-weight: 500; font-family: Montserrat">
      ABY BROKER S.r.l. - Partita IVA e Codice Fiscale: 00803170141 - Numero
      REA: MI-2057530 - Iscrizione RUI: B00137063
    </div>
    <div
      style="
        width: 100%;
        margin-top: 20px;
        padding-top: 10px;
        border-top: 2px solid lightgray;
      "
    >
      <span
        style="
          font-family: Helvetica, sans-serif;
          color: #333333;
          line-height: 15px;
          font-size: 12px;
        "
        ><em>Avviso di riservatezza</em><br />
        Ai sensi del D.Lgs. 196/2003 si precisa che le&nbsp;informazioni
        contenute&nbsp;in questo messaggio sono&nbsp;riservate ed a uso
        esclusivo del destinatario. Qualora&nbsp;il&nbsp;messaggio in parola Le
        fosse pervenuto per errore, La&nbsp;invitiamo ad&nbsp;eliminarlo senza
        copiarlo e a non inoltrarlo&nbsp;a terzi, dandocene
        gentilmente&nbsp;comunicazione.&nbsp;Grazie.<br />
        <br />
        <em> Confidentiality warning</em><br />
        Pursuant to Legislative&nbsp;Decree No. 196/2003, you are&nbsp;hereby
        informed that this message contains&nbsp;confidential&nbsp;information
        intended only for the use of the addressee.&nbsp;If you are&nbsp;not the
        addressee, and have received this&nbsp;message by mistake, please delete
        it&nbsp;and immediately&nbsp;notify us. You may not copy or disseminate
        this message&nbsp;to&nbsp;anyone.&nbsp;Thank you.</span
      >
    </div>
  </div>
</template>

<script>
export default {
  name: "SignAby",
  props: ["recapiti"],
};
</script>


<style scoped>
</style>
