<template>
  <div id="app" class="container-fluid">
    <div>
      <b-navbar type="dark" variant="dark">
        <b-navbar-nav>
          <b-nav-item href="#/">Home</b-nav-item>
          <b-nav-item href="#/tableList">Crud-Table</b-nav-item>
          <b-nav-item href="#/ajax">Ajax</b-nav-item>
          <b-nav-item href="#/about">About</b-nav-item>
        </b-navbar-nav>
      </b-navbar>
    </div>

    <router-view />
  </div>
</template>

<style>
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
#nav {
  padding: 30px;
}

#nav a {
  font-weight: bold;
  color: #2c3e50;
}

#nav a.router-link-exact-active {
  color: #42b983;
}
</style>
