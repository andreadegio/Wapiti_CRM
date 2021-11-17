<template>

  <CHeader fixed with-subheader light class="d-flex justify-content-between fixed-nav">
 
    <CHeaderNav class="d-md-down-none mr-auto">
      <CHeaderNavLink to="/dashboard" exact>
      <CHeaderNavItem class="px-3">
       <img v-if="this.$route.path != '/dashboard'" src="/img/logo_abyway.png" width="200px" v-c-tooltip="{content:'Clicca qui per tornare alla HOME', placement:'right'}">
       <img v-else src="/img/logo_abyway.png" width="200px" >
      </CHeaderNavItem>
      </CHeaderNavLink>
      
    </CHeaderNav>
    
    <CHeaderNav class="mr-4">
     
      <CHeaderNavItem class="d-md-down-none mx-2" v-c-tooltip="{content:'Clicca qui per tornare INDIETRO', placement:'bottom-end'}" >
        <button @click="$router.go(-1)"  >
        <CHeaderNavLink v-show="this.$route.path != '/dashboard'" >
          <CIcon id="icona_indietro" :content="$options.back_ico" size="2xl"/>
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
  
  import { cilArrowCircleLeft   } from "@coreui/icons";
import TheHeaderDropdownAccnt from "./TheHeaderDropdownAccnt";

export default {
  name: "TheHeader",
  back_ico: cilArrowCircleLeft,
  components: {
    TheHeaderDropdownAccnt,
  },
};
</script>


