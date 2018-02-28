class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :user

  validates_presence_of :content, :chat_id, :user_id

  def message_time
  	created_at.strftime("%v");
  end
end
