<template>
  <div>
    <CCardLink
      to="Statistiche"
      target="_self"
    >
      <CCard
        class="text-center elevation-6 pulsanti-azioni"
        body-wrapper
        style="background-image: url('img/buttons/statistiche.png')"
  
      >
        <CCardTitle>
          <h1>STATISTICHE</h1>
        </CCardTitle>
      </CCard>
    </CCardLink>
    <CCardLink to="Comingsoon" target="_self">
      <CCard
        class="text-center elevation-6 pulsanti-azioni"
        style="background-image: url('img/buttons/marketing.png')"
    
      >
        <CCardTitle>
          <h1>AREA COMMERCIALE</h1>
        </CCardTitle>
      </CCard>
    </CCardLink>
    <CCardLink to="Comingsoon" target="_self">
      <CCard
        class="text-center elevation-6 pulsanti-azioni"
        style="background-image: url('img/buttons/amministrazione.png')"
     
      >
        <CCardTitle>
          <h1 style="font-size: 1.4vw; line-height: 3em">AMMINISTRAZIONE</h1>
        </CCardTitle>
      </CCard>
    </CCardLink>
    <CCardLink to="AdminFormazione" target="_self">
      <CCard
        class="text-center elevation-6 pulsanti-azioni"
        body-wrapper
        style="background-image: url('img/buttons/formazione.png')"
       
      >
        <CCardTitle>
          <h1>FORMAZIONE</h1>
        </CCardTitle>
      </CCard>
    </CCardLink>
    <CCardLink to="Documentale" target="_self">
      <CCard
        class="text-center elevation-6 pulsanti-azioni"
        body-wrapper
        style="background-image: url('img/buttons/documentale.png'); z-index: 10;"
        
      >
        <CCardTitle>
          <h1>DOCUMENTALE</h1>
        </CCardTitle>
      </CCard>
    </CCardLink>
  </div>
</template>

<script>
export default {};
</script>

<style scoped>
.elevation-6 {
  box-shadow: 0 3px 5px -1px rgba(0, 0, 0, 0.2),
    0 6px 10px 0 rgba(0, 0, 0, 0.14), 0 1px 18px 0 rgba(0, 0, 0, 0.12) !important;
}
.elevation-6:hover {
  box-shadow: 0 3px 5px -1px rgba(0, 0, 0, 0.2),
    0 6px 10px 0 rgba(0, 0, 0, 0.14), 0 1px 18px 0 rgba(21, 7, 141, 0.12) !important;
  border-color: midnightblue;
}

.pulsanti-azioni {
  background-position: center;
  background-size: auto;
  max-width: 290px;
  -webkit-filter: grayscale(100%); /* Safari 6.0 - 9.0 */
  filter: grayscale(0%);
}
.pulsanti-azioni:hover {
  -webkit-filter: grayscale(0%); /* Safari 6.0 - 9.0 */
  filter: grayscale(100%);
}

.pulsanti-azioni h1 {
  color: white;
  font-weight: 800;
  text-shadow: 1px 1px midnightblue;
  font-size: 1.5vw;
  margin-bottom: 0 !important;
}

</style>