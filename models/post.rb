require './db/mysql_connector.rb'

class Post
    attr_accessor :id, :post, :user_id, :user

    def initialize(id, post, user)
        @id = id
        @post = post
        @user = user
    end

    def valid?
        return false if @post.nil?
        true
    end

    def save
        return false unless valid?  
        client = create_db_client
        client.query("INSERT INTO post(post,user_id) VALUES('#{post}', '#{user}')")
        true
    end

    def self.get_all_post
        client = create_db_client
        client.query("select post.id as 'post_id', post.post, user.id, user.username from post join user on post.user_id=user.id")
    end

    def self.get_post_by_id(id)
        client = create_db_client
        client.query("select post.id as 'post_id', post.post, user.id, user.username from post join user on post.user_id=user.id where user.id='#{id}'")
    end

    def self.get_user_id(id)
        client = create_db_client
        client.query("select id,username,email,bio from user where id = #{id}")
    end

    def self.rawData(rawdata)
        posts = Array.new
        rawdata.each do |data|
            user = User.new(data['id'], data['username'],data['email'],data['bio'])
            post = Post.new(data['post_id'], data['post'], user)
            posts.push(post)
        end
        posts
    end

    def self.all 
        rawdata = get_all_post
        rawData(rawdata)
    end

    def self.post_by_id(id) 
        rawdata = get_post_by_id(id)
        rawData(rawdata)
    end

    def self.user_by_id(id) 
        rawdata = get_user_id(id)
        rawData(rawdata)
    end
end