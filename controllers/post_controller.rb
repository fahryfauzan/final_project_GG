require './models/post.rb'

class PostController
    def show_all_post(id)
        post = Post.all
        postid = Post.user_by_id(id)
        renderer = ERB.new(File.read("./views/all_post.erb"))
        renderer.result(binding)
    end

    def show_add_post(id)
        post = Post.user_by_id(id)
        renderer = ERB.new(File.read("./views/add_post.erb"))
        renderer.result(binding)
    end

    def add_post(id,post,user)
        post = Post.new(id, post, user)
        post.save
    end
end