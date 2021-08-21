require './db/mysql_connector.rb'

class User
    attr_accessor :id, :username, :email, :bio

    def initialize(id, username, email, bio)
        @id = id
        @username = username
        @email = email
        @bio = bio
    end

    def valid?
        return false if @username.nil?
        return false if @email.nil?
        true
    end

    def save
        return false unless valid?  
        client = create_db_client
        client.query("INSERT INTO user(username,email,bio) VALUES('#{username}','#{email}','#{bio}')")
        true
    end

    def self.get_all_users
        client = create_db_client
        client.query("select * from user")
    end

    def self.get_user_by_id(id)
        client = create_db_client
        client.query("select id,username,email,bio from user where id = #{id}")
    end

    def self.rawData(rawdata)
        users = Array.new
        rawdata.each do |data|
            user = User.new(data['id'], data['username'], data['email'], data['bio'])
            users.push(user)
        end
        users
    end

    def self.all 
        rawdata = get_all_users
        rawData(rawdata)
    end

    def self.user_by_id(id) 
        rawdata = get_user_by_id(id)
        rawData(rawdata)
    end

    def self.update(id,username,email,bio)
        #return false unless valid? 
        client = create_db_client
        client.query("Update user set username = '#{username}', email = '#{email}', bio = '#{bio}' where id = '#{id}'")

        #true
    end
end