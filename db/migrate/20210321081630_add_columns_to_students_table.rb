class AddColumnsToStudentsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :user_id, :integer
    add_column :students, :name, :string
    add_column :students, :age, :integer
    add_column :students, :primary_language, :string
    add_column :students, :description, :text
  end
end
