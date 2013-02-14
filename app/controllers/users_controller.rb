class UsersController < ApplicationController
    
  def login
      @data = Users.login(params[:user], params[:password])
      
      respond_to do |format|
          #format.html
          format.json { render :json => @data }
      end
  end

  def add
      @data = Users.add(params[:user], params[:password])
      
      respond_to do |format|
          #format.html
          format.json { render :json => @data }
      end
  end
    
end
