class GameSessionsController < ApplicationController
  OBJECT_NAME = :game_session
  PERMITTED_ATTRIBUTES = [
    :play_date,
    :player_ids => [],
    :game_sessions_users_attributes => %i(id user_id fraction _destroy)]


  respond_to :html

  expose(:game_sessions)
  expose(:game_session, attributes: :permitted_params)

  def index
    gon.jbuilder

    respond_with :game_sessions
  end

  def show
    respond_with game_session
  end

  def new
    5.times { game_session.game_sessions_users.build }

    respond_with game_session
  end

  def create
    game_session.save

    respond_with game_session
  end

  def edit
    respond_with game_session
  end

  def update
    game_session.save

    respond_with game_session
  end
end
