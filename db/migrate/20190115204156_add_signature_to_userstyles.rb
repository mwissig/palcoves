class AddSignatureToUserstyles < ActiveRecord::Migration[5.2]
  def change
    add_column :userstyles, :signature, :string
    add_column :userstyles, :signature_css, :string
  end
end
