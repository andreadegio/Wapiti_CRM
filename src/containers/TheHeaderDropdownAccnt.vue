<template>
  <CDropdown
    inNav
    class="c-header-nav-items"
    placement="bottom-end"
    add-menu-classes="pt-0"
  >
    <template #toggler>
      <CHeaderNavLink>
        <div class="c-avatar" style="background-color:#0b4a9b; color: white; ">
          <CIcon name="cil-user" style="margin-right: 0 !important;"/>
          <!-- <img src="img/avatars/7.jpg" class="c-avatar-img" /> -->
        </div>
      </CHeaderNavLink>
    </template>
    <CDropdownHeader tag="div" class="text-center" color="light">
      <strong>Account</strong>
    </CDropdownHeader>
    <CDropdownItem @click="$router.push('Profilo')"> <CIcon name="cil-user" /> Profilo </CDropdownItem>
    <!-- <CDropdownItem>
      <CIcon name="cil-bell"/> Updates
      <CBadge color="info" class="mfs-auto">{{ itemsCount }}</CBadge>
    </CDropdownItem>
    <CDropdownItem>
      <CIcon name="cil-envelope-open" /> Messages
      <CBadge color="success" class="mfs-auto">{{ itemsCount }}</CBadge>
    </CDropdownItem>
    <CDropdownItem>
      <CIcon name="cil-task" /> Tasks
      <CBadge color="danger" class="mfs-auto">{{ itemsCount }}</CBadge>
    </CDropdownItem>
    <CDropdownItem>
      <CIcon name="cil-comment-square" /> Comments
      <CBadge color="warning" class="mfs-auto">{{ itemsCount }}</CBadge>
    </CDropdownItem> -->
    <!-- <CDropdownHeader
      tag="div"
      class="text-center"
      color="light"
    >
      <strong>Settings</strong>
    </CDropdownHeader>
    
    <CDropdownItem>
      <CIcon name="cil-settings" /> Settings
    </CDropdownItem>
    <CDropdownItem>
      <CIcon name="cil-dollar" /> Payments
      <CBadge color="secondary" class="mfs-auto">{{ itemsCount }}</CBadge>
    </CDropdownItem>
    <CDropdownItem>
      <CIcon name="cil-file" /> Projects
      <CBadge color="primary" class="mfs-auto">{{ itemsCount }}</CBadge>
    </CDropdownItem>
    <CDropdownDivider/>
    <CDropdownItem>
      <CIcon name="cil-shield-alt" /> Lock Account
    </CDropdownItem> -->
    <CDropdownItem @click="$router.push('login')">
      <!-- <CHeaderNavLink to="login"> -->
        <CIcon :content="$options.logout_ico" /> Logout
      <!-- </CHeaderNavLink> -->
    </CDropdownItem>
  </CDropdown>
</template>

<script>
import { cilAccountLogout } from "@coreui/icons";
import store from '../store';
export default {
  name: "TheHeaderDropdownAccnt",
  logout_ico: cilAccountLogout,
  data() {
    return {
      itemsCount: 42,
    };
  },
  beforeDestroy(){
    store.commit("user_logout");
  }
};
</script>

<style scoped>
.c-icon {
  margin-right: 0.3rem;
}
</style>