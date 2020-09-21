class CreateGames <ActiveRecord::Migration
  def change 
    create_table :games do |t|
        t.string :name
        t.string :genre
        t.integer :price
        t.integer :user_id
    end
  end
end