class BatchesController < ApplicationController
  before_action :require_admin!, only: [:new, :create, :edit, :update, :destroy, :close, :show_finished_batches]
  before_action :authenticate_user_or_admin!, only: [:winning_batches]

  def index
    @batches = Batch.all
  end

  def new
    @batch = Batch.new
    @items = Item.where(:batch_id => nil)
  end

  def create
    @batch = Batch.new(batch_params)
    @batch.created_by_id = current_user.id
    if @batch.save
      redirect_to batches_path, notice: 'Lote cadastrado esperando por aprovação.'
    else
      @items = Item.where(:batch_id => nil)
      flash[:notice] = 'Não foi possível cadastrar o lote'
      render 'new'
    end
  end

  def show
    @batch = Batch.find(params[:id])
  end

  def edit
    @batch = Batch.find(params[:id])
    if current_admin.id != @batch.created_by_id
      redirect_to root_path, notice: 'Você não pode editar este lote.'
    else
      @items = Item.where(batch_id: [nil, @batch.id])
    end
  end

  def update
    @batch = Batch.find(params[:id])
    if @batch.update(batch_params)
      redirect_to batches_path, notice: 'lote atulizado'
     else
      flash[:notice] = 'nao foi possivel atualizar o lote'
      render 'edit'
    end

  end

  def destroy
    @batch = Batch.find(params[:id])
    @batch.delete
    redirect_to finished_batches_path, notice: "Lote cancelado com sucesso"
  end

  def show_finished_batches
    @batches = Batch.all.filter {|batch| batch.finished? || !batch.winner}
  end

  def winning_batches
    @batches = Batch.all.filter {|batch| batch.winner}
  end

  def close
    @batch = Batch.find(params[:id])
    @bid = @batch.bids.find_by(value: @batch.bids.maximum(:value))
    @batch.winner_id = @bid.user_id
    @batch.save
  end


  def approve
    @batch = Batch.find(params[:id])
    if current_admin.id != @batch.created_by_id
      @batch.approved_by_id = current_admin.id
      @batch.approved = true
      begin
        @batch.save!
        flash[:notice] = "Lote #{@batch.code} aprovado com sucesso"
      rescue => exception
        flash[:notice] = exception
      end
    else
      flash[:notice] = 'Apenas outro administrador pode aprovar o lote'
    end
    redirect_to batches_path
  end

  def search
    @code = params['query']
    @batches = Batch.where("code LIKE ?", "%#{@code}%")
  end

  private

  def batch_params
    batch_params = params.require(:batch).permit(:code, :start_date, :final_date, :minimum_value, :minimum_difference, item_ids: [])
  end

  def authenticate_user_or_admin!
    unless current_user.admin? || current_user.user?
      redirect_to root_path, notice: 'Acesso negado.'
    end
  end

end
