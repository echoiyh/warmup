class TestapiController < ApplicationController

  def resetFixture
      @data = User.TESTAPI_resetFixture()
      respond_to do |format|
          format.json { render :json => @data }
      end
  end

  def unitTests
      `rspec > unit.txt`
      fileOutput = File.read("unit.txt")
      nrTest = fileOutput[/(.*)example/, 1]
      nrFail = fileOutput[/,(.*)failure/, 1]
      respond_to do |format|
          format.json { render :json => {:totalTests => nrTest.to_i, :nrFailed => nrFail.to_i, :output => 'Success'} }
      end
  end

end
