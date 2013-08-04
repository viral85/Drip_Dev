class AddIsPublishedToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :is_published, :boolean
  end
end
