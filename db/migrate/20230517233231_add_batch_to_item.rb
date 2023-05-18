class AddBatchToItem < ActiveRecord::Migration[7.0]
  def change
    add_reference :items, :batch
  end
end
