class UsersController < ApplicationController
    
  def login
      @data = User.login(params[:user], params[:password])
      
      respond_to do |format|
          #format.html
          format.json { render :json => @data }
      end
  end

  def add
      @data = User.add(params[:user], params[:password])
      
      respond_to do |format|
          #format.html
          format.json { render :json => @data }
      end
  end
    
end
