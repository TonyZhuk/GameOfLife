class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer 'current_gen', array: true
      t.integer 'next_gen', array: true
    end
  end
end
