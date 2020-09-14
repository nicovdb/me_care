class AddMiscarriageToInformations < ActiveRecord::Migration[6.0]
  def change
    add_column :information, :miscarriage, :boolean
    add_column :information, :miscarriage_number, :integer
  end
end
