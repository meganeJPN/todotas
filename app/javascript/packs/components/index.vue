<template>
  <div>
    <!-- リスト表示部分 -->
    <div class="row">
      <div class="col s12">
        <ul class="tabs">
          <li class="tab col s3">
            <a class="active" href="#working">Test 1</a>
          </li>
          <li class="tab col s3"><a href="#test2">Test 2</a></li>
        </ul>
      </div>
      <div id="working" class="col s12">Test 1</div>
      <div id="test2" class="col s12">Test 2</div>
    </div>
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
            <span v-bind:id="'task_' + task.id" class="word-color-black">
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

    <!-- タスク追加モーダル -->
    <div id="createTaskModal" class="modal">
      <div class="modal-content">
        <div class="row">
          <form class="col s12">
            <div class="row">
              <div class="input-field col s6">
                <input
                  id="input_content"
                  type="text"
                  data-length="10"
                  v-model="content"
                />
                <label for="input_content">タスク内容</label>
              </div>
            </div>
            <div class="row">
              <div class="input-field col s12">
                <textarea
                  id="input_comment"
                  class="materialize-textarea"
                  data-length="120"
                  v-model="comment"
                ></textarea>
                <label for="input_comment">コメント</label>
              </div>
            </div>
            <div class="row">
              <div class="input-field col s12">
                <input
                  id="input_duration"
                  type="number"
                  step="15"
                  min="0"
                  max="120"
                  v-model.number="duration"
                />
                <label for="input_duration">所要時間</label>
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
                  id="uppdate_conttent"
                  value="this.task.content"
                  type="text"
                  data-length="10"
                  v-model="content"
                />
                <label class="update-label" for="update_content"
                  >タスク内容</label
                >
              </div>
            </div>
            <div class="row">
              <div class="input-field col s12">
                <textarea
                  id="update-comment"
                  class="materialize-textarea active"
                  data-length="120"
                  v-model="comment"
                ></textarea>
                <label class="update-label" for="update-comment"
                  >コメント</label
                >
              </div>
            </div>
            <div class="row">
              <div class="input-field col s12">
                <input
                  id="upate_duration"
                  type="number"
                  step="15"
                  min="0"
                  max="120"
                  v-model.number="duration"
                  value="this.task.duration"
                />
                <label class="update-label" for="update-duration"
                  >所要時間</label
                >
              </div>
            </div>
          </form>
        </div>
      </div>
      <div class="modal-footer">
        <a href="#!" class="modal-close waves-effect waves-green btn">閉じる</a>
        <div
          v-on:click="deleteTask(id)"
          class="waves-effect waves-light btn modal-close"
        >
          削除
        </div>
        <div
          v-on:click="updateTask(id)"
          class="waves-effect waves-light btn modal-close"
        >
          更新
        </div>
        <div
          v-on:click="doneTask(id)"
          class="waves-effect waves-light btn modal-close"
        >
          完了
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
          <a
            class="waves-effect waves-light modal-trigger display-block"
            href="#showTaskModal"
            v-on:click="showTask(task.id)"
          >
            <span v-bind:for="'task_' + task.id" class="line-through">
              {{ task.content }}
            </span></a
          >
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import { reject } from 'lodash';

export default {
  data: function() {
    return {
      tasks: [],
      task: {},
      id: '',
      content: '',
      comment: '',
      duration: '',
      completed: '',
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
      if (!this.content || !this.duration) return;
      axios
        .post('/api/tasks', {
          task: {
            content: this.content,
            comment: this.comment,
            duration: this.duration,
          },
        })
        .then(
          (response) => {
            this.tasks.unshift(response.data.task);
            this.content = '';
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
    updateTask: function(task_id) {
      if (!this.content || !this.duration) return;
      axios
        .patch('/api/tasks/' + task_id, {
          task: {
            content: this.content,
            comment: this.comment,
            duration: this.duration,
          },
        })
        .then(
          (response) => {
            document.getElementById('task_' + task_id).innerText =
              response.data.task.content;
            this.content = '';
            this.comment = '';
            this.duration = '';
          },
          (error) => {
            console.log(error);
          }
        );
    },
    deleteTask: function(task_id) {
      axios
        .delete('/api/tasks/' + task_id, {
          task: {
            content: this.content,
            comment: this.comment,
            duration: this.duration,
          },
        })
        .then(
          (response) => {
            if (response.status === 200) {
              this.tasks = reject(this.tasks, ['id', task_id]);
            }
            this.content = '';
            this.comment = '';
            this.duration = '';
            this.completed = '';
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
          this.id = this.task.id;
          this.content = this.task.content;
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
