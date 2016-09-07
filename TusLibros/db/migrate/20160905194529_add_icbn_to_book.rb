class AddIcbnToBook < ActiveRecord::Migration
  def change
    add_column :books, :icbn, :string
  end
end
