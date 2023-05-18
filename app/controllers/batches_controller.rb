class BatchesController < ApplicationController
  before_action :authenticate_admin!, only:[:new, :create, :edit, :update]
  def index
    @batches = Batch.all
  end

  def new
    @batch = Batch.new
    @items = Item.where(:batch_id => nil)
  end

  def create
    @batch = Batch.new(batch_params)
    @batch.created_by_id = current_admin.id
    if @batch.save
      redirect_to batches_path, notice: 'Lote cadastrado esperando por aprovação.'
    else
      @items = Item.where(:batch_id => nil)
      flash[:notice] = 'Não foi possível cadastrar o lote'
      render 'new'
    end
  end

  def edit
    @batch = Batch.find(params[:id])
    if @batch.approved
      redirect_to batches_path, notice: "Lote de codigo #{@batch.code} ja foi aprovado e nao pode ser modificado"
    else
      @items = Item.where(batch_id: [nil, @batch.id])
    end
  end

  def update
    @batch = Batch.find(params[:id])
    if @batch.update(batch_params)
      # flash[:notice] = 'lote atulizado'
      redirect_to batches_path, notice: 'lote atulizado'
     else
      flash[:notice] = 'nao foi possivel atualizar o lote'
      render 'edit'
    end
    # redirect_to edit_batch_path
  end

  def approve
    @batch = Batch.find(params[:id])
    if current_admin.id != @batch.created_by_id
      @batch.approved_by_id = current_admin.id
      @batch.approved = true
      @batch.save

    else
      flash[:notice] = 'Apenas outro administrador pode aprovar o lote'
    end
    redirect_to batches_path
  end

  private


  def batch_params
    batch_params = params.require(:batch).permit(:code, :start_date, :final_date, :minimum_value, :minimum_difference, item_ids: [])
  end

end
