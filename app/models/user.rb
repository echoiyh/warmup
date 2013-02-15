class User < ActiveRecord::Base
    attr_accessible :count, :password, :user
    
    SUCCESS = 1
    ERR_BAD_CREDENTIALS = -1
    ERR_USER_EXISTS = -2
    ERR_BAD_USERNAME = -3
    ERR_BAD_PASSWORD = -4
    
    def self.login(user, password)
        loginUser = User.find_by_user_and_password(user, password)
        if loginUser
            loginUser.count = loginUser.count + 1
            loginUser.save
            data = {:errCode => SUCCESS}
        else
            data = {:errCode => ERR_BAD_CREDENTIALS}
        end
        return data
    end

    def self.add(user, password)
        addUser = User.find_by_user(user)
        if addUser
            data = {:errCode => ERR_USER_EXISTS}
        elsif user.blank? or user.nil? or user.length > 128
            data = {:errCode => ERR_BAD_USERNAME}
        elsif password.blank? or password.nil? or password.length > 128
            data = {:errCode => ERR_BAD_PASSWORD}
        else
            User.create(:user => user, :password => password, :count => 1)
            data = {:count => 1, :errCode => SUCCESS}
        end
        return data
    end

    def self.TESTAPI_resetFixture()
        User.destroy_all
        data = {:errCode => SUCCESS}
        return data
    end

end
