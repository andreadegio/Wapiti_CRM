import Vue from "vue";
import Router from "vue-router";
// import store from "../store";

// Containers
const TheContainer = () => import("@/containers/TheContainer");

// Views
const Dashboard = () => import("@/views/Dashboard");

// Views - News
const News = () => import("@/views/news/GestioneNews");
const Elenco_news = () => import("@/views/news/Elenco_news");
const NewsOperativeBroker = () => import("@/views/news/NewsOperativeBroker");
const GestioneNewsBroker = () => import("@/views/news/GestioneNewsBroker");

// Views - Documentale
const Documentale = () => import("@/views/documentale/Documentale");

// Views - Formazione
const AdminFormazione = () => import("@/views/formazione/AdminFormazione");
const Formazione = () => import("@/views/formazione/Formazione");


// Views - Commerciale
const AdminCommerciale = () => import("@/views/commerciale/AdminCommerciale");
const Commerciale = () => import("@/views/commerciale/Commerciale");
const Sezione = () => import("@/views/commerciale/Sezione");
const Comunicazione =() => import("@/views/commerciale/Comunicazione");

// Views - Statistiche
const Statistiche = () => import("@/views/statistiche/Statistiche");

// Views - Page - Gas
const Comingsoon_gas = () => import("@/views/pages/Comingsoon_gas");

// Views - Pages
const Comingsoon = () => import("@/views/pages/Comingsoon");
const Profilo = () => import("@/views/pages/Profilo");
const Page404 = () => import("@/views/pages/Page404");
const Page500 = () => import("@/views/pages/Page500");
const Login = () => import("@/views/pages/Login");

Vue.use(Router);

const router = new Router({
  mode: "history",
  linkActiveClass: "active",
  scrollBehavior: () => ({ y: 0 }),
  routes: configRoutes(),
});

function configRoutes() {
  return [
    {
      path: "/",
      redirect: "/dashboard",
      name: "Home",
      component: TheContainer,
      children: [
        {
          path: "dashboard",
          name: "Dashboard",
          component: Dashboard,
        },
        {
          path: "Gestione_news_Mondo",
          name: "GestioneNews",
          component: News,
        },
        {
          path: "Elenco_news",
          name: "Elenco_news",
          component: Elenco_news,
        },
        {
          path: "Documentale",
          name: "Documentale",
          component: Documentale,
        },
        {
          path: "Statistiche",
          name: "Statistiche",
          component: Statistiche,
        },
        {
          path: "NewsOperative",
          name: "NewsOperativeBroker",
          component: NewsOperativeBroker,
        },
        {
          path: "GestioneNewsBroker",
          name: "GestioneNewsBroker",
          component: GestioneNewsBroker,
        },
        {
          path: "Formazione",
          name: "Formazione",
          component: Formazione,
        },
        {
          path: "AdminFormazione",
          name: "AdminFormazione",
          component: AdminFormazione,
        },
        {
          path: "Commerciale",
          name: "Commerciale",
          component: Commerciale,
        },
        {
          path: "Commerciale/:contenuto",
          name: "Sezione",
          props: true,
          component: Sezione,
        },
        {
          path: "Commerciale/Comunicazione/:notizia",
          name: "Comunicazione",
          props: true,
          component: Comunicazione,
        },
        {
          path: "AdminCommerciale",
          name: "AdminCommerciale",
          component: AdminCommerciale,
        },
        {
          path: "Comingsoon",
          name: "Comingsoon",
          component: Comingsoon,
        },
        {
          path: "Comingsoon_gas",
          name: "Comingsoon_gas",
          component: Comingsoon_gas,
        },
        {
          path: "Profilo",
          name: "Profilo",
          component: Profilo,
        },
      ],
      meta: { requiresAuth: true },
    },
    {
      path: "/login",
      name: "Login",
      component: Login,
      meta: {
        public: true,
        onlyWhenLoggedOut: true,
      },
    },
    {
      path: "*",
      redirect: "404",
      name: "Pages",
      component: {
        render(c) {
          return c("router-view");
        },
      },
      children: [
        {
          path: "404",
          name: "Page404",
          component: Page404,
        },
        {
          path: "500",
          name: "Page500",
          component: Page500,
        },
      ],
    },
  ];
}
router.beforeEach((to, from, next) => {
  if (to.matched.some((record) => record.meta.requiresAuth)) {
    if (localStorage.getItem("userID") == -1) {
      next({
        name: "Login",
      });
    }

    if (to.query.auth == "1" || localStorage.getItem("utente") == "ok") {
      next();
    } else {
      next({
        name: "Login",
      });
    }
  } else {
    next();
  }
});

export default router;
