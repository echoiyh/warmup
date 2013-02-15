require 'spec_helper'

describe User do
    after(:each) do
        User.delete_all
    end
    describe "Initial count is 1" do
        it "Count should be 1" do
            User.add("eric", "test")
            data = User.find_by_user("eric").count
            data.should eql(1)
        end
    end
    describe "User Exists" do
        it "Response should be -2" do
            User.add("eric", "test")
            data = User.add("eric", "anotherTest")
            data.should eql({:errCode => -2})
        end
    end
    describe "Empty Username" do
        it "Response should be -3" do
            data = User.add("", "test")
            data.should eql({:errCode => -3})
        end
    end
    describe "More than 128 characters Username" do
        it "response should be -3" do
            data = User.add("eric" * 129, "test")
            data.should eql({:errCode => -3})
        end
    end
    describe "Empty Password" do
        it "response should be -4" do
            data = User.add("eric", "")
            data.should eql({:errCode => -4})
        end
    end
    describe "More than 128 characters Password" do
        it "response should be -4" do
            data = User.add("eric", "test" * 129)
            data.should eql({:errCode => -4})
        end
    end
    describe "Bad Credential" do
        it "response should be -1" do
            User.add("eric", "test")
            data = User.login("eric", "testtest")
            data.should eql({:errCode => -1})
        end
    end
    describe "Login existing user" do
        it "response should be 1" do
            User.add("eric", "test")
            data = User.login("eric", "test")
            data.should eql({:errCode => 1})
        end
    end
    describe "Adding two different user" do
        it "Count should response with correct value" do
            User.add("eric", "test")
            User.add("secondEric", "testtest")
            data1 = User.login("eric", "test")
            data2 = User.login("secondEric", "testtest")
            data1.should eql({:errCode => 1})
            data2.should eql({:errCode => 1})
        end
    end
    describe "Increment count" do
        it "Count == 2" do
            User.add("eric", "test")
            User.login("eric", "test")
            data = User.find_by_user("eric").count
            data.should eql(2)
        end
    end
end
