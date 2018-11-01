class AddBelongsToToArticle < ActiveRecord::Migration[5.0]
  def change
    remove_column :articles, :user_id
    add_reference :articles, :user, foreign_key: true
  end
end
