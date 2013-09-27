class AddDefaultValueToVisits < ActiveRecord::Migration
  def up
    change_column :urls, :visits, :integer, default: 0
  end

  def down
    change_column :urls, :visits, :integer, default: nil
  end
end
