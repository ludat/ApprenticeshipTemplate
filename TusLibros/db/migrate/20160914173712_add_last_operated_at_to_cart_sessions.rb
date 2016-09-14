class AddLastOperatedAtToCartSessions < ActiveRecord::Migration
  def change
    add_column :cart_sessions, :last_operated_at, :datetime
  end
end
