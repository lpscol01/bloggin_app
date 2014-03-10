require "sinatra"
require "sinatra/activerecord"
require "bundler/setup"
require "rack-flash"

#Settings

configure(:development) {
 set :database, "sqlite3:///test_app.sqlite3"
}

set :sessions, true
set :environment, :development
ENV['RACK_ENV'] = "development"

use Rack::Flash, :sweep => true

Dir['./*.rb', ',/models/*.rb'].each{ |f| require f }

#Methods

def current_user
	if session[:user_id]
		@current_user - User.find( session[:user_id] )
	end
end

#Routes

get "/" do 
	erb :index
end

post "/sign-in" do
	@user = User.where(email: params[:username] ).first

	if @user && ( @user.password == params[:password] )
		puts "Welcome to Dana's Travel Blog"
		
		#store the user id in the session
		session[:user_id] = @user.id
		
		#notify the user that they are signed in
		flash[:notice] = "You are signed in!"

		redirect to "/posts"
	else
		flash[:error] = "Unable to sign you in."

		redirect to "/"
	end
end

get "/signup" do 
	erb :signup
end

post "/signup" do
	puts params
	if params[:signup][:username] && params[:signup][:password]

		@newuser = User.create(params[:signup])

		if @newuser
			redirect to("/")
		else
			redirect to("/signup")
		end
	else
		redirect to ("/signup")
	end
end
	
get "/posts" do
	erb :posts
end

post "/create_post" do
	puts params
	if params[:post][:title] && params[:post][:body]

		@post = Post.create(params[:post])

		if @post
			redirect to("/blog")
		else
			redirect to("/new-post")
		end
	else
		redirect to ("/new-post")
	end
end

get "/blog" do
	erb :blog
end


