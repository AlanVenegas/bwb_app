class AddTitleToQuestions < ActiveRecord::Migration
  def change
  	add_column :questions, :title, :string
    add_index  :questions, :title
  end
end
