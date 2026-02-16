module Api
  class ArticlesController < Api::ApplicationController
    before_action :set_article, only: [:show, :update, :destroy]

    #rescues
    
    rescue_from StandardError, with: :handle_internal_error
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    # POST /api/articles
    def create
      article = current_user.articles.build(article_params)

      if article.save
        render json: { message: I18n.t('articles.created'), 
                       article: ::ActiveModelSerializers::SerializableResource.new(article, 
                                                                                   serializer: ::Api::ArticleSerializer) },
               status: :created
      else
        render json: { errors: article.errors.full_messages.presence || [I18n.t('articles.invalid')] },
               status: :unprocessable_entity
      end
    end

    # GET /api/articles
    def index
      limit = params.fetch(:limit, 3).to_i
      offset = params.fetch(:offset, 0).to_

      return render json: { error: I18n.t('errors.limit_invalid') }, status: :unprocessable_entity if limit <= 0
      return render json: { error: I18n.t('errors.offset_invalid') }, status: :unprocessable_entity if offset.negative?

      articles = Article.includes(:user, :categories)
                        .limit(limit)
                        .offset(offset)

      total_count = Article.count

      render json: {
          articles: ActiveModelSerializers::SerializableResource.new(articles, 
                                                                     each_serializer: ::Api::ArticleSerializer),
          meta: {
            total_count: total_count,
            limit: limit,
            offset: offset
          }
        },
          status: :ok
    end

    # GET /api/articles/:id
    def show
      render json: {
        article: ActiveModelSerializers::SerializableResource.new(@article, 
                                                                  serializer: ::Api::ShowArticleSerializer)
      }, 
        status: :ok
    end

    # PATCH/PUT /api/articles/:id
    def update
      if @article.update(article_params)
        render json: { message: I18n.t('articles.actions.updated'), 
                       article: ::ActiveModelSerializers::SerializableResource.new(@article, 
                                                                                   serializer: ::Api::ArticleSerializer) },
               status: :ok
      else
        render json: { errors: @article.errors.full_messages.presence || [I18n.t('articles.invalid')] },
               status: :unprocessable_entity
      end
    end

    # DELETE /api/articles/:id
    def destroy
      @article.destroy
      render json: { message: I18n.t('articles.actions.deleted') }, 
             status: :ok
    end

    private

    def handle_internal_error(exception)
      logger.error exception.message
      logger.error exception.backtrace.join("\n")
      render json: { error: I18n.t("errors.internal_server_error") }, 
             status: :internal_server_error
    end

    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :description, :category_id)
    end

    # Rescue handlers
    def record_not_found
      render json: { error: I18n.t('articles.actions.not_found') }, 
             status: :not_found
    end

    def record_invalid(exception)
      render json: { errors: exception.record.errors.full_messages.presence || [I18n.t('articles.actions.invalid')] },
             status: :unprocessable_entity
    end
  end
end