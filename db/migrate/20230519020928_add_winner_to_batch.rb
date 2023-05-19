class AddWinnerToBatch < ActiveRecord::Migration[7.0]
  def change
    add_reference :batches, :winner, null: true, foreign_key: { to_table: :users }
  end
end
