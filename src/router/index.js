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
const AdminFormazione = () => import(/* webpackChunkName: "Formazione" */"@/views/formazione/AdminFormazione");
const Formazione = () => import(/* webpackChunkName: "Formazione" */"@/views/formazione/Formazione");
const Corso = () => import(/* webpackChunkName: "Formazione" */"@/views/formazione/Corso");
const ModificaCorso = () => import(/* webpackChunkName: "Formazione" */"@/views/formazione/ModificaCorso");

// Views - Commerciale
const AdminCommerciale = () => import(/* webpackChunkName: "Commerciale" */"@/views/commerciale/AdminCommerciale");
const Commerciale = () => import(/* webpackChunkName: "Commerciale" */"@/views/commerciale/Commerciale");
const Sezione = () => import(/* webpackChunkName: "Commerciale" */"@/views/commerciale/Sezione");
const Comunicazione = () => import(/* webpackChunkName: "Commerciale" */"@/views/commerciale/Comunicazione");
const ModificaContenuti = () => import(/* webpackChunkName: "Commerciale" */"@/views/commerciale/ModificaContenuti");

// Views - Statistiche
const Statistiche = () => import(/* webpackChunkName: "Statistiche" */"@/views/statistiche/Statistiche");
const Accessi_stat = () => import("@/views/statistiche/Accessi_stat");
const StatistichePortali = () => import(/* webpackChunkName: "Statistiche" */"@/views/statistiche/StatistichePortali");

// Views - Page - Gas
const Comingsoon_gas = () => import("@/views/pages/Comingsoon_gas");
// Views - Page -Rami
const Comingsoon_rami = () => import("@/views/pages/Comingsoon_rami");
const Comingsoon_rami2 = () => import("@/views/pages/Comingsoon_rami2");

// Views - Pages
const Comingsoon = () => import("@/views/pages/Comingsoon");
const Profilo = () => import("@/views/pages/Profilo");
const Page404 = () => import("@/views/pages/Page404");
const Page500 = () => import("@/views/pages/Page500");
const Login = () => import("@/views/pages/Login");

Vue.use(Router);

const router = new Router({
  mode: "history",
  base: process.env.BASE_URL,
  // linkActiveClass: "active",
  // scrollBehavior: () => ({ y: 0 }),
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
          path: "StatistichePortali",
          name: "StatistichePortali",
          component: StatistichePortali,
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
          path: "Formazione/Corso/:corso",
          name: "Corso",
          props: true,
          component: Corso,
        },
        {
          path: "AdminFormazione",
          name: "AdminFormazione",
          props: true,
          component: AdminFormazione,
        },
        {
          path: "AdminFormazione/Modifica/",
          name: "ModificaCorso",
          props: true,
          component: ModificaCorso,
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
          path: "AdminCommerciale/Modifica/",
          name: "ModificaContenuti",
          props: true,
          component: ModificaContenuti,
        },
        {
          path: "AdminCommerciale/:settore",
          name: "AdminCommerciale_settore",
          props: true,
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
          path: "Comingsoon_rami",
          name: "Comingsoon_rami",
          component: Comingsoon_rami,
        },
        {
          path: "Comingsoon_rami2",
          name: "Comingsoon_rami2",
          component: Comingsoon_rami2,
        },
        {
          path: "Profilo",
          name: "Profilo",
          component: Profilo,
        },
        {
          path: "Accessi_stat",
          name: "Accessi_stat",
          component: Accessi_stat,
        },
        {
          path: "Statistiche/:portale",
          name: "Statistiche",
          props: true,
          component: Statistiche,
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

    if (to.query.auth == "1" || localStorage.getItem("utente") == "ok" && localStorage.getItem("versione") == "1" ) {
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
