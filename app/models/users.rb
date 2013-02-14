class Users < ActiveRecord::Base
  attr_accessible :count, :password, :user

    SUCCESS = 1
    ERR_BAD_CREDENTIALS = -1
    ERR_USER_EXISTS = -2
    ERR_BAD_USERNAME = -3
    ERR_BAD_PASSWORD = -4
    
    def self.login(user, password)
        loginUser = Users.find_by_user_and_password(user, password)
        if loginUser
            loginUser.count++
            loginUser.save
            data = {:errCode => SUCCESS}
        else
            data = {:errCode => ERR_BAD_CREDENTIALS}
        end
        return data
    end

    def self.add(user, password)
        addUser = Users.find_by_user(user)
        if addUser
            data = {:errCode => ERR_USER_EXISTS}
        elsif user.blank? or user.nil? or user.length > 128
            data = {:errCode => ERR_BAD_USERNANE}
        elsif password.blank? or password.nil? or password.length > 128
            data = {:errCode => ERR_BAD_PASSWORD}
        else
            Users.create(:user => user, :password => password, :count => 1)
            data = {:errCode => SUCCESS}
        end
        return data
    end

    def self.TESTAPI_resetFixture()
        Users.delete_all
        data = {:errCode => SUCCESS}
        return reset_data
    end

end
