class ChatroomsController < ApplicationController
  def index
    @chatrooms = Chatroom.all
  end

  def show
    @chatrooms = Chatroom.all
    @chatroom = Chatroom.find(params[:id])
    authorize @chatroom
    @message = Message.new
  end
end
