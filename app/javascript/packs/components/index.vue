<template>
  <div class = "main">
    <el-tabs type="border-card">
     <!-- 
     -----------------------------

      作業中タスク表示タブ

     -----------------------------
    -->
      <el-tab-pane>
        <span slot="label"><i class="el-icon-edit-outline"></i>Working</span>
        <el-table :data="tasks_working" style="width: 100%" :show-header="false" height="30vh">
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
      <!-- 
     -----------------------------

      完了タスク表示タブ

     -----------------------------
    -->
      <el-tab-pane
        ><span slot="label"><i class="el-icon-finished"></i>Finished</span>

        <el-table :data="tasks_finished" style="width: 100%" :show-header="false" height="30vh">
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
    <!-- 
     -----------------------------

      日付操作ボタン表示部分

     -----------------------------
    -->
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
      <div class="row">
        <p v-model="current_date">{{current_date}}</p>
      </div>
    </el-row>
     <!-- 
     -----------------------------

      スケジュール表示部分

     -----------------------------
    -->
    <div class="schedule">
      <el-table
        :data="schedule_table"
        :span-method="objectSpanMethod"
        border
        style="width: 100%; margin-top: 20px;"
         :cell-class-name="scheduleCellClassName"
         height="40vh"
        :show-header="false"
        :cell-style="{padding: '0', height: '10px'}"
      >
        <el-table-column prop="time" label="時間" width="80" height="30">
        </el-table-column>
        <el-table-column prop="task.content" label="タスク" height="30">
          <template slot-scope="scope">
            <el-button
                    type="text"
                    @click="dialogShowSchedule(scope.$index, scope.row)"
                    ><span style="margin-left: 10px">{{
                      scope.row.task.content
                    }}</span></el-button
                  >
          </template>
        
        </el-table-column>
        <el-table-column label="" width="80" height="30">
            <template slot-scope="scope">
              <el-button
                type="primary"
                icon="el-icon-plus"
                size="mini"
                circle
                @click="dialogAssignTask(scope.$index, scope.row)"
              ></el-button>
            </template>
          </el-table-column>
        </el-table-column>
      </el-table>
    </div>

     <!-- 
     -----------------------------

      フッター部分

     -----------------------------
    -->
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
    <!-- 
     -----------------------------

      新規タスク作成ダイアログ

     -----------------------------
    -->
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

    <!-- 
     -----------------------------

      タスク詳細ダイアログ

     -----------------------------
    -->
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

    <!-- 
     -----------------------------

      タスクアサインダイアログ

     -----------------------------
    -->
   
    <el-dialog
      title="タスクアサイン"
      :visible.sync="dialogAssignTaskVisible"
      width="80%"
    >
      <el-form :model="form_schedule">
      <el-form-item label="開始時間" :label-width="formLabelWidth">
      <div>
        <el-radio-group v-model="form_schedule.start_time">
          <el-radio-button v-for="time in time_span" :label="time"></el-radio-button>
        </el-radio-group>
      </div>
      </el-form-item>
      <el-form-item label="アサインするタスク" :label-width="formLabelWidth">
        <div>
          <el-select v-model="form_schedule.task_id" placeholder="Select" v-on:change="formInsertTask()">
            <el-option
              v-for="task_working in tasks_working"
              :key="task_working.id"
              :label="task_working.content"
              :value="task_working.id">
              <span style="float: left">{{ task_working.content }}</span>
              <span style="float: right; color: #8492a6; font-size: 13px">{{ task_working.duration }}分</span>
            </el-option>
          </el-select>
        </div>
      </el-form-item>
        <el-form-item label="タスク内容" :label-width="formLabelWidth">
          <el-input
            v-model="form.content"
            autocomplete="off"
            maxlength="50"
            show-word-limit
            readonly
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
              :disabled="true"
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
            readonly
          ></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogAssignTaskVisible=false">閉じる</el-button>
        <el-button type="primary" @click="createSchedule()">スケジュールに追加</el-button>
      </span>
    </el-dialog>

    <!-- 
     -----------------------------

      スケジュール詳細ダイアログ

     -----------------------------
    -->
   
    <el-dialog
      title="スケジュール詳細"
      :visible.sync="dialogShowScheduleVisible"
      width="80%"
    >
      <el-form :model="form_schedule">
      <el-form-item label="作業時間" :label-width="formLabelWidth">
      <el-col :span="6">
      <span v-model="form_dialogShowSchedule.start_time">{{form_dialogShowSchedule.start_time}}</span>
      </el-col>
      <el-col class="line" :span="1">-</el-col>
      <el-col :span="6">
       <span v-model="form_dialogShowSchedule.end_time">{{form_dialogShowSchedule.end_time}}</span>
       </el-col>
      </el-form-item>
        <el-form-item label="タスク内容" :label-width="formLabelWidth">
          <el-input
            v-model="form_dialogShowSchedule.content"
            autocomplete="off"
            maxlength="50"
            show-word-limit
            readonly
          ></el-input>
        </el-form-item>
        <el-form-item label="所要時間" :label-width="formLabelWidth">
          <div class="duration-slider">
            <el-slider
              v-model="form_dialogShowSchedule.duration"
              :step="15"
              :marks="marks_duration"
              :min="15"
              :max="120"
              :disabled="true"
            >
            </el-slider>
          </div>
        </el-form-item>
        <el-form-item label="メモ" :label-width="formLabelWidth">
          <el-input
            type="textarea"
            v-model="form_dialogShowSchedule.comment"
            autocomplete="off"
            maxlength="400"
            show-word-limit
            resize="none"
            rows="10"
            readonly
          ></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogShowScheduleVisible=false">閉じる</el-button>
        <el-button type="primary" @click="openConfirmDeleteSchedule()">スケジュールから外す</el-button>
      </span>
    </el-dialog>
    
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
      task_content: '',
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
      end_time:'',
      task_id: '',
      tasks_working_index: '',
      time_span: [],
      schedule_id: '',
      dialogCreateTaskVisible: false,
      dialogShowTaskVisible: false,
      dialogAssignTaskVisible: false,
      dialogShowScheduleVisible: false,
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
      form_schedule:{
        start_time: '',
        task_id:''
      },
      form_dialogShowSchedule:{
        schedule_id:'',
        start_time:'',
        end_tme:'',
        content:'',
        duration:'',
        comment:''
      },
      formLabelWidth: '160px',
        value: ''
    };
  },
  mounted: function() {
    this.currentDateToday();
    this.fetchTasks();
    this.fetchSchedules();
  },
  methods: {
  debugMethod: function(){
  this.dialogAssignTaskVisible = false
  console.log(this.form_schedule.start_time)
  },
  formInsertTask: function(){
    let form_task;
    form_task = this.tasks_working.find(t => t.id === this.form_schedule.task_id)
    this.form.content = form_task.content
    this.form.comment = form_task.comment
    this.form.duration = form_task.duration
  },
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
    openConfirmDeleteSchedule() {
      this.$confirm(
        `タスク「${this.form_dialogShowSchedule.content}」を本当にスケジュールから外してよろしいですか？`,
        'Warning',
        {
          confirmButtonText: 'OK',
          cancelButtonText: 'Cancel',
          type: 'warning',
          beforeClose: (action, instance, done) => {
            if (action === 'confirm') {
              this.deleteSchedule();
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
            message: 'スケジュールから外しました。',
          });
        })
        .catch(() => {
          this.$notify({
            title: 'Info',
            type: 'info',
            message: 'スケジュールから外すことをキャンセルしました。',
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
     dialogAssignTask: function(index , row) {
     console.log(index)
     console.log(row)
     console.log(this.current_date)
     console.log(Number(row.time.slice(0,2)))
     console.log(Number(row.time.slice(-2)))
     let time = this.current_date.setHours(Number(row.time.slice(0,2)));
     time = new Date(this.current_date.setMinutes(Number(row.time.slice(-2))));
     console.log("time↓")
     console.log(time)
     this.time_span[0] = time.getHours().toString().padStart(2,'0') +":" + time.getMinutes().toString().padStart(2,'0');
     this.form_dialogShowSchedule.start_time=""
     this.form_dialogShowSchedule.end_time=""
     this.form_dialogShowSchedule.content=""
     this.form_dialogShowSchedule.commnet=""
     this.form_dialogShowSchedule.duration=""
     for (let i =1;i<4; i++){
      let tmp_time = new Date(time.setMinutes(time.getMinutes()+15))
      console.log("tmp_time↓")
      console.log(tmp_time)
      this.time_span[i] = tmp_time.getHours().toString().padStart(2,'0') +":" + tmp_time.getMinutes().toString().padStart(2,'0')
     }
     this.dialogAssignTaskVisible = true;
    },
    dialogShowSchedule: function(index, schedule_task){
    console.log("dialogShowScheduleのはじまり")
    console.log(schedule_task)
    this.dialogShowScheduleVisible =  true
    this.form_dialogShowSchedule.start_time = this.getHHMM(schedule_task.schedule.start_time);
    this.form_dialogShowSchedule.end_time = this.getHHMM(schedule_task.schedule.end_time);
    this.form_dialogShowSchedule.content = schedule_task.task.content;
    this.form_dialogShowSchedule.comment = schedule_task.task.comment;
    this.form_dialogShowSchedule.duration = schedule_task.task.duration;
    this.schedule_id = schedule_task.schedule.id;
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
            console.log(error);
          }
        );
    },
    createSchedule: function() {
      console.log(this.current_date)
      console.log(this.form_schedule.start_time)
       console.log(this.form_schedule.task_id)
       let current_date_str = this.dateToStr(this.current_date);
      if (!this.current_date || !this.form_schedule.start_time || !this.form_schedule.task_id) return;
      axios
        .post('/api/schedules', {
          schedule: {
            start_date: current_date_str,
            start_time: this.form_schedule.start_time,
            task_id: this.form_schedule.task_id,
          },
        })
        .then(
          (response) => {
            let schedule_table_index = this.schedule_table.findIndex(schedule => schedule.time === response.data.schedule_table[0].time)
            let j =0
            for (let i = schedule_table_index; i<schedule_table_index+response.data.schedule_table.length; i++){
              this.schedule_table[i] = response.data.schedule_table[j]
              j++
            }
            console.log(this.schedule_table)
            this.form_schedule_start_time = '';
            this.form_schedule_task_id = '';
            this.dialogAssignTaskVisible = false;
          },
          (error) => {
            console.log(error);
          }
        );
    },
    deleteSchedule: function() {
      axios.delete('/api/schedules/' + this.schedule_id).then(
        (response) => {
          let schedule_table_index = this.schedule_table.findIndex(schedule => schedule.time === response.data.schedule_table[0].time)
          let j =0
          for (let i = schedule_table_index; i<schedule_table_index+response.data.schedule_table.length; i++){
              this.schedule_table[i] = response.data.schedule_table[j]
              j++
          }
          this.schedule_id=''
          this.dialogShowScheduleVisible = false;
        },
        (error) => {
          console.log(error);
        }
      );
    },
    scheduleCellClassName: function(cell){
      if (cell.columnIndex ===1 ){
        if (cell.row.schedule){
          return 'schedule-column'
        }
      
      }
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
    getHHMM: function(dateStr){
      let date = new Date(dateStr)
      let hourStr   = date.getHours().toString().padStart(2, '0');
      let minuteStr = date.getMinutes().toString().padStart(2, '0');
      return hourStr+":"+minuteStr
    }
  },
};
</script>
<style>
[v-cloak] {
  display: none;
}
.main {
  padding-top:60px;
  height:100vh-60px;
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
  
}

.schedule {
  padding-bottom: 80px;
 
}

.schedule tr{
  height: 30px;
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
  position: fixed;
  bottom: 0;
  width: 100%;
  z-index: 50;

}
.el-footer .el-row {
  text-align: center;
}
.duration-slider {
  width: 100%;
}
.el-table .tr{
  height: 30px;
}
.el-table .schedule-column{
  background: #f0f9eb;
}
</style>
