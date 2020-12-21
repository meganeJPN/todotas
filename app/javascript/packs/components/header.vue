<template>
  <div>
    <!-- Dropdown Structure -->
    <div class=" navbar-fixed">
      <nav>
        <div class="nav-wrapper container">
          <a href="/" class="brand-logo left">Todo Application</a>
          <!--ハンバーガーメニューの開くアイコン-->
          <a href="#" class="sidenav-trigger right" data-target="mobile-links">
            <i class="material-icons">menu</i>
          </a>

          <div class="menu">
            <ul class="right hide-on-med-and-down">
              <li>
                <a href="#" class="grey-text text-lighten-3">Contents1</a>
              </li>
              <li>
                <a href="#" class="grey-text text-lighten-3">Contents2</a>
              </li>
              <li>
                <a href="#" class="grey-text text-lighten-3">Contents3</a>
              </li>
              <li>
                <a href="#" class="grey-text text-lighten-3">Contents4</a>
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
        <li><a href="#">Contents1</a></li>
        <li><a href="#">Contents2</a></li>
        <li><a href="#">Contents3</a></li>
        <li><a href="#">Contents4</a></li>
      </div>
    </ul>
  </div>
</template>
