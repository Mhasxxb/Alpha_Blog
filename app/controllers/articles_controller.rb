class ArticlesController < ApplicationController

  before_action :set_article, only: [ :show, :edit, :destroy, :update ] 
  before_action :require_user, except: [ :show, :index ]
  before_action :require_same_user, only: [ :edit, :update, :destroy ]
  

  def show  
    #article = Article.find(params[:id]) ###over here it is just a standard variable which is not passed in to your views
    #for passing it you will be needing an instance variable instead of a regular variable
    # byebug
    # @article = Article.find(params[:id])  ### both will work in the same way
    # @article = Article.find(params["id"])  ### its being carried out with before_action

    if @article == nil
      byebug
    end
  end

  def index

    @articles = Article.paginate(page: params[:page], per_page: 3)

  end

  def new
    @article = Article.new()
    @text = "Create"
  end

  def create
    # title = params[:article][:title]
    # description = params[:article][:description]
    # @article = Article.new
    # @article.title = title
    # @article.description = description
    # this will work but best practice is:
    byebug
    @article = Article.new(params_of_article)
    @article.user = current_user
    if @article.save
      
      flash["notice"] = "Article creation was successful."

      redirect_to article_path(@article)
    else

      # render "new" works the same way
      @text = "Create"
      render :new

    end
  end

  def edit
    #@article = Article.new                 ## this will let you pass through the GET request easily

    @text = "Edit"

    ##@article = Article.new
    ##@article.title = "fghjk"
    ##@article.description = "dfghjkldfghjkvbnk"       ##this will add these values on the input fields as the form is 
                                                       ##capturing the instace variable

    #its being carried out with before_action
    #@article = Article.find(params[:id])    ## This will get you the fields auto filled hence allowing you to 
                                            ## take full advantage of model: @article as it will access the url 
                                            ## for you as well as it will know which mode to access via the instance variable it got
  end

  def update 
    
    # @article = Article.find(params["id"]) #its being carried out with before_action

    check = ((@article.title == params[:article][:title]) and (@article.description == params[:article][:description]))
    if check

      flash[:notice] = "No changes were made."
      redirect_to @article

    else

      check = @article.update(params_of_article)

      if check

        flash[:notice] = "Your article was updated successfully. "
        redirect_to @article

      else
        @text = "Edit"
        render :edit

      end
    end
  end

  def destroy
    # @article = Article.find(params[:id]) #its being carried out with before_action
    @article.destroy
    flash[:notice] = "Article was deleted successfully."
    redirect_to articles_path

  end

  private

  def set_article

    @article = Article.find(params[:id])

  end

  def params_of_article
    params.require(:article).permit(:title, :description, category_ids: [])
  end

  def require_same_user
  if current_user != @article.user && !current_user.admin
    flash[:alert] = "You can only edit your own article."
    redirect_to @article
  end
end

end