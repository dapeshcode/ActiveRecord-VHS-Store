class RemoveRentalIdAndVhsIdFromClients < ActiveRecord::Migration[5.2]
  def change

    remove_column :clients, :vhs_id
    remove_column :clients, :rental_id
  end
end
