class OaPersonCreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people, :force => true do |t|
      t.string   :provider,        :limit => 50,                    :null => false
      t.string   :uid,             :limit => 50,                    :null => false
      t.text     :auth_hash
      t.string   :name,            :limit => 60
      t.string   :email,           :limit => 70
      t.string   :photo_url
      t.datetime :created_at
      t.datetime :updated_at
      t.string   :link
      t.string   :login,           :limit => 60
    end

    add_index :people, [:provider, :uid]
  end

  def self.down
    drop_table :people
  end
end
