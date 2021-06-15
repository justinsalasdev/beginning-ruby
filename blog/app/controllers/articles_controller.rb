class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end


  def show
    @article = Article.find(params[:id])
  end

  def new #when new route matches; only instantiate blank article and save it to @article
    #to be used as initial values of form in new.html.erb
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new
    end

  end


  def edit #when edit route matches; only find req article and save it to @article
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to article_path @article
    else
      render :edit
    end
  end

  
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path @articles
  end

  private

  def article_params
    params.require(:article).permit(:title,:body)
  end

  

end
