class CategoriesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @categories = Category.all
    if @categories.empty?
      flash[:notice] = 'Não há categorias cadastradas.'
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, notice: 'Categoria criada com sucesso'
    else
      flash[:notice] = 'Não foi possivél criar categoria'
      render 'new'
    end
  end

  private

  def category_params
    category_params = params.require(:category).permit(:name, :description)
  end
end
