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
      redirect '/categories'
    else
      erb :index
    end
  end

#   get "/login" do
#     if logged_in?
#       redirect '/categories'
#     else
#       erb :"/teachers/login"
#     end
#   end

#   get "/signup" do
#     if logged_in?
#       flash[:notice] = "You're already logged in! Redirecting..."
#       redirect '/classess'
#     else
#       erb :"/teachers/create_teacher"
#     end
#   end

#   post "/signup" do
#     if params[:username] == "" || params[:password] == "" || params[:email] == ""
#       flash[:error] = "You have missing required fields."
#       redirect '/signup'
#     else
#       @teacher = Teacher.new(params)
#       @teacher.save
#       session[:teacher_id] = @teacher.id
#       flash[:notice] = "Welcome to Community Gym"
#       redirect '/categories'
#     end
#   end


#   post "/login" do
#     @teacher = Teacher.find_by(:username => params[:username])
#     if @teacher && @teacher.authenticate(params[:password])
#       session[:teacher_id] = @teacher.id
#       flash[:success] = "Welcome, #{@teacher.username}!"
#       redirect '/categories'
#     else
#       flash[:error] = "Login failed!"
#       redirect '/login'
#     end
#   end

#   get '/teachers/:slug' do
#     @teacher = Teacher.find_by_slug(params[:slug])
#     @classes = @teacher.classes
#     erb :"/teachers/show"
#   end
# # replace user with teacher and tweets with classes

#   get "/categories/new" do
#     @teacher = current_teacher
#     if logged_in?
#       erb :"/categories/create_category"
#     else
#       redirect '/login'
#     end
#   end

#   post "/new" do
#     if logged_in? && params[:content] != ""
#       @teacher = current_teacher
#       @category = Category.create(content: params["content"], teacher_id: params[:teacher_id])
#       @category.save
#       erb :"/categories/show_category"
#     elsif logged_in? && params[:content] == ""
#       flash[:notice] = "Your class is blank!"
#       redirect '/categories/new'
#     else
#       flash[:notice] = "Please log in to proceed"
#       redirect '/login'
#     end
#   end

#   get "/categories" do
#     if logged_in?
#       @teacher = current_teacher
#       erb :"/categories/categories"
#     else
#       redirect '/login'
#     end
#   end

#   get "/categories/:id" do
#     @teacher = current_teacher
#     @category = Category.find_by_id(params[:id])
#     if !logged_in?
#       redirect '/login'
#     else
#       erb :"/categories/show_category"
#     end
#   end

#   get "/categories/:id/edit" do
#     if logged_in?
#       @category = Category.find(params[:id])
#       if @category.user_id == session[:user_id]
#         # binding.pry
#       erb :"/categories/edit_category"
#       else
#         redirect '/login'
#       end
#     else
#       redirect '/login'
#     end
#   end
end