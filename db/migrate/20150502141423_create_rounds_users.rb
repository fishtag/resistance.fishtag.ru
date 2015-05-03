class CreateRoundsUsers < ActiveRecord::Migration
  def change
    create_table :rounds_users do |t|
      t.belongs_to :round, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :rounds_users, %i(round_id user_id)
  end
end
