// See more at https://hyper.is#cfg and https://github.com/vercel/hyper/blob/canary/app/config/config-default.js
module.exports = {
  // Core
  config: {
    bell: false,
    copyOnSelect: true,
    css: `.splitpane_divider { background-color: white !important; }`,
    cursorShape: "BEAM",
    fontFamily: "'MesloLGS Nerd Font', monospace",
  },

  // Plugins
  plugins: ["hyper-highlight-active-pane", "hyper-one-dark", "hyper-search"],
  localPlugins: [],

  // Key bindings
  keymaps: {},
};
