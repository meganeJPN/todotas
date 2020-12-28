<template> </template>

<template>
  <div>
    <el-tabs type="border-card">
      <el-tab-pane>
        <span slot="label"><i class="el-icon-edit-outline"></i>Working</span>
        <el-table :data="tasks_working" style="width: 100%">
          <el-table-column label="" width="400">
            <template slot-scope="scope">
              <el-popover trigger="hover" placement="top">
                <p>タスク: {{ scope.row.content }}</p>
                <p>所要時間: {{ scope.row.duration }}分</p>
                <div slot="reference" class="name-wrapper">
                  <i class="el-icon-time"></i
                  ><el-button
                    type="text"
                    @click="dialogShowTask(scope.$index, scope.row)"
                    ><span style="margin-left: 10px">{{
                      scope.row.content
                    }}</span></el-button
                  >
                </div>
              </el-popover>
            </template>
          </el-table-column>
          <el-table-column label="">
            <template slot-scope="scope">
              <el-button
                type="primary"
                icon="el-icon-check"
                size="mini"
                @click="doneTask(scope.$index, scope.row)"
              ></el-button>
            </template>
          </el-table-column>
        </el-table>
      </el-tab-pane>
      <el-tab-pane
        ><span slot="label"><i class="el-icon-finished"></i>Finished</span>

        <el-table :data="tasks_finished" style="width: 100%">
          <el-table-column label="Name" width="400">
            <template slot-scope="scope">
              <el-popover trigger="hover" placement="top">
                <p>タスク: {{ scope.row.content }}</p>
                <p>所要時間: {{ scope.row.duration }}分</p>
                <div slot="reference" class="name-wrapper">
                  <i class="el-icon-time"></i>
                  <span style="margin-left: 10px">{{ scope.row.content }}</span>
                </div>
              </el-popover>
            </template>
          </el-table-column>
          <el-table-column label="Operations">
            <template slot-scope="scope">
              <el-button
                size="mini"
                @click="dialogShowTask(scope.$index, scope.row)"
                >Edit</el-button
              >

              <el-button
                size="mini"
                type="danger"
                @click="handleDelete(scope.$index, scope.row)"
                >Delete</el-button
              >
            </template>
          </el-table-column>
        </el-table></el-tab-pane
      >
    </el-tabs>
    <el-row>
      <div class="dateControl">
        <div class="row">
          <div class="col s12">
            <a
              id="next-day"
              href="#!"
              v-on:click="currentDateNext(current_date)"
              ><el-button type="primary" icon="el-icon-arrow-left"></el-button
            ></a>
            <a id="today" href="#!" v-on:click="currentDateToday()"
              ><el-button type="primary">Today</el-button></a
            >
            <a
              id="before-day"
              href="#!"
              v-on:click="currentDateBefore(current_date)"
              ><el-button type="primary" icon="el-icon-arrow-right"></el-button
            ></a>
          </div>
        </div>
      </div>
    </el-row>
    <div class="schedule">
      <el-table
        :data="schedule_table"
        :span-method="objectSpanMethod"
        border
        style="width: 100%; margin-top: 20px"
      >
        <el-table-column prop="time" label="時間" width="100">
        </el-table-column>
        <el-table-column prop="task.content" label="タスク"> </el-table-column>
        <el-table-column label="">
            <template slot-scope="scope">
              <el-button
                type="primary"
                icon="el-icon-check"
                size="mini"
                @click="doneTask(scope.$index, scope.row)"
              ></el-button>
            </template>
          </el-table-column>
        </el-table-column>
      </el-table>
    </div>
    <el-footer style="text-align: right; font-size: 12px">
      <el-row
        ><el-button
          type="primary"
          icon="el-icon-edit"
          circle
          @click="dialogCreateTask()"
        ></el-button
      ></el-row>
    </el-footer>

    <!-- リスト表示部分 -->

    <template>
      <div>
        <el-radio-group v-model="radio1">
          <el-radio-button label="New York"></el-radio-button>
          <el-radio-button label="Washington"></el-radio-button>
          <el-radio-button label="Los Angeles"></el-radio-button>
          <el-radio-button label="Chicago"></el-radio-button>
        </el-radio-group>
      </div>
    </template>

    <!-- タスク追加モーダル -->
    <el-dialog
      title="新規タスク作成"
      :visible.sync="dialogCreateTaskVisible"
      width="80%"
    >
      <el-form :model="form">
        <el-form-item label="タスク内容" :label-width="formLabelWidth">
          <el-input
            v-model="form.content"
            autocomplete="off"
            maxlength="50"
            show-word-limit
          ></el-input>
        </el-form-item>
        <el-form-item label="所要時間" :label-width="formLabelWidth">
          <div class="duration-slider">
            <el-slider
              v-model="form.duration"
              :step="15"
              :marks="marks_duration"
              :min="15"
              :max="120"
            >
            </el-slider>
          </div>
        </el-form-item>
        <el-form-item label="メモ" :label-width="formLabelWidth">
          <el-input
            type="textarea"
            v-model="form.comment"
            autocomplete="off"
            maxlength="400"
            show-word-limit
            resize="none"
            rows="10"
          ></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogCreateTaskVisible = false">Cancel</el-button>
        <el-button type="primary" @click="createTask">作成</el-button>
      </span>
    </el-dialog>

    <!-- タスク詳細モーダル -->
    <el-dialog
      title="タスク詳細"
      :visible.sync="dialogShowTaskVisible"
      width="80%"
    >
      <el-form :model="form">
        <el-form-item label="タスク内容" :label-width="formLabelWidth">
          <el-input
            v-model="form.content"
            autocomplete="off"
            maxlength="50"
            show-word-limit
          ></el-input>
        </el-form-item>
        <el-form-item label="所要時間" :label-width="formLabelWidth">
          <div class="duration-slider">
            <el-slider
              v-model="form.duration"
              :step="15"
              :marks="marks_duration"
              :min="15"
              :max="120"
            >
            </el-slider>
          </div>
        </el-form-item>
        <el-form-item label="メモ" :label-width="formLabelWidth">
          <el-input
            type="textarea"
            v-model="form.comment"
            autocomplete="off"
            maxlength="400"
            show-word-limit
            resize="none"
            rows="10"
          ></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogShowTaskVisible = false">Cancel</el-button>
        <el-button type="danger" @click="openConfirmDeleteTask">削除</el-button>
        <el-button type="primary" @click="updateTask">更新</el-button>
      </span>
    </el-dialog>

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
                    v-for="task_not_assigned in tasks_not_assigned"
                    v-bind:id="'select_task_' + task_not_assigned.id"
                    v-bind:value="task_not_assigned.id"
                    v-if="!task_not_assigned.completed"
                    >{{ task_not_assigned.content }} -{{
                      task_not_assigned.duration
                    }}分</option
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
      tasks_working: [],
      tasks_finished: [],
      tasks_not_assigned: [],
      tasks_assigned: [],
      task: {},
      id: '',
      content: '',
      comment: '',
      duration: '',
      completed: '',
      current_date: '',
      schedules: [],
      schedule_table: [],
      s_show_list: [],
      s_hiide_list: [],
      start_date: '',
      start_time: '',
      task_id: '',
      tasks_working_index: '',
      time_span: [],
      activeName: 'first',
      radio1: 'New York',
      radio2: 'New York',
      radio3: 'New York',
      radio4: 'New York',
      count: 0,
      dialogCreateTaskVisible: false,
      dialogShowTaskVisible: false,
      value1: 0,

      marks_duration: {
        0: '0',
        15: '15',
        30: '30',
        45: '45',
        60: '60',
        75: '75',
        90: '90',
        105: '105',
      },
      form: {
        content: '',
        duration: 15,
        comment: '',
      },
      formLabelWidth: '120px',
      tableData: [
        {
          date: '2016-05-03',
          name: 'Tom',
          address: 'No. 189, Grove St, Los Angeles',
        },
        {
          date: '2016-05-02',
          name: 'Tom',
          address: 'No. 189, Grove St, Los Angeles',
        },
        {
          date: '2016-05-04',
          name: 'Tom',
          address: 'No. 189, Grove St, Los Angeles',
        },
        {
          date: '2016-05-01',
          name: 'Tom',
          address: 'No. 189, Grove St, Los Angeles',
        },
      ],
      mockSwipeList: [
        {
          id: 0,
          key1: 'key1',
          key2: 'key2',
          key3: 'key3',
          key4: 'key4',
        },
        {
          id: 1,
          key1: 'key1',
          key2: 'key2',
          key3: 'key3',
          key4: 'key4',
        },
        {
          id: 2,
          key1: 'key1',
          key2: 'key2',
          key3: 'key3',
          key4: 'key4',
        },
      ],
      test_data: [
        { field1: 'A', field2: 'a', field3: '1' },
        { field1: 'A', field2: 'a', field3: '2' },
        { field1: 'A', field2: 'b', field3: '3' },
      ],
      option: [
        { index: 0, field: 'field1' },
        { index: 1, field: 'field2' },
      ],
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
      tableData: [
        {
          id: '12987122',
          name: 'Tom',
          amount1: '234',
          amount2: '3.2',
          amount3: 10,
        },
        {
          id: '12987123',
          name: 'Tom',
          amount1: '165',
          amount2: '4.43',
          amount3: 12,
        },
        {
          id: '12987124',
          name: 'Tom',
          amount1: '324',
          amount2: '1.9',
          amount3: 9,
        },
        {
          id: '12987125',
          name: 'Tom',
          amount1: '621',
          amount2: '2.2',
          amount3: 17,
        },
        {
          id: '12987126',
          name: 'Tom',
          amount1: '539',
          amount2: '4.1',
          amount3: 15,
        },
      ],
    };
  },
  mounted: function() {
    this.currentDateToday();
    this.fetchTasks();
    this.fetchSchedules();
  },
  methods: {
    objectSpanMethod({ row, column, rowIndex, columnIndex }) {
      if (columnIndex === 0) {
        if (rowIndex % 4 === 0) {
          return {
            rowspan: 4,
            colspan: 1,
          };
        } else {
          return {
            rowspan: 0,
            colspan: 1,
          };
        }
      } else if (columnIndex === 1) {
        return {
          rowspan: this.schedule_table[rowIndex].rowspan,
          colspan: 1,
        };
      } else {
        if (rowIndex % 4 === 0) {
          return {
            rowspan: 4,
            colspan: 1,
          };
        } else {
          return {
            rowspan: 0,
            colspan: 1,
          };
        }
      }
    },
    openConfirmDeleteTask() {
      this.$confirm(
        `タスク「${this.form.content}」を本当に削除してよろしいですか？`,
        'Warning',
        {
          confirmButtonText: 'OK',
          cancelButtonText: 'Cancel',
          type: 'warning',
          beforeClose: (action, instance, done) => {
            if (action === 'confirm') {
              this.deleteTask();
              done();
            } else {
              done();
            }
          },
        }
      )
        .then(() => {
          this.$notify({
            title: 'Success',
            type: 'success',
            message: 'タスクを削除しました。',
          });
        })
        .catch(() => {
          this.$notify({
            title: 'Info',
            type: 'info',
            message: 'タスクの削除をキャンセルしました。',
          });
        });
    },
    contentClick(e) {
      console.log(e, 'content click');
    },
    itemClick(e) {
      console.log(e, 'item click');
    },
    itemDblClick(e) {
      console.log(e, 'item double click');
    },
    fbClick(e) {
      console.log(e, 'First Button Click');
    },
    sbClick(e) {
      console.log(e, 'Second Button Click');
    },
    load: function() {
      this.count += 2;
    },
    handleEdit(index, row) {
      console.log(index, row);
    },
    handleDelete(index, row) {
      console.log(index, row);
    },
    fetchTasks: function() {
      axios
        .get('/api/tasks', { params: { current_date: this.current_date } })
        .then(
          (response) => {
            this.tasks_working.length = 0;
            this.tasks_finished.length = 0;
            this.tasks_assigned.length = 0;
            this.tasks_not_assigned.length = 0;
            for (let i = 0; i < response.data.tasks_working.length; i++) {
              this.tasks_working.push(response.data.tasks_working[i]);
            }
            for (let i = 0; i < response.data.tasks_finished.length; i++) {
              this.tasks_finished.push(response.data.tasks_finished[i]);
            }
            for (let j = 0; j < response.data.tasks_assigned.length; j++) {
              this.tasks_assigned.push(response.data.tasks_assigned[j]);
            }
            for (let k = 0; k < response.data.tasks_not_assigned.length; k++) {
              this.tasks_not_assigned.push(response.data.tasks_not_assigned[k]);
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
      if (!this.form.content || !this.form.duration) return;
      axios
        .post('/api/tasks', {
          task: {
            content: this.form.content,
            comment: this.form.comment,
            duration: this.form.duration,
          },
        })
        .then(
          (response) => {
            this.tasks_working.unshift(response.data.task);
            this.tasks_not_assigned.unshift(response.data.task);
            this.form.content = '';
            this.form.comment = '';
            this.form.duration = 15;
            this.$notify({
              title: 'Success',
              type: 'success',
              message: 'タスクを作成しました。',
            });
          },
          (error) => {
            console.log(error);
          }
        );
    },
    doneTask: function(index, task) {
      axios.patch('/api/tasks/' + task.id, { task: { completed: true } }).then(
        (response) => {
          this.tasks_working.splice(index, 1);
          this.tasks_finished.unshift(response.data.task);
          this.$notify({
            title: 'Success',
            type: 'success',
            message: 'タスクを完了しました。',
          });
        },
        (error) => {
          console.log(error);
        }
      );
    },
    updateTask: function() {
      if (!this.form.content || !this.form.duration) return;
      axios
        .patch('/api/tasks/' + this.task_id, {
          task: {
            content: this.form.content,
            comment: this.form.comment,
            duration: this.form.duration,
          },
        })
        .then(
          (response) => {
            this.tasks_working[this.tasks_working_index].content =
              response.data.task.content;
            this.tasks_working[this.tasks_working_index].duration =
              response.data.task.duration;
            this.tasks_working[this.tasks_working_index].comment =
              response.data.task.comment;
            this.form.content = '';
            this.form.comment = '';
            this.form.duration = 15;
            this.dialogShowTaskVisible = false;
            this.$notify({
              title: 'Success',
              type: 'success',
              message: 'タスクを更新しました。',
            });
          },
          (error) => {
            console.log(error);
          }
        );
    },
    deleteTask: function() {
      axios.delete('/api/tasks/' + this.task_id).then(
        (response) => {
          this.tasks_working.splice(this.tasks_working_index, 1);
          this.dialogShowTaskVisible = false;
        },
        (error) => {
          console.log(error);
        }
      );
    },
    dialogCreateTask: function() {
      this.dialogCreateTaskVisible = true;
    },
    dialogShowTask: function(index, task) {
      console.log('shoTaskだよ');
      console.log(index, task);
      this.dialogShowTaskVisible = true;
      this.form.content = task.content;
      this.form.duration = task.duration;
      this.form.comment = task.comment;
      this.tasks_working_index = index;
      this.task_id = task.id;
    },
    fetchSchedules: function() {
      let current_date_str = this.dateToStr(this.current_date);
      axios
        .get('/api/schedules', { params: { start_date: current_date_str } })
        .then(
          (response) => {
            this.schedule_table.length = 0;
            for (let i = 0; i < response.data.schedule_table.length; i++) {
              this.schedule_table.push(response.data.schedule_table[i]);
            }
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
          let td_schedule = document.createElement('td');
          let td_assign = document.getElementById(`row_a_${time}`);
          td_schedule.id = `row_s_${time}`;
          tr_element.insertBefore(td_schedule, td_assign);
        } else {
          document.getElementById(`row_s_${time}`).innerText = '';
          document.getElementById(`row_s_${time}`).setAttribute('rowSpan', 1);
        }
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
      console.log('new Date()の結果は');
      console.log(now);
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
    dateToStr: function(date) {
      let year_str = date.getFullYear();
      //月だけ+1すること
      let month_str = 1 + date.getMonth();
      let day_str = date.getDate();
      let hour_str = date.getHours();
      let minute_str = date.getMinutes();
      let second_str = date.getSeconds();
      let format_str = 'YYYY-MM-DD';

      month_str = ('0' + month_str).slice(-2);
      day_str = ('0' + day_str).slice(-2);

      format_str = format_str.replace(/YYYY/g, year_str);
      format_str = format_str.replace(/MM/g, month_str);
      format_str = format_str.replace(/DD/g, day_str);

      return format_str;
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
  margin-bottom: 20px;
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
  margin-top: 20px;
  margin-bottom: 20px;
  text-align: center;
}
.schedule_bar {
  background-color: blue;
}

#next-day {
}
#today {
  margin-left: 40px;
  margin-right: 40px;
}
#before-day {
}
input[type='radio'] {
  border: 0px;
  width: 100%;
  height: 2em;
}
.el-footer {
  background-color: #b3c0d1;
  color: #333;
  line-height: 60px;
}
.el-footer .el-row {
  text-align: center;
}
.duration-slider {
  width: 100%;
}
</style>
