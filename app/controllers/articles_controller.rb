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

      # render "new" works the same way
      render :new

    end
  end

  def edit
    #@article = Article.new                 ## this will let you pass through the GET request easily

    

    ##@article = Article.new
    ##@article.title = "fghjk"
    ##@article.description = "dfghjkldfghjkvbnk"       ##this will add these values on the input fields as the form is 
                                                       ##capturing the instace variable


    @article = Article.find(params[:id])    ## This will get you the fields auto filled hence allowing you to 
                                            ## take full advantage of model: @article as it will access the url 
                                            ## for you as well as it will know which mode to access via the instance variable it got
  end

  def update 
    
    @article = Article.find(params["id"])

    check = @article.title == params[:article][:title] and @article.description == params[:article][:description]

    if check

      flash[:alert] = "No changes were made."
      redirect_to @article

    else

      check = @article.update(params.require(:article).permit(:title, :description))

      if check

        flash[:notice] = "Your article was updated successfully. "
        redirect_to @article

      else

        render :edit
        
      end
    end
  end

end