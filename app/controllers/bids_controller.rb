# frozen_string_literal: true

class BidsController < ApplicationController
  def create
    @bid = Bid.new(value: params[:value], user_id: current_user.id, batch_id: params[:batch_id])
    @batch = Batch.find(params[:batch_id])
    @bid.user_id = current_user.id
    current_difference = @bid.value - (@batch.bids.count.positive? ? @batch.bids.maximum(:value) : 0)
    if @bid.value > @batch.minimum_value && (current_difference >= @batch.minimum_difference) && @batch.in_progress?
      flash[:notice] = if @bid.save
                         'Lance enviado com sucesso'
                       else
                         'Falha ao enviar o lance'
                       end
    else
      flash[:notice] = 'Lance recusado'
    end
    redirect_to batch_path(params[:batch_id])
  end
end
