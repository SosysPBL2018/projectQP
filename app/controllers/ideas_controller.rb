class IdeasController < ApplicationController
  include LikesHelper
  before_action :authorize, only: [:new, :create]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @idea = Idea.find(params[:id])
  end

  def new
    @idea = Idea.new
  end

  def create
    topic = Topic.find(params[:topic_id])
    @idea = topic.ideas.build(idea_params)
    @idea.user_id = current_user.id
    @idea.save
    redirect_to topic_path(topic)
  end

  def edit
    @idea = Idea.find(params[:id])
  end

  def update
    @idea = Idea.find(params[:id])
    if @idea.update(idea_params)
      redirect_to idea_path(id: @idea)
    else
      render :edit
    end
  end

  def destroy
    @idea = Idea.find(params[:id])
    @idea.destroy
    redirect_to topic_path(id: @idea.topic)
  end


  private
  def idea_params
    params.require(:idea).permit(:title, :body, :topic_id)
  end

  def ensure_correct_user
    @idea = current_user.ideas.find_by(id: params[:id])
    redirect_to topics_path if @idea.nil?
  end


end