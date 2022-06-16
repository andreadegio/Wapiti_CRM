module.exports = {
  lintOnSave: false,
  runtimeCompiler: true,
  publicPath: "",
  configureWebpack: {
    resolve: {
      symlinks: false,
    },
  },
  transpileDependencies: ["@coreui/utils", "@coreui/vue", "vuetify"],
  // publicPath:process.env.NODE_ENV === 'production'? '': '/'
};
