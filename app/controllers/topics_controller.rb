class TopicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_topic, only: [:edit, :update, :destroy]

  def index
    @topics = Topic.all
    @topic = Topic.new
  end

  def new
    if params[:back]
      @topic = Topic.new(topic_params)
    else
      @topic = Topic.new
    end
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user_id = current_user.id
    if @topic.save
      redirect_to topics_path, notice: "新しいトピックを投稿しました！"
    else
      @topics = Topic.all
      @topic = Topic.new
      redirect_to topics_path, alert: "本文を入力して下さい。"
      # render 'new'
    end
  end

  def edit
  end

  def update
    if @topic.update(topic_params)
      redirect_to topics_path, notice: "トピックを編集しました！"
    else
      render 'edit'
    end
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def destroy
    @topic.destroy
    redirect_to topics_path, notice: "トピックを削除しました！"
  end

# TBD confirmation routing.
  # def confirm
  #   @topic = Topic.new(topic_params)
  #   render :new if @topic.invalid?
  # end

  private

    def topic_params
      params.require(:topic).permit(:content, :picture)
    end

    def set_topic
      @topic = Topic.find(params[:id])
      # 成りすましチェック
      if @topic.user_id != current_user.id
        redirect_to root_path, alert: "通報しました。"
        return
      end
    end

end
