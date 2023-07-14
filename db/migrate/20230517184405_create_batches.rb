# frozen_string_literal: true

class CreateBatches < ActiveRecord::Migration[7.0]
  def change
    create_table :batches do |t|
      t.string :code
      t.date :start_date
      t.date :final_date
      t.integer :minimum_value
      t.integer :minimum_difference
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
