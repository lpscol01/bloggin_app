# Objects of this class are stored 
# in 'users' table in DB
class User < ActiveRecord::Base

	has_many :posts
	has_one  :profile

end

class Post < ActiveRecord::Base

	belongs_to :user
end

class Profile <ActiveRecord::Base

	belongs_to :user
end
