// vue.config.js
module.exports = {
  devServer: {
    port: 8081,
    proxy: {
      '^/api': {
        target: 'http://localhost:8090/',
        ws: true,
        changeOrigin: true
      }
    }
  }
}
