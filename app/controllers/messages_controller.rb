class MessagesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_chat

	def index
		if current_user == @chat.sender || current_user == @chat.recipient || current_user.admin
			@other = current_user == @chat.sender ? @chat.recipient : @chat.sender
			@msgs = @chat.messages.order("created_at DESC")
		else
			redirect_to chats_path, alert: "Permission denied."
		end
	end

	def create
		@msg = @chat.messages.new(message_params)
		@msgs = @chat.messages.order("created_at DESC")

		if @msg.save
			redirect_to chat_messages_path(@chat)
		end
	end

	def edit
		@msg = @chat.messages.find(params[:id])
	end

	def update
		@msg = @chat.messages.find(params[:id])

		if(@msg.update(message_params))
			redirect_to chat_messages_path
		else
			render 'edit'
		end
	end

	def destroy
		@msg = @chat.messages.find(params[:id])
		@msg.destroy
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