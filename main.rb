require 'sinatra'
require './controllers/user_controller.rb'
require './controllers/post_controller.rb'

get '/' do
    usercontrollers = UserController.new
    usercontrollers.show_all_users
end


get '/users/addUser' do
    usercontrollers = UserController.new
    usercontrollers.show_add_user
end

post '/users/create_user' do
    id = params['id']
    username = params['username']
    email = params['email']
    bio = params['bio']
    usercontrollers = UserController.new
    usercontrollers.add_user(id, username, email, bio)
    redirect '/'
end

get '/user/detail/:id' do
    usercontrollers = UserController.new
    id = params['id']
    usercontrollers.show_details_user(id)
end

get '/user/edit/:id' do
    usercontrollers = UserController.new
    id = params['id']
    usercontrollers.show_edit_user(id)
end

put '/user/update/:id' do
    usercontrollers = UserController.new
    id = params['id']
    username = params['username']
    email = params['email']
    bio = params['bio']
    usercontrollers.action_update_user(id,username,email,bio)
    redirect "/user/detail/#{id}"
end

#---------------post-------------------

get '/post/:id' do
    postcontrollers = PostController.new
    id = params['id']
    postcontrollers.show_all_post(id)
end

get '/post/addPost/:id' do
    postcontrollers = PostController.new
    id = params['id']
    postcontrollers.show_add_post(id)
end

post '/post/create_post' do
    id = params['id']
    post = params['post']
    user = params['user']
    postcontrollers = PostController.new
    postcontrollers.add_post(id, post, user)
    redirect "/post/#{id}"
end