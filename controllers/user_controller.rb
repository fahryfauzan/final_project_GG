require './models/user.rb'

class UserController
    def show_all_users
        users = User.all
        renderer = ERB.new(File.read("./views/list_user.erb"))
        renderer.result(binding)
    end

    def show_add_user
        renderer = ERB.new(File.read("./views/add_user.erb"))
        renderer.result(binding)
    end

    def show_details_user(id)
        users = User.user_by_id(id)
        renderer = ERB.new(File.read("./views/detail_user.erb"))
        renderer.result(binding)
    end

    def add_user(id, username, email, bio)
        users = User.new(id, username, email, bio)
        users.save
    end

    def show_edit_user(id)
        user = User.user_by_id(id)
        renderer = ERB.new(File.read("./views/edit_user.erb"))
        renderer.result(binding)
    end

    def action_update_user(id,username,email,bio)
        User.update(id,username,email,bio)
    end
end