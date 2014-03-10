class CreateSignup < ActiveRecord::Migration
  def change
  	create_table :signup do |t|
  		t.string :email
  		t.string :password
  	end
  end
end
