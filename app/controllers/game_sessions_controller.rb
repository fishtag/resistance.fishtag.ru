class GameSessionsController < ApplicationController
  OBJECT_NAME = :game_session
  PERMITTED_ATTRIBUTES = [
    :play_date,
    :game_sessions_users_attributes => %i(id user_id fraction _destroy),
    :rounds_attributes => [:id, :winner, :participant_ids => []]]

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
    5.times { game_session.rounds.build } unless game_session.rounds.any?

    respond_with game_session
  end

  def update
    game_session.save

    respond_with game_session
  end
end
