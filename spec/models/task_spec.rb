require 'rails_helper'
require 'securerandom'
RSpec.describe 'Taskモデルのテスト', type: :model do
  before do
    @user = create(:user)
  end
  
  describe 'バリデーションのテスト' do
    context 'タスクのcontentが空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(content: '', duration: 15, comment: SecureRandom.alphanumeric(400), completed: true, user_id:@user.id)
        expect(task).not_to be_valid
      end
    end
    context 'タスクのcontentのlengthが51以上場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(content: SecureRandom.alphanumeric(51), duration: 15, comment: SecureRandom.alphanumeric(400), completed: true, user_id:@user.id)
        expect(task).not_to be_valid
      end
    end
    context 'タスクのがduration空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(content: SecureRandom.alphanumeric(50), duration: "", comment: SecureRandom.alphanumeric(400), completed: true, user_id:@user.id)
        expect(task).not_to be_valid
      end
    end
    context 'タスクのcommentのlengthが401以上の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(content: SecureRandom.alphanumeric(50), duration: 15, comment: SecureRandom.alphanumeric(401), completed: true, user_id:@user.id)
        expect(task).not_to be_valid
      end
    end
    context 'タスクのcompletedの値がtrueとfalseのどちらでもない場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(content: SecureRandom.alphanumeric(51), duration: 15, comment: SecureRandom.alphanumeric(400), completed: "HELLO", user_id:@user.id)
        expect(task).not_to be_valid
      end
    end
    context 'タスクのcontentとdurationが記載されていて、completedがtrueの場合' do
      it 'バリデーションを通る' do
        task = Task.new(content: SecureRandom.alphanumeric(50), duration: 15, comment: SecureRandom.alphanumeric(400), completed: true, user_id:@user.id)
        expect(task).to be_valid
      end
    end
    context 'タスクのcontentとdurationが記載されていて、completedがfalseの場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(content: SecureRandom.alphanumeric(50), duration: 15, comment: SecureRandom.alphanumeric(400), completed: false, user_id:@user.id)
        expect(task).to be_valid
      end
    end
  end 
end