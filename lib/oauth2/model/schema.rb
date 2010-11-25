module OAuth2
  module Model
    
    class Schema < ActiveRecord::Migration
      def self.up
        create_table :oauth2_clients, :force => true do |t|
          t.timestamps
          t.string :name
          t.string :client_id
          t.string :client_secret_hash, :limit => 40
          t.string :client_secret_salt, :limit => 32
          t.string :redirect_uri
        end
        add_index :oauth2_clients, :client_id
        
        create_table :oauth2_authorizations, :force => true do |t|
          t.timestamps
          t.string     :oauth2_resource_owner_type
          t.integer    :oauth2_resource_owner_id
          t.belongs_to :client
          t.string     :scope
          t.string     :code
          t.string     :access_token
          t.string     :refresh_token
          t.datetime   :expires_at
        end
        add_index :oauth2_authorizations, [:client_id, :code]
        add_index :oauth2_authorizations, [:access_token]
        add_index :oauth2_authorizations, [:client_id, :access_token]
        add_index :oauth2_authorizations, [:client_id, :refresh_token]
      end
      
      def self.down
        drop_table :oauth2_clients
        drop_table :oauth2_authorizations
      end
    end
    
  end
end

