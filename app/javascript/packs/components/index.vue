<template>
  <div>
    <!-- 新規作成部分 -->
    <div class="row">
      <div class="col s2 m1">
        <div
          v-on:click="createTask"
          class="btn-floating waves-effect waves-light red"
        >
          <i class="material-icons">add</i>
        </div>
      </div>
    </div>
    <!-- リスト表示部分 -->
    <div>
      <ul class="collection">
        <li
          v-for="task in tasks"
          v-if="!task.completed"
          v-bind:id="'row_task_' + task.id"
          class="collection-item"
        >
          <input type="checkbox" v-bind:id="'task_' + task.id" />
          <label v-bind:for="'task_' + task.id">{{ task.content }}</label>
        </li>
      </ul>
    </div>
    <!-- 完了済みタスク表示ボタン -->
    <div class="btn" v-on:click="displayFinishedTasks">
      Display finished tasks
    </div>
    <!-- 完了済みタスク一覧 -->

    <!-- Modal Trigger -->
    <a class="waves-effect waves-light btn modal-trigger" href="#modal1"
      >Modal</a
    >

    <!-- Modal Structure -->
    <div id="modal1" class="modal">
      <div class="modal-content">
        <h4>Modal Header</h4>
        <input
          v-model="newTask"
          class="form-control"
          placeholder="Add your task!!"
        />
        <input
          v-model="duration"
          class="form-control"
          placeholder="所要時間を入力してください"
        />
      </div>
      <div class="modal-footer">
        <a href="#!" class="modal-close waves-effect waves-green btn-flat"
          >Agree</a
        >
        <div
          v-on:click="createTask"
          class="btn-floating waves-effect waves-light red"
        >
          追加
        </div>
      </div>
    </div>

    <div id="finished-tasks" class="display_none">
      <ul class="collection">
        <li
          v-for="task in tasks"
          v-if="task.completed"
          v-bind:id="'row_task_' + task.id"
          class="collection-item"
        >
          <input
            type="checkbox"
            v-bind:id="'task_' + task.id"
            checked="checked"
          />
          <label v-bind:for="'task_' + task.id" class="line-through">{{
            task.content
          }}</label>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data: function() {
    return {
      tasks: [],
      newTask: '',
      duration: '',
    };
  },
  mounted: function() {
    this.fetchTasks();
  },
  methods: {
    fetchTasks: function() {
      axios.get('/api/tasks').then(
        (response) => {
          for (let i = 0; i < response.data.tasks.length; i++) {
            this.tasks.push(response.data.tasks[i]);
          }
        },
        (error) => {
          console.log(error, response);
        }
      );
    },
    displayFinishedTasks: function() {
      document
        .querySelector('#finished-tasks')
        .classList.toggle('display_none');
    },
    createTask: function() {
      if (!this.newTask || !this.duration) return;
      axios
        .post('/api/tasks', {
          task: { content: this.newTask, duration: this.duration },
        })
        .then(
          (response) => {
            this.tasks.unshift(response.data.task);
            this.newTask = '';
            this.duration = '';
          },
          (error) => {
            console.log(error);
          }
        );
    },
  },
};
</script>
<style scoped>
[v-cloak] {
  display: none;
}
.display_none {
  display: none;
}
.line-through {
  text-decoration: line-through;
}
</style>
