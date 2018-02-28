
class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat

  def index
    if current_user == @chat.sender || current_user == @chat.recipient || current_user.role == 'admin'
      @other = current_user == @chat.sender ? @chat.recipient : @chat.sender
      @messages = @chat.messages.order("created_at DESC")
    else
      redirect_to chats_path, alert: "You don't have permission to view this."
    end
  end

  def create
    @message = @chat.messages.new(message_params)
    @messages = @chat.messages.order("created_at DESC")

    if @message.save
      redirect_to chat_messages_path(@chat)
    end
  end

  def edit
    @chat = Chat.find(params[:chat_id])
    @message = @chat.messages.find(params[:id])
  end

  def update
    @chat = Chat.find(params[:chat_id])
    @message = @chat.messages.find(params[:id])
    if @message.update(message_params)
      redirect_to chat_messages_path
    else
      render 'edit'
    end
  end

  def destroy
    @chat = Chat.find(params[:chat_id])
    @message = @chat.messages.find(params[:id])
    @message.destroy
    redirect_to chat_messages_path
  end

  private
    def set_chat
      @chat = Chat.find(params[:chat_id])
    end
    def message_params
      params.require(:message).permit(:content, :user_id)
    end
end