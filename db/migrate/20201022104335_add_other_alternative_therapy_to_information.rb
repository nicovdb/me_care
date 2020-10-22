class AddOtherAlternativeTherapyToInformation < ActiveRecord::Migration[6.0]
  def change
    add_column :information, :other_alternative_therapy, :string
  end
end
