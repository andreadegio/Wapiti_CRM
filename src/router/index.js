import Vue from "vue";
import Router from "vue-router";
// import axios from "axios";
// import store from "../store";

// Containers
const TheContainer = () => import("@/containers/TheContainer");

// Views
const Dashboard = () => import("@/views/Dashboard");

// Views - News
// const News = () => import("@/views/news/GestioneNews");
// const Elenco_news = () => import("@/views/news/Elenco_news");
const NewsOperativeBroker = () => import("@/views/news/NewsOperativeBroker");
const GestioneNewsBroker = () => import("@/views/news/GestioneNewsBroker");

// Views - Documentale
const Documentale = () => import("@/views/documentale/Documentale");
const DettagliIntermediario = () =>
  import(
    /* webpackChunkName: "Documentale" */ "@/views/documentale/DettagliIntermediario"
  );
const DettagliProponente = () =>
  import(
    /* webpackChunkName: "Documentale" */ "@/views/documentale/DettagliProponente"
  );
const Rilievi_Audit = () =>
  import(
    /* webpackChunkName: "Documentale" */ "@/views/documentale/Rilievi_Audit"
  );

// Views - Formazione
const AdminFormazione = () =>
  import(
    /* webpackChunkName: "Formazione" */ "@/views/formazione/AdminFormazione"
  );
const Formazione = () =>
  import(/* webpackChunkName: "Formazione" */ "@/views/formazione/Formazione");
const Corso = () =>
  import(/* webpackChunkName: "Formazione" */ "@/views/formazione/Corso");
const ModificaCorso = () =>
  import(
    /* webpackChunkName: "Formazione" */ "@/views/formazione/ModificaCorso"
  );

// Views - Commerciale
const AdminCommerciale = () =>
  import(
    /* webpackChunkName: "Commerciale" */ "@/views/commerciale/AdminCommerciale"
  );
const Commerciale = () =>
  import(
    /* webpackChunkName: "Commerciale" */ "@/views/commerciale/Commerciale"
  );
const Sezione = () =>
  import(/* webpackChunkName: "Commerciale" */ "@/views/commerciale/Sezione");
const Comunicazione = () =>
  import(
    /* webpackChunkName: "Commerciale" */ "@/views/commerciale/Comunicazione"
  );
const ModificaContenuti = () =>
  import(
    /* webpackChunkName: "Commerciale" */ "@/views/commerciale/ModificaContenuti"
  );

// Views - Statistiche
const Statistiche = () =>
  import(
    /* webpackChunkName: "Statistiche" */ "@/views/statistiche/Statistiche"
  );
const Accessi_stat = () => import("@/views/statistiche/Accessi_stat");
const GeneratoreFirme = () => import("@/views/GeneratoreFirme/abysign");
const Calendario = () => import("@/views/Calendario/calendario");
const Kanban = () => import("@/views/KanbanContatti/KanbanBoard");
const StatistichePortali = () =>
  import(
    /* webpackChunkName: "Statistiche" */ "@/views/statistiche/StatistichePortali"
  );
const Crm = () => import("@/views/crm/crm");

// E-learning CRM
const Elearning = () => import("@/views/e-learning/corsi");
const ElearningLogin = () => import("@/views/e-learning/ElearningLogin");

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
  routes: configRoutes(),
});

