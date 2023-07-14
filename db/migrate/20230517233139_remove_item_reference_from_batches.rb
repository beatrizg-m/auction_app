# frozen_string_literal: true

class RemoveItemReferenceFromBatches < ActiveRecord::Migration[7.0]
  def change
    change_table :batches do |_t|
      remove_reference :batches, :item
    end
  end
end
