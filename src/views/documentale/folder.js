//  Struttura del documentale
const intermediari_list =[
  {
    nome: "INTERMEDIARI EMITTENTI",
    slug: "INTERMEDIARI EMITTENTI",
    tipo: "folder",
    ico: "edit",
    subFolder: false,
    visible: "all"
  },
  {
    nome: "INTERMEDIARI PROPONENTI",
    slug: "INTERMEDIARI PROPONENTI",
    tipo: "folder",
    ico: "edit",
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
  },

  {
    nome: "CATALOGO PRODOTTI NON AUTO",
    slug: "RAMI",
    tipo: "folder",
    childs: [],
    ico: "user-shield",
    URL: undefined,
    subFolder: false,
  },
  // {
  //   nome: "GAS E LUCE",
  //   tipo: "folder",
  //   childs: [],
  //   ico: "lightbulb",
  // },
];

export { folder_list, documenti_list, intermediari_list };
