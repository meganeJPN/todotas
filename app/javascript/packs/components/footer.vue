<template>
  <footer class="page-footer">
    <div class="container">
      <div class="row">
        <a
          id="add-task"
          class="btn-floating btn-large waves-effect waves-light orange modal-trigger"
          href="#createTaskModal"
          ><i class="material-icons">add</i></a
        >
      </div>
    </div>
  </footer>
</template>

<style scoped>
footer {
  position: absolute;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 100px;
}
.row {
  position: relative;
}
#next-day {
  position: absolute;
  left: 0;
}
#add-task {
  position: absolute;
  left: 0;
  right: 0;
  top: 0;
  margin: auto;
}
#before-day {
  position: absolute;
  right: 0;
}
</style>
