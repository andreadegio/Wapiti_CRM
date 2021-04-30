//  Struttura del documentale
//   DOCUMENTI BROKER
//   DOCUMENTI INTERMEDIARIO
//   SETTORE 1 E 2
//     |- RCA
//     |- ALTRE GARANZIE <- SOTTO ALBERATURA DINAMICA DAL JSON
//     |- SERVIZI NON ASSICURATIVI <- SOTTO ALBERATURA DINAMICA DAL JSON
//   RAMI
//   GAS E LUCE
// const documenti_list = [
//   {
//     nome: "DOCUMENTI DELL'INTERMEDIARIO",
//     slug: "INTERMEDIARIO",
//     tipo: "folder",
//     ico: "edit",
//     URL: "Documentale_DocumentiIntermediario",
//     childs: [],
//     subFolder: false,
//   },
//   // {
//   //   nome: "PRECONTRATTUALE",
//   //   slug: "PRECONTRATTUALE",
//   //   tipo: "folder",
//   //   ico: "edit",
//   //   URL: "Documentale_PreContrattuale",
//   //   childs: [],
//   //   subFolder: false,
//   // },

// ];
const documenti_list = [
  {
    nome: "DOCUMENTI DELL'INTERMEDIARIO",
    slug: "DOCUMENTI",
    tipo: "folder",
    ico: "edit",
    subFolder: true,
    childs: [
      {
        nome: "MECCANISMI DI DISTRIBUZIONE",
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
    nome: "SET INFORMATIVI SETTORI 1 E 2",
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
    nome: "SET INFORMATIVI SETTORI 3 E 4",
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

export { folder_list, documenti_list };
