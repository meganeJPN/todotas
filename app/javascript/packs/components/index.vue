<template>
  <div>
    <!-- リスト表示部分 -->
    <div class="row">
      <div class="col s12">
        <ul class="tabs">
          <li class="tab col s3">
            <a class="active" href="#tab-working">作業中</a>
          </li>
          <li class="tab col s3">
            <a href="#tab-completed">完了</a>
          </li>
        </ul>
      </div>
      <div id="tab-working" class="col s12">
        <div>
          <ul class="collection task-list">
            <li
              v-for="task in tasks"
              v-if="!task.completed"
              v-bind:id="'row_task_' + task.id"
              class="collection-item"
            >
              <a
                class="waves-effect waves-light modal-trigger display-block"
                href="#showTaskModal"
                v-on:click="showTask(task.id)"
              >
                <span v-bind:id="'task_' + task.id">
                  {{ task.content }}
                </span></a
              >
            </li>
          </ul>
        </div>
      </div>
      <div id="tab-completed" class="col s12">
        <div id="finished-tasks">
          <ul class="collection task-list">
            <li
              v-for="task in tasks"
              v-if="task.completed"
              v-bind:id="'row_task_completed' + task.id"
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
    </div>
    <div class="dateControl">
      <div class="row">
        <div class="col s12">
          <a
            id="next-day"
            　class="btn waves-effect waves-light"
            href="#!"
            v-on:click="currentDateNext(current_date)"
            ><i class="material-icons">navigate_before</i></a
          >
          <a
            id="today"
            class="btn waves-effect waves-light"
            href="#!"
            v-on:click="currentDateToday()"
            >Today</a
          >
          <a
            id="before-day"
            class="btn waves-effect waves-light"
            href="#!"
            v-on:click="currentDateBefore(current_date)"
            ><i class="material-icons">navigate_next</i></a
          >
        </div>
      </div>
    </div>
    <div class="schedule">
      <table class="schedule-list" border="1">
        <thead>
          <tr>
            <th></th>
            <th></th>
            <th></th>
          </tr>
        </thead>
        <tbody id="schedule-tbody">
          <tr v-for="(t, index) in time_list" v-bind:id="t">
            <td v-if="t.slice(-2) === '00'" rowspan="4" class="time">
              {{ strToTime(t) }}
            </td>
            <td
              v-if="t.slice(-2) === '00'"
              rowspan="4"
              class="assign"
              v-bind:id="'row_a_' + t"
            >
              <a
                id="add-task"
                class="btn-floating  waves-effect waves-light orange modal-trigger"
                href="#assignTaskModal"
                v-on:click="createScheduleModal(t)"
                ><i class="material-icons">add</i></a
              >
            </td>
          </tr>
        </tbody>
      </table>
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
                  data-length="50"
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
                  data-length="400"
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
                  min="15"
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
                  data-length="50"
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
                  data-length="400"
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
                  min="15"
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

    <!-- タスクアサインモーダル -->
    <div id="assignTaskModal" class="modal">
      <div class="modal-content">
        <div class="row">
          <form class="col s12">
            <p v-for="time in this.time_span">
              <label>
                <input
                  name="group1"
                  type="radio"
                  v-bind:value="time"
                  v-model="start_time"
                />
                <span>{{ time }}</span>
              </label>
            </p>
            <div class="row">
              <div class=" col s12">
                <label>タスクを選択</label>
                <select class="browser-default" v-model="task_id">
                  <option value="" disabled selected
                    >アサインするタスクを選択してください</option
                  >
                  <option
                    v-for="task in tasks"
                    v-bind:id="'select_task_' + task.id"
                    v-bind:value="task.id"
                    v-if="!task.completed"
                    >{{ task.content }} -{{ task.duration }}分</option
                  >
                </select>
              </div>
            </div>
          </form>
        </div>
      </div>
      <div class="modal-footer">
        <a href="#!" class="modal-close waves-effect waves-green btn">閉じる</a>
        <div
          v-on:click="createSchedule"
          class="waves-effect waves-light btn modal-close"
        >
          完了
        </div>
      </div>
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
      current_date: '',
      schedules: [],
      s_show_list: [],
      s_hiide_list: [],
      start_date: '',
      start_time: '',
      task_id: '',
      time_span: [],
      time_list: [
        '0800',
        '0815',
        '0830',
        '0845',
        '0900',
        '0915',
        '0930',
        '0945',
        '1000',
        '1015',
        '1030',
        '1045',
        '1100',
        '1115',
        '1130',
        '1145',
        '1200',
        '1215',
        '1230',
        '1245',
        '1300',
        '1315',
        '1330',
        '1345',
        '1400',
        '1415',
        '1430',
        '1445',
        '1500',
        '1515',
        '1530',
        '1545',
        '1600',
        '1615',
        '1630',
        '1645',
        '1700',
        '1715',
        '1730',
        '1745',
        '1800',
        '1815',
        '1830',
        '1845',
        '1900',
        '1915',
        '1930',
        '1945',
        '2000',
        '2015',
        '2030',
        '2045',
        '2100',
        '2115',
        '2130',
        '2145',
        '2200',
      ],
      schedule_list: [],
    };
  },
  mounted: function() {
    M.AutoInit();
    this.currentDateToday();
    this.fetchTasks();
    this.fetchSchedules();
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
      console.log('el');
      console.log(el);
      console.log(el.classList);
      var el_clone = el.cloneNode(true);
      el.classList.add('display_none');
      el_clone.getElementsByTagName('span')[0].classList.add('line-through');
      el_clone
        .getElementsByTagName('span')[0]
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
    fetchSchedules: function() {
      axios
        .get('/api/schedules', { params: { start_date: this.current_date } })
        .then(
          (response) => {
            for (let i = 0; i < response.data.schedules.length; i++) {
              let start_time = new Date(response.data.schedules[i].start_time);
              response.data.schedules[i].start_time =
                start_time
                  .getHours()
                  .toString()
                  .padStart(2, '0') +
                ':' +
                start_time
                  .getMinutes()
                  .toString()
                  .padStart(2, 0);
              console.log(response.data.schedules[i].start_time);
              let end_time = new Date(response.data.schedules[i].end_time);
              response.data.schedules[i].end_time =
                end_time
                  .getHours()
                  .toString()
                  .padStart(2, '0') +
                ':' +
                end_time
                  .getMinutes()
                  .toString()
                  .padStart(2, 0);

              this.schedules.push(response.data.schedules[i]);
            }
            this.createBlankScheduleTable();
            for (let j = 0; j < response.data.s_show_list.length; j++) {
              console.log('要素採れた？');
              console.log(response.data.s_show_list[j].row_id);
              console.log('row_s_' + response.data.s_show_list[j].row_id);
              console.log(
                document.getElementById(
                  'row_s_' + response.data.s_show_list[j].row_id
                )
              );
              document.getElementById(
                'row_s_' + response.data.s_show_list[j].row_id
              ).innerText = response.data.s_show_list[j].task.content;
              this.s_show_list.push(response.data.s_show_list[j]);
              document
                .getElementById('row_s_' + response.data.s_show_list[j].row_id)
                .setAttribute('rowSpan', response.data.s_show_list[j].rowspan);
              this.s_show_list.push(response.data.s_show_list[j]);
            }
            response.data.s_hide_list.forEach(function(row_h_id) {
              console.log('削除する要素は');
              console.log(document.getElementById('row_s_' + row_h_id));
              let remove_el = document.getElementById('row_s_' + row_h_id);
              if (remove_el) {
                console.log('本当に消えるのは');
                console.log(document.getElementById('row_s_' + row_h_id));
                document.getElementById('row_s_' + row_h_id).remove();
              }
            });
            this.s_hide_list = response.data.s_hide_list;
            console.log('this.s_show_list');
            console.log(this.s_show_list);
            console.log('this.s_show_list');
            console.log(this.s_hide_list);
          },
          (error) => {
            console.log(error, response);
          }
        );
    },
    createScheduleModal: function(base_time) {
      console.log('時間は取得できていますか？');
      console.log(base_time);
      console.log(this.time_list);
      let base_time_index = this.time_list.findIndex((i) => i === base_time);
      console.log(base_time_index);
      let time_span_str = this.time_list.slice(
        base_time_index,
        base_time_index + 4
      );

      this.time_span = time_span_str.map(this.strToTime);
      console.log(this.time_span);
    },
    createSchedule: function() {
      if (!this.current_date || !this.start_time || !this.task_id) return;
      axios
        .post('/api/schedules', {
          schedule: {
            start_date: this.current_date,
            start_time: this.start_time,
            task_id: this.task_id,
          },
        })
        .then(
          (response) => {
            this.schedules.unshift(response.data.schedule);
            this.start_time = '';
            this.task_id = '';
            this.createBlankScheduleTable();
            this.fetchSchedules();
          },
          (error) => {
            console.log(error);
          }
        );
    },
    createBlankScheduleTable: function() {
      console.log('createBlankScheduleTable呼ばれてる？');
      let tbody_schedule = document.getElementById('schedule-tbody');
      this.time_list.forEach(function(time) {
        let tr_element = document.getElementById(time);
        if (document.getElementById(`row_s_${time}`) === null) {
          console.log(`row_s_${time}の時は削除`);
          let td_schedule = document.createElement('td');
          let td_assign = document.getElementById(`row_a_${time}`);
          td_schedule.id = `row_s_${time}`;
          tr_element.insertBefore(td_schedule, td_assign);
        } else {
          document.getElementById(`row_s_${time}`).innerText = '';
          document.getElementById(`row_s_${time}`).setAttribute('rowSpan', 1);
          console.log(`row_s_${time}の時はリセット`);
          console.log(document.getElementById(`row_s_${time}`));
        }
        console.log(tr_element);
      });
    },

    createScheduleHash: function() {},
    strToTime: function(str) {
      return `${str.substr(0, 2)}:${str.substr(2, 2)}`;
    },
    durationToEndTime: function(time, duration) {
      endTime = time;
    },
    currentDateToday: function() {
      let now = new Date();
      this.current_date = now;
      console.log(`今日は${this.current_date}です。`);
      this.fetchSchedules();
      console.log('this.tasks');
      console.log(this.tasks);
    },
    currentDateNext: function(day) {
      console.log('実行前のcurrent_dateは');
      console.log(this.current_date);
      this.currrent_day = day.setDate(day.getDate() + 1);
      console.log(`${this.current_date}にカレントデイトを変更しました`);
      this.fetchSchedules();
    },
    currentDateBefore: function(day) {
      console.log('実行前のcurrent_dateは');
      console.log(this.current_date);
      this.currrent_day = day.setDate(day.getDate() - 1);
      console.log(`${this.current_date}にカレントデイトを変更しました`);
      this.fetchSchedules();
    },
  },
};
</script>
<style>
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
.task-list {
  height: 30vh;
  overflow: scroll;
  /* IE, Edge 対応 */
  -ms-overflow-style: none;
  /* Firefox 対応 */
  scrollbar-width: none;
}

.schedule {
  height: 30vh;
  overflow: scroll;
  /* IE, Edge 対応 */
  -ms-overflow-style: none;
  /* Firefox 対応 */
  scrollbar-width: none;
}

/* Chrome, Safari 対応 */
.box::-webkit-scrollbar {
  display: none;
}
td.time {
  vertical-align: top;
  width: 80px;
}
td.assign {
  text-align: center;
  width: 80px;
}
.dateControl {
  text-align: center;
}

#next-day {
}
#today {
  margin-left: 40px;
  margin-right: 40px;
}
#before-day {
}
</style>
