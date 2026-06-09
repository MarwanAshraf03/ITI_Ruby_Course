class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ edit update destroy ]
  before_action :set_article_global, only: %i[ show report ]
  before_action :authenticate_user!, only: %i[ new edit update destroy ]

  # GET /articles or /articles.json
  def index
    # @articles = Article.where(archived: [ false, nil ])
    @articles = Article.all
  end

  # GET /articles/1 or /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = current_user.articles.build
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    @article = current_user.articles.build(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @article.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: "Article was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @article.errors, status: :unprocessable_content }
      end
    end
  end

  def report
    @article.update(reports_count: (@article.reports_count || 0) + 1)
    @article.save

    respond_to do |format|
      format.html { redirect_to articles_path, notice: "Thank you for reporting this article." }
      format.json { head :no_content }
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy!

    respond_to do |format|
      format.html { redirect_to articles_path, notice: "Article was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private

    def set_article_global
      @article = Article.find(params.expect(:id))
    end

    def set_article
      @article = current_user.articles.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.expect(article: [ :title, :body, :image ])
    end
end
