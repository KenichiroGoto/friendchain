class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:edit, :update, :destroy]

  def create
    @comment = current_user.comments.build(comment_params)
    @topic = @comment.topic
    respond_to do |format|
      if @comment.save
        format.html {redirect_to topics_path, notice: 'コメントを投稿しました。'}
        format.js {render :index}
      else
        format.html {redirect_to topics_path, alert: "コメント文を入力して下さい。"}
      end
    end
  end

  def edit
    # respond_to do |format|
    #   format.html {redirect_to edit_topic_comment_path}
    #   format.js {render :edit, topic: @topic}
    # end
  end

  def update
    @comment.update(comment_params)
    if @comment.save
      redirect_to topics_path
    else
      render 'edit'
    end
  end

  def destroy
    respond_to do |format|
      @comment.destroy
      format.html {redirect_to topics_path, notice: 'コメントを削除しました。'}
      format.js {render :index}
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:topic_id, :content)
    end

    def set_comment
      @comment = Comment.find(params[:id])
      @topic = @comment.topic
      # 成りすましチェック
      if @comment.user_id != current_user.id
        redirect_to root_path, alert: "通報しました。"
        return
      end
    end

end
