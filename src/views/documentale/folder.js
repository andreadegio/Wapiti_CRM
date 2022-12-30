//  Struttura del documentale
const intermediari_list = [
  {
    nome: "ORGANIGRAMMA ABY BROKER",
    slug: "ORGANIGRAMMA ABY BROKER",
    tipo: "folder",
    ico: "sitemap",
    URL: "Documentale_Organigramma",
    subFolder: false,
    visible: "all",
  },
  {
    nome: "CIRCOLARI OPERATIVE",
    slug: "CIRCOLARI OPERATIVE",
    tipo: "folder",
    ico: "edit",
    URL: "CircolariOperative",
    subFolder: false,
    visible: "all",
  },
  {
    nome: "CIRCOLARI INTERNE",
    slug: "CIRCOLARI INTERNE",
    tipo: "folder",
    ico: "edit",
    URL: "CircolariInterne",
    subFolder: false,
    visible: "admin",
  },
  {
    nome: "INTERMEDIARI EMITTENTI",
    slug: "INTERMEDIARI EMITTENTI",
    tipo: "folder",
    ico: "edit",
    URL: "Intermediari_Emittenti",
    subFolder: false,
    visible: "all",
  },
  {
    nome: "INTERMEDIARI PROPONENTI",
    slug: "INTERMEDIARI PROPONENTI",
    tipo: "folder",
    ico: "edit",
    URL: "Intermediari_Proponenti",
    subFolder: false,
    visible: "admin",
  },
  {
    nome: "UNITA OPERATIVE - Sez. E",
    slug: "UNITA OPERATIVE",
    tipo: "folder",
    ico: "store",
    URL:"UnitaOperative_Di_Aby_Broker",
    subFolder: false,
    visible: "admin",
  },  
];

const documenti_list = [
  {
    nome: "DOCUMENTI DELL'INTERMEDIARIO",
    slug: "DOCUMENTI",
    tipo: "folder",
    ico: "edit",
    subFolder: true,
    childs: [
      {
        nome: "MECCANISMI DI DISTRIBUZIONE (POG)",
        slug: "INTERMEDIARIO",
        tipo: "folder",
        ico: "edit",
        URL: "Documentale_DocumentiIntermediario",
        childs: [],
        subFolder: false,
      },
      {
        nome: "PRECONTRATTUALE",
        slug: "PRECONTRATTUALE",
        tipo: "folder",
        ico: "edit",
        URL: "Documentale_PreContrattuale",
        childs: [],
        subFolder: false,
      },
    ],
  },
];

const rami_list = [
  {
    nome: "CATALOGO PRODOTTI NON AUTO",
    slug: "RAMI",
    tipo: "folder",
    childs: [],
    ico: "user-shield",
    URL: "Documentale_AltriRamiElencoSettori",
    subFolder: true,
  }
];

const folder_list = [
  {
    nome: "CATALOGO PRODOTTI AUTO",
    slug: "SETTORI 1 E 2",
    tipo: "folder",
    ico: "car",
    subFolder: true,
    childs: [
      {
        nome: "RC AUTO",
        slug: "RC_AUTO",
        tipo: "folder",
        ico: "car",
        URL: "Documentale_RCA",
        childs: [],
        subFolder: false,
      },
      {
        nome: "ALTRE GARANZIE ASSICURATIVE",
        slug: "ALTRE_GARANZIE",
        tipo: "folder",
        ico: "car",
        URL: "Documentale_AltreGaranzie",
        subFolder: true,
      },
      {
        nome: "SERVIZI NON ASSICURATIVI",
        slug: "ALTRI_SERVIZI",
        tipo: "folder",
        ico: "car",
        URL: "Documentale_ServiziNonAssicurativi",
        subFolder: true,
      },
    ],
  }
  // {
  //   nome: "GAS E LUCE",
  //   tipo: "folder",
  //   childs: [],
  //   ico: "lightbulb",
  // },
];

export { folder_list, documenti_list, intermediari_list, rami_list };
