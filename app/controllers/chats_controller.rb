class ChatsController < ApplicationController
	before_action :authenticate_user!

	def index
		@chats = Chat.all
	end

	def new
		@chat = Chat.new
	end

	def create
    @chat = current_user.chats.new(chat_params)
    
    @chat.save
      redirect_to @chat
  	end

  	def show
  		@chat = Chat.find(params[:id])
  	end

  	private
	    def chat_params
	      params.require(:chat).permit(:title)
	    end
end