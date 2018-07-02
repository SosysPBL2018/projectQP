class IdeasController < ApplicationController
  include LikesHelper
  before_action :authorize, only: [:new, :create]
  
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
      redirect_to topics_path
    else
      render :edit
    end
  end

  def destroy
    @idea = Idea.find(params[:id])
    @idea.destroy
    redirect_to topics_path
  end


  private
  def idea_params
    params.require(:idea).permit(:title, :body, :topic_id)
  end
end
