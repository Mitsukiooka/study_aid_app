class CreatePlans < ActiveRecord::Migration[6.0]
  def change
    create_table :plans do |t|
      t.string 'title'
      t.string 'study_aid'
      t.text 'plan_detail'
      t.text 'plan_goal'
      t.string "status"
      t.text 'feedback_comment'
      t.datetime "start_at"
      t.datetime "end_at"
      t.timestamps
    end
  end
end
