class RenamePlantToStation < ActiveRecord::Migration
  def self.up
    rename_table :stations, :stations
  end

  def self.down
    rename_table :stations, :stations
  end
end
