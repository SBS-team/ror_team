class CreateClientTestimonials < ActiveRecord::Migration
  def change
    create_table :client_testimonials do |t|
      t.text :comment_text, null: false
      t.string :author_name, null: false
      t.string :author_position
      t.integer :project_id, null: false
      t.timestamps
    end
  end
end
