class TopicsController < ApplicationController
  before_action :set_topic, only: [:edit, :update, :show, :destroy]

  def index
    @topics = Topic.all
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
    if @topic.save
      redirect_to topics_path, notice: "新しいトピックを投稿しました！"
    else
      render 'new'
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
  end

  def destroy
    @topic.destroy
    redirect_to topics_path, notice: "トピックを削除しました！"
  end

  def confirm
    @topic = Topic.new(topic_params)
    render :new if @topic.invalid?
  end

  private

    def topic_params
      params.require(:topic).permit(:title, :content)
    end

    def set_topic
      @topic = Topic.find(params[:id])
    end
end
