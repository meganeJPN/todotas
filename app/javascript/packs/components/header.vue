<template>
  <div>
    <nav class="navbar navbar-dark bg-dark">
      <a href="#" class="navbar-brand">todotas</a>
      <div class="dropdown">
        <button
          type="button"
          id="dropdownMenuButton"
          class="btn btn-secondary dropdown-toggle"
          data-toggle="dropdown"
          aria-haspopup="true"
          aria-expanded="false"
        >
          ユーザー名
        </button>
        <div
          class="dropdown-menu"
          aria-labelledby="dropdownMenuButton"
          style="z-index:9999"
        >
          <a class="dropdown-item" href="#">ユーザ情報</a>
          <a class="dropdown-item" href="#">ログアウト</a>
        </div>
      </div>
    </nav>
  </div>
</template>