function configRoutes() {
  return [
    {
      path: "",
      redirect: "/dashboard",
      name: "Home",
      component: TheContainer,
      children: [
        {
          path: "/dashboard",
          name: "Dashboard",
          component: Dashboard,
        },
        {
          path: "/Documentale",
          name: "Documentale",
          component: Documentale,
        },
        {
          path: "/Documentale/Intermediario/",
          name: "DettagliIntermediario",
          props: true,
          component: DettagliIntermediario,
        },
        {
          path: "/Documentale/Proponente/",
          name: "DettagliProponente",
          props: true,
          component: DettagliProponente,
        },
        {
          path: "/Documentale/Dettaglio/",
          name: "Rilievi_Audit",
          props: true,
          component: Rilievi_Audit,
        },
        {
          path: "/StatistichePortali",
          name: "StatistichePortali",
          component: StatistichePortali,
        },
        {
          path: "/NewsOperative",
          name: "NewsOperativeBroker",
          component: NewsOperativeBroker,
        },
        {
          path: "/GestioneNewsBroker",
          name: "GestioneNewsBroker",
          component: GestioneNewsBroker,
        },
        {
          path: "/Formazione",
          name: "Formazione",
          component: Formazione,
        },
        {
          path: "/Formazione/Corso/:corso",
          name: "Corso",
          props: true,
          component: Corso,
        },
        {
          path: "/AdminFormazione",
          name: "AdminFormazione",
          props: true,
          component: AdminFormazione,
        },
        {
          path: "/AdminFormazione/Modifica/",
          name: "ModificaCorso",
          props: true,
          component: ModificaCorso,
        },
        {
          path: "/Commerciale",
          name: "Commerciale",
          component: Commerciale,
        },
        {
          path: "/Commerciale/:contenuto",
          name: "Sezione",
          props: true,
          component: Sezione,
        },
        {
          path: "/Commerciale/Comunicazione/:notizia",
          name: "Comunicazione",
          props: true,
          component: Comunicazione,
        },
        {
          path: "/AdminCommerciale/Modifica/",
          name: "ModificaContenuti",
          props: true,
          component: ModificaContenuti,
        },
        {
          path: "/AdminCommerciale/:settore",
          name: "AdminCommerciale_settore",
          props: true,
          component: AdminCommerciale,
        },
        {
          path: "/Comingsoon",
          name: "Comingsoon",
          component: Comingsoon,
        },
        {
          path: "/Comingsoon_gas",
          name: "Comingsoon_gas",
          component: Comingsoon_gas,
        },
        {
          path: "/Comingsoon_rami",
          name: "Comingsoon_rami",
          component: Comingsoon_rami,
        },
        {
          path: "/Comingsoon_rami2",
          name: "Comingsoon_rami2",
          component: Comingsoon_rami2,
        },
        {
          path: "/Profilo",
          name: "Profilo",
          component: Profilo,
        },
        {
          path: "/Accessi_stat",
          name: "Accessi_stat",
          component: Accessi_stat,
        },
        {
          path: "/Crm",
          name: "Crm",
          component: Crm,
        },
        {
          path: "/GeneratoreFirme",
          name: "abysign",
          component: GeneratoreFirme,
        },
        {
          path: "/Calendario",
          name: "calendario",
          component: Calendario,
        },
        {
          path: "/Kanban",
          name: "kanbanBoard",
          component: Kanban,
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
      path: "/e-learning",
      name: "E-learning",
      component: Elearning,
      meta: {
        public: true,
        requiresAuthElearning: true,
      },
    },
    {
      path: "/e-learning-login",
      name: "LoginElearning",
      component: ElearningLogin,
      meta: {
        public: true,
      },
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

    //CONTROLLO SE PROVENGO DA AUA
    if (to.query.aua == 1 && to.query.u != "" && to.query.p != "") {
      let user = atob(to.query.u);
      let passwd = atob(to.query.p);
      let data_login = new Date();
      // alert("utente" + user);
      // alert("password" + passwd);
      localStorage.setItem("user", user);
      localStorage.setItem("pwd", passwd);
      localStorage.setItem("lastLogin", data_login);
      localStorage.setItem("AUA", true);
      next();
    } else {
      localStorage.setItem("AUA", false);
    }

    if (to.query.auth == "1" || localStorage.getItem("utente") == "ok") {
      next();
    } else {
      next({
        name: "Login",
      });
    }
  } else if (to.matched.some((record) => record.meta.requiresAuthElearning)) {
    if (!isAuthenticatedElearning()) {
      // L'utente non è autenticato nella piattaforma di e-learning, reindirizzalo alla pagina di login dell'e-learning
      next({
        name: "LoginElearning",
      });
    } else {
      // L'utente è autenticato nella piattaforma di e-learning, permetti la navigazione
      next();
    }
  } else {
    next();
  }
});

// Funzione per controllare se l'utente è autenticato nella piattaforma di e-learning
function isAuthenticatedElearning() {
  return localStorage.getItem("tokenElearning") !== null;
}

router.onError((error) => {
  console.log("Errore di caricamento " + error.message);
  const targetPath = router.history.pending.fullPath;
  history.replaceState("", "", targetPath);
  router.replace(targetPath);
});

export default router;
