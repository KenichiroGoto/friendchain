class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.build(comment_params)
    @topic = @comment.topic
    respond_to do |format|
      if @comment.save
        format.html {redirect_to topics_path, notice: 'コメントを投稿しました。'}
        format.js {render :index}
      else
        format.html {render :new}
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    respond_to do |format|
      @comment.destroy
      format.html {redirect_to topics_path, notice: 'コメントを削除しました。'}
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:topic_id, :content)
    end

end
