namespace :gull do 
    desc 'Updating User Model to Accomodate Google Sign in Attributes'
    task :update_user => :environment do
        begin
            puts "[Gull] Updating User Model..."
            ActiveRecord::Migration.send(:add_column, :users, :provider, :string, { :null => "", :default => "" })
            ActiveRecord::Migration.send(:add_column, :users, :uid, :string, { :null => "", :default => "" })
            puts "[Gull] User Model Updated!"
        rescue ActiveRecord::StatementInvalid
            puts "[Gull] User Model already has `provider` and `uid' fields"
        end
    end
end    