<template>

  <CHeader fixed with-subheader light class="d-flex justify-content-between fixed-nav">
 
    <CHeaderNav class="d-md-down-none mr-auto">
      <CHeaderNavLink to="/dashboard" exact>
      <CHeaderNavItem class="px-3">
       <img src="img/logo_abyway.png" width="200px">
      </CHeaderNavItem>
      </CHeaderNavLink>
      
    </CHeaderNav>
    
    <CHeaderNav class="mr-4">
      <CHeaderNavItem class="d-md-down-none mx-2">
        <CHeaderNavLink>
          <CIcon name="cil-bell" />
        </CHeaderNavLink>
      </CHeaderNavItem>
       <CHeaderNavItem class="d-md-down-none mx-2">
        <CHeaderNavLink>
          <CIcon name="cil-envelope-open" />
        </CHeaderNavLink>
      </CHeaderNavItem>
      <TheHeaderDropdownAccnt />
    </CHeaderNav>

  </CHeader>




</template>

<script>
import TheHeaderDropdownAccnt from "./TheHeaderDropdownAccnt";

export default {
  name: "TheHeader",
  components: {
    TheHeaderDropdownAccnt,
  },
};
</script>

