# frozen_string_literal: true

class AddApprovedToBatch < ActiveRecord::Migration[7.0]
  def change
    add_column :batches, :approved, :boolean, default: false
  end
end
