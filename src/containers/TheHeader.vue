<template>
  <!-- <CHeader fixed with-subheader light class="d-flex justify-content-between fixed-nav"> -->
  <CHeader
    fixed
    with-subheader
    light
    class="c-header c-header-light c-header-fixed c-header-with-subheader"
  >
    <CHeaderNav class="d-md-down-none mr-auto">
      <CHeaderNavLink to="/dashboard" exact>
        <CHeaderNavItem class="px-3">
          <img
            v-if="this.$route.path != '/dashboard'"
            src="/img/logo_abyway.png"
            width="200px"
            v-c-tooltip="{
              content: 'Clicca qui per tornare alla HOME',
              placement: 'right',
            }"
          />
          <img v-else src="/img/logo_abyway.png" width="200px" />
        </CHeaderNavItem>
      </CHeaderNavLink>
    </CHeaderNav>
    <CHeaderNav v-if="city != ''" class="d-md-down-none mr-auto">
      <CHeaderNavItem class="px-3">
        <h4><em>{{city}}  {{temp}}°C  </em> 
        <img :src = ico_meteo v-c-tooltip="{ content: desc_meteo, placement: 'bottom-end' }"/></h4>
        
      </CHeaderNavItem>
    </CHeaderNav>
    <a
      href="../dashboard"
      class="c-header-brand mx-auto d-lg-none router-link-active"
    >
      <img
        v-if="this.$route.path != '/dashboard'"
        src="/img/logo_abyway.png"
        style="scale: 60%"
        v-c-tooltip="{
          content: 'Clicca qui per tornare alla HOME',
          placement: 'right',
        }"
      />
      <img v-else src="/img/logo_abyway.png" style="scale: 60%" />
    </a>
    <CHeaderNav class="mr-4">
      <CHeaderNavItem
        class="d-md-down-none mx-2"
        v-c-tooltip="{
          content: 'Clicca qui per tornare INDIETRO',
          placement: 'bottom-end',
        }"
      >
        <button @click="$router.go(-1)">
          <CHeaderNavLink v-show="this.$route.path != '/dashboard'">
            <CIcon
              id="icona_indietro"
              :content="$options.back_ico"
              size="2xl"
            />
          </CHeaderNavLink>
        </button>
      </CHeaderNavItem>

      <!-- <CHeaderNavItem class="d-md-down-none mx-2">
        <CHeaderNavLink>
          <CIcon name="cil-envelope-open" />
        </CHeaderNavLink>
      </CHeaderNavItem> -->
      <TheHeaderDropdownAccnt />
    </CHeaderNav>
  </CHeader>
</template>

<script>
import { cilArrowCircleLeft } from "@coreui/icons";
import TheHeaderDropdownAccnt from "./TheHeaderDropdownAccnt";
import axios from "axios";

export default {
  name: "TheHeader",
  back_ico: cilArrowCircleLeft,
  components: {
    TheHeaderDropdownAccnt,
  },
  data() {
    return {
      city: "",
      temp: "",
      desc_meteo: "",
      ico_meteo: "",
    };
  },
  mounted(){
    this.meteo();
  },
  methods:{
     meteo() {
      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(this.showPosition);
      } else {
        console.log("Geolocation is not supported by this browser.");
      }
    },
    showPosition(position) {
      // console.log("Latitudine: " + position.coords.latitude);
      // console.log("Longitudine: " + position.coords.longitude);
      let latitude = position.coords.latitude;
      let longitude = position.coords.longitude;
      // console.log("url meteo " + this.$custom_json.url_meteo);
      let url = this.$custom_json.url_meteo + "?appid="+this.$custom_json.token_meteo
      +"&lat="+latitude+"&lon="+longitude+"&units=metric&lang=it";

      try {
        axios.get(url).then((response) => {
          console.log("Dati meteo: " + JSON.stringify(response.data.name));
          this.city= response.data.name;
          this.temp= response.data.main.temp.toString().split(".")[0];
          this.desc_meteo = response.data.weather[0].description;
          this.ico_meteo = "/img/meteo/"+response.data.weather[0].icon+".png";
        });
      } catch (error) {
        console.log("impossibile recuperare i dati meteo" + error);
      }
    },
  }
};
</script>


