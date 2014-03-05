class CreateProfiles < ActiveRecord::Migration
  def change
  	create_table :profiles do |t|
  		t.integer :user_id
  		t.string :first_name
  		t.string :last_name
  		t.string :gender
  		t.integer :age
  		t.string :location
  	end
  end
end