class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index

    if @conversation.sender_id == current_user.id
      @companion = User.find(@conversation.recipient_id)
    elsif @conversation.recipient_id == current_user.id
      @companion = User.find(@conversation.sender_id)
    end

    @messages = @conversation.messages
    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end

    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end

    if @messages.last
      if @messages.last.user_id != current_user.id
        @messages.last.read = true
        @messages.last.save
      end
    end
    @message = @conversation.messages.build
  end

  def create
    @message = @conversation.messages.build(message_params)
    if @message.save
      redirect_to conversation_messages_path(@conversation)
    else
      redirect_to conversation_messages_path(@conversation), flash: {error: "メッセージを入力して下さい。"}
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to conversation_messages_path(@conversation), notice: "メッセージを削除しました。"
  end

  private
    def message_params
      params.require(:message).permit(:body, :user_id)
    end
end
