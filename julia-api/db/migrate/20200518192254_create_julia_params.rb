class CreateJuliaParams < ActiveRecord::Migration[6.0]
  def change
    create_table :julia_params do |t|
      t.float :min_x
      t.float :max_x
      t.float :min_y
      t.float :max_y
      t.float :real
      t.float :img

      t.timestamps
    end
  end
end
