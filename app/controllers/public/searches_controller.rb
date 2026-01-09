class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def index
    @range = params[:range]
    @word = params[:word]

    if @range == "User"
      @search = User.ransack(name_cont: @word)
      @results = @search.result
    else
      @search = Post.ransack(title_cont: @word)
      @results = @search.result
    end
  end
end
