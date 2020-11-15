class JuliaController < ApplicationController
  # # GET julia
  def index
  end

  # POST julia
  def create
    if o = input_verification(post_params)
      post=JuliaParam.new(o)
      if post.save
        julia_calc(post)
      else
        render json: {status: "ERROR", data: post.errors}
      end
    end
  end

  # GET ulia
  def show
  end

  # GET julia/new
  def new
  end

  # GET julia/edit
  def edit
  end

  # PUT julia
  def update
  end

  # DELETE julia
  def destroy
  end

  private

  #strong
  def post_params
    params.permit(:min_x, :max_x, :min_y, :max_y, :comp_const)
  end
end
