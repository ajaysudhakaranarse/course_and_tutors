# frozen_string_literal: true

class CreateTutors < ActiveRecord::Migration[5.1]
  def change
    create_table :tutors do |t|
      t.string :name
      t.string :mobile
      t.belongs_to :course

      t.timestamps
    end
  end
end
