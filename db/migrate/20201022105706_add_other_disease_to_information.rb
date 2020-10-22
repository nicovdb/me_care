class AddOtherDiseaseToInformation < ActiveRecord::Migration[6.0]
  def change
    add_column :information, :other_disease, :string
  end
end
