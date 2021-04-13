//  Struttura del documentale
//   DOCUMENTI BROKER
//   DOCUMENTI INTERMEDIARIO
//   SETTORE 1 E 2
//     |- RCA
//     |- ALTRE GARANZIE <- SOTTO ALBERATURA DINAMICA DAL JSON
//   RAMI
//   GAS E LUCE
const documenti_list = [
  {
    nome: "DOCUMENTI DELL'INTERMEDIARIO",
    tipo: "folder",
    ico: "edit",
    childs: [],
  },
];

const folder_list = [
  {
    nome: "SETTORI 1 E 2",
    tipo: "folder",
    ico: "car",
    childs: [
      {
        nome: "RC AUTO",
        slug: "RC_AUTO",
        tipo: "folder",
        ico: "car",
        childs: [],
      },
      {
        nome: "ALTRE GARANZIE ASSICURATIVE",
        slug: "ALTRE_GARANZIE",
        tipo: "folder",
        ico: "car",
      },
      {
        nome: "ALTRI SERVIZI",
        slug: "ALTRI_SERVIZI",
        tipo: "folder",
        ico: "car",
      },
    ],
  },

  {
    nome: "SETTORI 3 E 4",
    slug: "RAMI",
    tipo: "folder",
    childs: [],
    ico: "user-shield",
  },
  // {
  //   nome: "GAS E LUCE",
  //   tipo: "folder",
  //   childs: [],
  //   ico: "lightbulb",
  // },
];

export  {folder_list, documenti_list};
