# create a new Class, User, that has the following attributes:
# - name
# - email
# - password

class User
    attr_accessor :name, :email, :password

    def initialize(name, email, password)
        @name = name
        @email = email
        @password = password
        @rooms = []
    end

# add a method to user so, user can enter to a room
# user.enter_room(room)

    def enter_room(room)
        if !room.users.include?(self)
            room.users << self  
        end

        if !@rooms.include?(room)
            @rooms << room
        end
    end

# add a method to user so, user can send a message to a room
# user.send_message(room, message)
# user.ackowledge_message(room, message)

    def send_message(room, content)
        message = Message.new(self, room, content)
        room.broadcast(message) if @rooms.include?(room)
    end

    def acknowledge_message(room, message)
        puts "#{name} acknowledged message: '#{message.content}' from #{room.name}"
    end
end

# create a new Class, Room, that has the following attributes:
# - name
# - description
# - users

class Room
    attr_accessor :name, :description, :users

    def initialize(name, description)
        @name = name
        @description = description
        @users = []
    end

# add a method to a room, so it can broadcast a message to all users
# room.broadcast(message)

    def broadcast(message)
        puts "Broadcasting message in #{name}: #{message.user.name}: '#{message.content}'"
        users.each do |user|
            user.acknowledge_message(self, message)
        end
    end
end

# create a new Class, Message, that has the following attributes:
# - user
# - room
# - content

class Message
    attr_accessor :user, :room, :content

    def initialize(user, room, content)
        @user = user
        @room = room
        @content = content
    end
end

user1 = User.new("Pooh", "satapol.boon@bumail.net", "11111")
user2 = User.new("Nama", "naaa@bumail.net", "2222")

room = Room.new("Chat Room 1", "Party room")

user1.enter_room(room)
user2.enter_room(room)

user1.send_message(room, "Hello everyone!")
user2.send_message(room, "Hi")