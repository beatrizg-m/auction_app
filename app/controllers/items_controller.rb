class ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
    @categories = Category.all
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to items_path, notice: 'Item cadastrado com sucesso'
    else
      render 'new'
      flash[:notice] = 'Não foi possível cadastrar o item.'
    end
  end

  private

  def item_params
    item_params = params.require(:item).permit(:name, :description, :weight, :width, :height, :depth, :category_id, :code)
  end
end
