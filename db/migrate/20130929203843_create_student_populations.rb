class CreateStudentPopulations < ActiveRecord::Migration[4.2]
  def change
    create_table :student_populations do |t|
      t.string :name
      t.timestamps
    end
  end
end
