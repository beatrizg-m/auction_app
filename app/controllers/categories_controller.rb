# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :require_admin!

  def index
    @categories = Category.all
    return unless @categories.empty?

    flash[:notice] = 'Não há categorias cadastradas.'
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
    params.require(:category).permit(:name, :description)
  end
end
