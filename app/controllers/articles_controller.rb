class ArticlesController < ApplicationController

  def show  
    #article = Article.find(params[:id]) ###over here it is just a standard variable which is not passed in to your views
    #for passing it you will be needing an instance variable instead of a regular variable
    # byebug
    @article = Article.find(params[:id])
    # @article = Article.find(params["id"])  ### both will work in the same way
  end

  def index

    @articles = Article.all
    
  end

end