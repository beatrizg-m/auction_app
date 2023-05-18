class RemoveItemReferenceFromBatches < ActiveRecord::Migration[7.0]
  def change
    change_table :batches do |t|
      remove_reference :batches, :item
    end
  end
end
