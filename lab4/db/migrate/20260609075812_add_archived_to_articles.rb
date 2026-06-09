class AddArchivedToArticles < ActiveRecord::Migration[8.1]
  def change
    add_column :articles, :archived, :boolean
  end
end
