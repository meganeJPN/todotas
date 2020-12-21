<template>
  <div>
    <!-- Dropdown Structure -->
    <div class=" navbar-fixed">
      <nav>
        <div class="nav-wrapper container">
          <a href="/" class="brand-logo left">Todo Application</a>
          <a href="#" class="sidenav-trigger right" data-target="mobile-links">
            <i class="material-icons">menu</i>
          </a>
          <div class="menu">
            <ul class="right hide-on-med-and-down">
              <li>
                <router-link to="/" class="grey-text text-lighten-3"
                  >Top</router-link
                >
              </li>
              <li>
                <router-link to="/user" class="grey-text text-lighten-3"
                  >ユーザー情報</router-link
                >
              </li>
            </ul>
          </div>
        </div>
      </nav>
    </div>

    <ul class="sidenav" id="mobile-links">
      <!--ハンバーガーメニューの閉じるアイコン-->
      <a href="#" class="sidenav-close " data-target="mobile-links">
        <i class="material-icons close-icon">close</i>
      </a>
      <div class="menu">
        <li>
          <router-link to="/">Top</router-link>
        </li>
        <li>
          <router-link to="/user""
            >ユーザー情報</router-link
          >
        </li>
      </div>
    </ul>
  </div>
</template>
