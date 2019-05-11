class AddAttachmentAvatarValidationCompromiseToUsers < ActiveRecord::Migration[5.1]
  def self.up
    change_table :users do |t|
      t.attachment :avatar
      t.attachment :validation
      t.attachment :compromise
    end
  end

  def self.down
    remove_attachment :users, :avatar
    remove_attachment :users, :validation
    remove_attachment :users, :compromise
  end
end
