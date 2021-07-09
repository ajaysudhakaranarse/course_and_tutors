class CreateTutors < ActiveRecord::Migration[5.1]
  def change
    create_table :tutors do |t|
      t.string :name
      t.string :email
      t.string :mobile
      t.belongs_to :course

      t.timestamps
    end
  end
end
