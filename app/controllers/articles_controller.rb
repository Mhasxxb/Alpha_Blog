class ArticlesController < ApplicationController

  def show  
    #article = Article.find(params[:id]) ###over here it is just a standard variable which is not passed in to your views
    #for passing it you will be needing an instance variable instead of a regular variable
    # byebug
    @article = Article.find(params[:id])
    # @article = Article.find(params["id"])  ### both will work in the same way
    if @article == nil
      byebug
    end
  end

  def index

    @articles = Article.all

  end

  def new
    @article = Article.new()
  end

  def create
    title = params[:article][:title]
    description = params[:article][:description]
    @article = Article.new
    @article.title = title
    @article.description = description
    if @article.save
      
      flash["notice"] = "Article creation was successful."

      redirect_to article_path(@article)
    else
      render "new"
    end
  end

  def edit
    
    @article = Article.new()
  
  end

  def update 
  

  
  end

end