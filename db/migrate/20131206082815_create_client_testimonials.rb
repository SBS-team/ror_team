class CreateClientTestimonials < ActiveRecord::Migration
  def change
    create_table :client_testimonials do |t|
      t.text :comment_text
      t.string :author_name
      t.string :author_position
      t.integer :project_id
      t.timestamps
    end
  end
end
