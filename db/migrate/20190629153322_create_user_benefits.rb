class CreateUserBenefits < ActiveRecord::Migration[5.1]
  def change
    create_table :user_benefits do |t|
      t.references :benefit, foreign_key: true
      t.references :user, foreign_key: true
      t.string :coupon_code

      t.timestamps
    end
  end
end
