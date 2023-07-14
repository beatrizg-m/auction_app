# frozen_string_literal: true

class AddCreatorApproverAndApprovedToBatch < ActiveRecord::Migration[7.0]
  def change
    add_reference :batches, :approved_by, foreign_key: { to_table: :users }
    add_reference :batches, :created_by, foreign_key: { to_table: :users }
  end
end
