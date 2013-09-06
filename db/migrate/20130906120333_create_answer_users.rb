class CreateAnswerUsers < ActiveRecord::Migration
  def change
    create_table :answer_users do |t|
      t.belongs_to :answer
      t.belongs_to :user

      t.timestamps
    end
  end
end
