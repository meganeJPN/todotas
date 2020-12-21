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
          v-bind:id="'row_task_' + task.id"
          class="collection-item"
          v-for="task in tasks"
          v-if="!task.completed"
        >
          <a
            class="waves-effect waves-light modal-trigger display-block"
            href="#showTaskModal"
            v-on:click="showTask(task.id)"
          >
            <span v-bind:for="'task_' + task.id" class="word-color-black">
              {{ task.content }}
            </span></a
          >
        </li>
      </ul>
    </div>
    <!-- 完了済みタスク表示ボタン -->
    <div class="btn" v-on:click="displayFinishedTasks">
      Display finished tasks
    </div>
    <!-- 完了済みタスク一覧 -->

    <!-- Modal Trigger -->
    <a
      class="waves-effect waves-light btn modal-trigger"
      href="#createTaskModal"
      >Modal</a
    >

    <!-- タスク追加モーダル -->
    <div id="createTaskModal" class="modal">
      <div class="modal-content">
        <div class="row">
          <form class="col s12">
            <div class="row">
              <div class="input-field col s6">
                <input
                  id="input_text"
                  type="text"
                  data-length="10"
                  v-model="newTask"
                />
                <label for="input_text">タスク内容</label>
              </div>
            </div>
            <div class="row">
              <div class="input-field col s12">
                <textarea
                  id="textarea2"
                  class="materialize-textarea"
                  data-length="120"
                ></textarea>
                <label for="textarea2">コメント</label>
              </div>
            </div>
            <div class="row">
              <div class="input-field col s12">
                <select v-model="duration">
                  <option value="15">15</option>
                  <option value="30">30</option>
                  <option value="45">45</option>
                </select>
                <label>所要時間</label>
              </div>
            </div>
          </form>
        </div>
      </div>
      <div class="modal-footer">
        <a href="#!" class="modal-close waves-effect waves-green btn">閉じる</a>
        <div v-on:click="createTask" class="waves-effect waves-light btn">
          追加
        </div>
      </div>
    </div>

    <!-- タスク詳細モーダル -->
    <div id="showTaskModal" class="modal">
      <div class="modal-content">
        <h4>タスク詳細</h4>
        <div class="row">
          <form class="col s12">
            <div class="row">
              <div class="input-field col s6">
                <input
                  id="uppdate_text"
                  value="this.task.content"
                  type="text"
                  data-length="10"
                  v-model="newTask"
                />
                <label class="update-label" for="update_text">タスク内容</label>
              </div>
            </div>
            <div class="row">
              <div class="input-field col s12">
                <textarea
                  id="textarea2"
                  class="materialize-textarea active"
                  data-length="120"
                  v-model="comment"
                ></textarea>
                <label class="update-label" for="textarea2">コメント</label>
              </div>
            </div>
            <div class="row">
              <div class="input-field col s12">
                <select v-model="duration">
                  <option value="15">15</option>
                  <option value="30">30</option>
                  <option value="45">45</option>
                </select>
                <label class="update-label">所要時間</label>
              </div>
            </div>
          </form>
        </div>
      </div>
      <div class="modal-footer">
        <a href="#!" class="modal-close waves-effect waves-green btn">閉じる</a>
        <div v-on:click="createTask" class="waves-effect waves-light btn">
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
      task: {},
      newTask: '',
      commnet: '',
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
            this.comment = '';
            this.duration = '';
          },
          (error) => {
            console.log(error);
          }
        );
    },
    doneTask: function(task_id) {
      axios.put('/api/tasks/' + task_id, { task: { completed: true } }).then(
        (response) => {
          this.moveFinishedTask(task_id);
        },
        (error) => {
          console.log(error);
        }
      );
    },
    moveFinishedTask: function(task_id) {
      var el = document.querySelector('#row_task_' + task_id);
      var el_clone = el.cloneNode(true);
      el.classList.add('display_none');
      el_clone.getElementsByTagName('input')[0].checked = 'checked';
      el_clone.getElementsByTagName('label')[0].classList.add('line-through');
      el_clone
        .getElementsByTagName('label')[0]
        .classList.remove('word-color-black');
      var li = document.querySelector('#finished-tasks > ul > li:first-child');
      document.querySelector('#finished-tasks > ul').insertBefore(el_clone, li);
    },
    showTask: function(task_id) {
      console.log('shoTaskだよ');
      console.log(task_id);
      var elements = document.querySelectorAll('.update-label');
      elements.forEach(function(element) {
        element.classList.add('active');
      });

      axios.get('/api/tasks/' + task_id).then(
        (response) => {
          this.task = response.data.task;
          this.newTask = this.task.content;
          this.comment = this.task.comment;
          this.duration = this.task.duration;
          console.log(this.task);
        },
        (error) => {
          console.log(error, response);
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
.display-block {
  display: block;
}
</style>
