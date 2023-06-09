class AddCreatorApproverAndApprovedToBatch < ActiveRecord::Migration[7.0]
  def change
    add_reference :batches, :approved_by, foreign_key: { to_table: :admins }
    add_reference :batches, :created_by, foreign_key: { to_table: :admins }
  end
end
