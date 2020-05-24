class JuliaParamsController < ApplicationController
  #before_action :set_post, only: [:show]

  # # GET /julia
  # def index
  #   posts = Post.order(created_at: :desc)
  #   render json: { startus: 'SUCCESS', message: 'hello', data: posts }
  #   #json_response(@todos)
  # end

  # POST /julia_params
  def create
    if input_verification(post_params)
      post=JuliaParam.new(post_params)
      if post.save
        julia(post)
      else
        render json: {status: "ERROR", data: post.errors}
      end
    end
  end

  # GET /julia_params
  def show
    #render json: { startus: 'SUCCESS', message: 'Loaded the post', data: @post }
    #json_response(@todo)
  end

  # GET /julia_params/new
  def new
  end

  # GET /julia_params/edit
  def edit
  end

  # PUT /julia_params
  def update
  end

  # DELETE /julia_params
  def destroy
  end

  private

  # def set_post
  #   @param = JuliaParam.find(julia_params[:id])
  # end

  #strong
  def post_params
    params.permit(:min_x, :max_x, :min_y, :max_y, :real, :img)
  end
end
