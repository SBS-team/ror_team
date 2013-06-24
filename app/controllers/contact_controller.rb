class ContactController < ApplicationController
  def new
    @data_set[:user_name] = "text"
  end

  def create
      render :text => @data_set[:user_name]
  end
end
