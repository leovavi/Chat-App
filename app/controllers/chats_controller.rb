class ChatsController < ApplicationController
	before_action :authenticate_user!

	def index
		@allChats = Chat.all
		@chats = Chat.involving(current_user)
	end

	def create
		if Chat.between(params[:sender_id], params[:recipient_id]).present?
			@chat = Chat.between(params[:sender_id], params[:recipient_id]).first
		else
			@chat = Chat.create(chat_params)
		end

		redirect_to chat_messages_path(@chat)
	end

	private
		def chat_params
			params.permit(:sender_id, :recipient_id)
		end
end