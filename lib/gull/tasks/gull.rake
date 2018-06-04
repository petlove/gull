namespace :gull do 
    desc 'Updating User Model to Accomodate Google Sign in Attributes'
    task :update_user => :environment do
        sh 'bundle exec rails generate migration AddOmniauthToUsers provider:string uid:string'
        Rake::Task['db:migrate'].invoke
    end
end    