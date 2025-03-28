<template>
  <div id="firma_WAPITI" style="font-family: Montserrat">
    <table width="100%" style="color: #575756">
      <tbody>
        <tr>
          <td rowspan="4" width="160">
            <img
                    src="https://www.wapiti.it/wp-content/uploads/sign/logo.png"
              alt="wapiti"
              width="150"
            />
          </td>
          <td width="1%"></td>
          <td
            rowspan="2"
            width="30%"
            style="
              font-family: Montserrat;
              font-weight: 600;
              color: #aa2523;
              font-size: 18px;
            "
          >
            <span>{{
              recapiti.nome != "" ? recapiti.nome : "Nome Cognome"
            }}</span>
            <div
              style="
                font-family: Montserrat;
                font-weight: 500;
                font-size: 12px;
                color: #575756;
              "
              v-if="recapiti.mostra_ruolo"
            >
              <i
                >{{
                  recapiti.ruolo != "" ? recapiti.ruolo : "Ruolo Aziendale"
                }}&nbsp;<br />{{
                  recapiti.ruolo2 != "" ? recapiti.ruolo2 : ""
                }}</i
              >
            </div>
          </td>
          <td width="2%"></td>
          <td rowspan="4">
            <table
              width="100%"
              style="
                color: #575756;
                line-height: 1.5rem;
                font-weight: 500;
                font-family: Montserrat;
                font-size: 12px;
              "
            >
              <tbody>
                <tr>
                  <td rowspan="6">
                    <img
                      src="https://www.wapiti.it/wp-content/uploads/sign/lineaVerticale.png"
                      width="3"
                      height="79"
                      alt=""
                    />
                  </td>
                  <td style="text-align: center; font-family: Montserrat">
                    <img
                      src="https://www.wapiti.it/wp-content/uploads/sign/Telefono.png"
                      alt=""
                    />
                  </td>
                  <td valign="middle" style="font-family: Montserrat">
                    {{
                      recapiti.sel_telefono
                        ? recapiti.telefono
                        : "+39 0521 1792169"
                    }}&nbsp;{{
                      recapiti.sel_interno
                        ? "(interno " + recapiti.interno + ")"
                        : ""
                    }}
                  </td>
                </tr>
                <tr v-if="recapiti.sel_cell">
                  <td style="text-align: center; font-family: Montserrat">
                    <img
                      src="https://www.wapiti.it/wp-content/uploads/sign/Mobile.png"
                      alt="Cell"
                    />
                  </td>
                  <td>{{ recapiti.cellulare }}</td>
                </tr>
                <tr v-if="recapiti.sel_mail">
                  <td
                    style="
                      text-align: center;
                      font-family: Montserrat;
                      font-size: 12px !important;
                    "
                  >
                    <img
                      src="https://www.wapiti.it/wp-content/uploads/sign/Mail.png"
                      alt=""
                    />
                  </td>
                  <td
                    style="
                      text-decoration: none;
                      color: #575756;
                      font-family: Montserrat;
                      font-size: 12px !important;
                    "
                  >
                    <a
                      :href="'mailto:' + recapiti.mail"
                      style="
                        text-decoration: none;
                        color: #575756;
                        font-family: Montserrat;
                        font-size: 12px !important;
                      "
                      >{{ recapiti.mail }}</a
                    >
                  </td>
                </tr>
                <tr>
                  <td style="text-align: center; font-family: Montserrat">
                    <img
                      src="https://www.wapiti.it/wp-content/uploads/sign/Geo.png"
                      alt=""
                    />
                  </td>
                  <td v-if="recapiti.sel_indirizzo">
                    Sede Legale:
                    <a
                      :href="'https://maps.google.com/?q=' + recapiti.indirizzo"
                      style="
                        text-decoration: none;
                        color: #575756;
                        font-family: Montserrat;
                        font-size: 12px !important;
                      "
                    >
                      {{ recapiti.indirizzo }}</a
                    >
                  </td>
                  <td v-else>
                    Sede Legale:
                    <a
                      href="https://maps.google.com/?q=43122 via Giorgio Gastaldi 3, Parma"
                      style="
                        text-decoration: none;
                        color: #575756;
                        font-family: Montserrat;
                        font-size: 12px !important;
                      "
                      target="_blank"
                    >
                      43122 via Giorgio Gastaldi 3, Parma
                    </a>
                  </td>
                </tr>
                <tr v-if="recapiti.sel_operativa">
                  <td style="text-align: center; font-family: Montserrat">
                    <img
                      src="https://www.wapiti.it/wp-content/uploads/sign/Geo.png"
                      alt=""
                    />
                  </td>
                  <td>
                    Sede Operativa:
                    <a
                      :href="'https://maps.google.com/?q=' + recapiti.operativa"
                      style="
                        text-decoration: none;
                        color: #575756;
                        font-family: Montserrat;
                        font-size: 12px !important;
                      "
                    >
                      {{ recapiti.operativa }}</a
                    >
                  </td>
                </tr>
                <tr>
                  <td style="text-align: center; font-family: Montserrat">
                    <img
                      src="https://www.wapiti.it/wp-content/uploads/sign/Web.png"
                      alt=""
                    />
                  </td>
                  <td style="font-weight: 500; font-family: Montserrat">
                    <a
                      href="https://www.wapiti.it"
                      target="_blank"
                      style="
                        text-decoration: none;
                        color: #575756;
                        font-family: Montserrat;
                        font-size: 12px !important;
                      "
                      >www.wapiti.it</a
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
    <table width="100%" style="margin-top: 20px;">
      <tr>
        <td
          align="center"
          background="https://www.wapiti.it/wp-content/uploads/sign/lineaOrizzontale.png"
          style="background-repeat: no-repeat; background-position: center"
        >
          <a href="https://www.facebook.com/wapitisrl"
            ><img
              style="padding: 5px"
              src="https://www.wapiti.it/wp-content/uploads/sign/facebook.png"
              alt="" /></a
          >&nbsp;<a href="https://www.instagram.com/wapitisrl/"
            ><img
              style="padding: 5px"
              src="https://www.wapiti.it/wp-content/uploads/sign/Instagram.png"
              alt="" /></a
          >&nbsp;<a href="https://www.linkedin.com/company/wapiti-srl/"
            ><img
              style="padding: 5px"
              src="https://www.wapiti.it/wp-content/uploads/sign/Linkedin.png"
              alt="" /></a
          >&nbsp;
        </td>
      </tr>
    </table>
    <div
      align="center"
      style="font-weight: 500; font-family: Montserrat; font-size: 10px"
    >
      Wapiti Srl. - Partita IVA e Codice fiscale: 03097710341 - Nuero REA: PR-360923
    </div>
    <div
      style="
        width: 100%;
        margin-top: 20px;
        padding-top: 9px;
        border-top: 2px solid lightgray;
      "
    >
      <span
        style="
          font-family: Helvetica, sans-serif;
          color: #333333;
          line-height: 15px;
          font-size: 9px;
        "
        >
        <br/><br/><em>Avviso di riservatezza</em><br />
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
  name: "SignWapiti",
  props: ["recapiti"],
};
</script>


<style scoped>
</style>
