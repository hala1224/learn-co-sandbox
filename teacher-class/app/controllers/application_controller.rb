# require './config/environment'

# class ApplicationController < Sinatra::Base

#   configure do
#     set :public_folder, 'public'
#     set :views, 'app/views'
#   end

#   get "/" do
#     erb :welcome
#   end

# end


require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
   use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    if logged_in?
      redirect '/classes'
    else
      erb :index
    end
  end

  get "/login" do
    if logged_in?
      redirect '/classes'
    else
      erb :"/teachers/login"
    end
  end

  get "/signup" do
    if logged_in?
      flash[:notice] = "You're already logged in! Redirecting..."
      redirect '/classess'
    else
      erb :"/teachers/create_teacher"
    end
  end

  post "/signup" do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      flash[:error] = "You have missing required fields."
      redirect '/signup'
    else
      @teacher = Teacher.new(params)
      @teacher.save
      session[:teacher_id] = @teacher.id
      flash[:notice] = "Welcome to Community Gym"
      redirect '/classes'
    end
  end


  post "/login" do
    @teacher = Teacher.find_by(:username => params[:username])
    if @teacher && @teacher.authenticate(params[:password])
      session[:teacher_id] = @teacher.id
      flash[:success] = "Welcome, #{@teacher.username}!"
      redirect '/classes'
    else
      flash[:error] = "Login failed!"
      redirect '/login'
    end
  end

  get '/users/:slug' do
    @teacher = Teacher.find_by_slug(params[:slug])
    @classes = @teacher.classes
    erb :"/teachers/show"
  end
# replace user with teacher and tweets with classes

  get "/classes/new" do
    @teacher = current_teacher
    if logged_in?
      erb :"/classes/create_class"
    else
      redirect '/login'
    end
  end

  post "/new" do
    if logged_in? && params[:content] != ""
      @teacher = current_teacher
      @class = Class.create(content: params["content"], teacher_id: params[:teacher_id])
      @class.save
      erb :"/classes/show_class"
    elsif logged_in? && params[:content] == ""
      flash[:notice] = "Your class is blank!"
      redirect '/classes/new'
    else
      flash[:notice] = "Please log in to proceed"
      redirect '/login'
    end
  end

  get "/classes" do
    if logged_in?
      @teacher = current_teacher
      erb :"/classes/classes"
    else
      redirect '/login'
    end
  end

  get "/classes/:id" do
    @teacher = current_teacher
    @class = Class.find_by_id(params[:id])
    if !logged_in?
      redirect '/login'
    else
      erb :"/classes/show_class"
    end
  end

  get "/classes/:id/edit" do
    if logged_in?
      @class = Class.find(params[:id])
      if @tweet.user_id == session[:user_id]
        # binding.pry
      erb :"/classes/edit_class"
      else
        redirect '/login'
      end
    else
      redirect '/login'
    end
  end
