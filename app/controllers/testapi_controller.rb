class TestapiController < ApplicationController

  def resetFixture
      @data = User.TESTAPI_resetFixture()
      respond_to do |format|
          format.json {render :json => @data}
      end
  end

  def unitTests
  end

end
