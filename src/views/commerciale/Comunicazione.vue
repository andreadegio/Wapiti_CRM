<template>
  <div style="background-color: white">
    <div class="container">
      <div class="area">Assicurazioni</div>
      <div class="data">1 Luglio 2021</div>
      <div class="titolo">Arriva ABYONE</div>
      <div class="sottotitolo">Ti presentiamo il nuovo prodotto Abyone</div>
    </div>
    <div class="copertina">
      <CImg src="../../upload/auto1.jpg" />
    </div>
    <div class="container">
      <div class="contenuto">
        Ti presentiamo tutti i servizi inclusi nel nuovo prodotto ABYONE:
        <div class="card-body">
          <div class="question pr-3 py-2">
            ✎ I SERVIZI “GIUSTO RISARCIMENTO”
          </div>
          <div class="answer text-justify">
            Hai avuto un sinistro? Chiamaci, ti aiuteremo a gestirlo al meglio,
            senza anticipare somme. A volte accadono cose spiacevoli: in questi
            casi la copertura legale su penale e ricorsi amministrativi è
            proprio quello che può aiutarti a risolvere i problemi.
          </div>
          <div class="question pr-3 mt-3 py-2">
            ✎ I SERVIZI “AMICO AVVOCATO” (civile, penale e amministrativo)
          </div>
          <div class="answer text-justify">
            A volte accadono cose spiacevoli: in questi casi è importante poter
            contare su un avvocato “amico”, a tua completa disposizione per una
            prima consulenza gratuita.
          </div>
          <div class="question pr-3 mt-3 py-2">
            ✎ I SERVIZI “MYNET” PER LA TUA PERSONA
          </div>
          <div class="answer text-justify">
            Chiama ProntoAby, ti spiegheranno come usufruire dei servizi Mynet,
            a cui hai diritto:<br />
            <div id="tabella_abyone" class="pl-3 pr-3">
              <table>
                <tr>
                  <td>✓ <i>Consulenza medica telefonica (H24)</i>:</td>
                  <td>a disposizione un medico, 24 ore su 24</td>
                </tr>
                <tr>
                  <td>✓ <i>Dentista</i>:</td>
                  <td>i centri di Dr. Smalto</td>
                </tr>
                <tr>
                  <td>✓ <i>Fisioterapia</i>:</td>
                  <td>i centri di Mr. Fisio</td>
                </tr>
                <tr>
                  <td>✓ <i>Benessere</i>:</td>
                  <td>i centri di Miss Star Bene</td>
                </tr>
                <tr>
                  <td>✓ <i>Animale domestico</i>:</td>
                  <td>strutture veterinarie convenzionate</td>
                </tr>
                <tr>
                  <td>✓ <i>Consulenza veterinaria telefonica (H24)</i>:</td>
                  <td>a disposizione un veterinario, 24 ore su 24</td>
                </tr>
              </table>
            </div>
          </div>
        </div>
      </div>
      <div class="navigazione">
        <hr />
        <div class="row">
          <div class="col-6 text-right navigazione-col">
            Precedente <br />
            <span class="prev">Proteggere auto in inverno</span>
          </div>
          <div class="col-6">
            Successiva <br />
            <span class="next">Scatola nera e sicurezza</span>
          </div>
        </div>
        <hr />
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "Comunicazione",
  props: ["notizia"],

  data() {
    return {};
  },
};
</script>

<style scoped>
.area {
  color: #0f3250;
  text-decoration: underline;
  font-size: 16px;
  line-height: 19px;
  text-transform: uppercase;
  margin-bottom: 5px;
  font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
  font-weight: 600;
}
.data {
  color: #ef7a12;
  font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
  font-size: 14px;
  line-height: 19px;
  margin-bottom: 5px;
  font-weight: 500;
}
.titolo {
  margin-bottom: 8px;
  font-size: 45px;
  line-height: 54px;
}
.sottotitolo {
  font-size: 24px;
  line-height: 29px;
  font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
  margin-bottom: 14px;
}
.copertina img {
  vertical-align: middle;
  max-height: 240px;
  width: 100%;
  object-fit: cover;
  object-position: 50% 50%;
  border: 0;
}
.navigazione {
  font-weight: lighter;
}
.navigazione span{
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    font-size: 1.5rem;
}
.navigazione-col {
  border-right: 2px solid gray;
}
.prev::before {
  content: "\f104";
  font-family: "Font Awesome 5 free";
  color: rgb(103, 103, 104);
  font-size: 2em;
  font-weight: 700;
  padding-right: 8px;
}
.next::after {
  content: "\f105";
  font-family: "Font Awesome 5 free";
  color: rgb(103, 103, 104);
  font-size: 2em;
  font-weight: 700;
  padding-left: 8px;
}
</style>