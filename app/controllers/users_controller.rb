class UsersController < ApplicationController
  respond_to :html

  expose(:users)
  expose(:user)

  def index
    respond_with users
  end

  def show
    gon.jbuilder

    respond_with user
  end
end
