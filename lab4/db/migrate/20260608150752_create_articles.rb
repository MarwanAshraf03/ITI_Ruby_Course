class CreateArticles < ActiveRecord::Migration[8.1]
  def change
    create_table :articles do |t|
      t.text :title
      t.text :body
      t.integer :reports_count

      t.timestamps
    end
  end
end
