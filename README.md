# Gull
## Easy Google Sign-in for Rails + Devise Applications

![Gull](https://www.iconshock.com/image/Stroke/Animals/gull)

_________

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-google-oauth2'
gem 'gull', github: 'petlove/gull'
```

And then execute:

    $ bundle install
_________

## Dependencies
  This application assumes you're on [Rails](https://rubyonrails.org/) and has [Devise](https://github.com/plataformatec/devise) configured

_________

## Usage

To actually full-fledgedly use google sign in with Gull you need to follow some steps in order to configure your application properly.

### After installing the gem, run the migration as following:
For Google Sign-in to work, your user model and schema needs to have two extra attributes, called `provider` and `uid`.

Luckily **Gull** does the **dull** (heh) task of migrating your database for you so you don't have to worry about your inner application migrations:

Simply install Gull and inside your application's root directory run

    $ bundle exec rake gull:update_user

### Create your custom application's google sign-in credentials in here:
https://developers.google.com/identity/sign-in/web/sign-in#specify_your_apps_client_id

**TIP:** do not forget to add the google sign-in callback `Authorized redirect URIs` to your application's google_oauth callback (luckily abstracted away via Gull), something along the lines of `https://<application_domain>/users/auth/google_oauth2/callback`

### Google API Keys configuration inside Gull:

API keys must be configured in the gem setup. You can do this anywhere in your application before you make API calls using the gem.

```ruby
Gull.configure do |config|
  config.google_client_id = '<HASH>.apps.googleusercontent.com'
  config.google_client_secret = '<HASH>'
  config.logo_name = 'my_logo.png' #default is logo.png
  config.logo_style = 'margin-top: 100px;'
end
```
**TIP:** for easily referrable configuration, you can put the configuration block above in the first lines of your `config/initializers/devise.rb` file

### Configuring devise:

Open up your `config/initializers/devise.rb` file, in the section segmented as ` # ==> Omiauth` add the configuration options bellow:

```ruby
config.omniauth :google_oauth2,
                Gull.configuration.google_client_id,
                Gull.configuration.google_client_secret,
                hd: '<YOUR_DOMAIN>', prompt: 'select_account'
        # hardcoded domain lock ^
```

### Configuring your User model:

Open up your user model and add `extend Gull` to it.

Next, where your devise configuration is located, add the following attributes so you'll end up with something like this:
```ruby
class User < ActiveRecord::Base
  extend Gull

  devise # some attributes...
         :omniauthable, omniauth_providers: %I(google_oauth2)
end
```

### Configuring your Rail Routes:

This one is pretty simple. In your main routes file, add this to your `devise_for` configuration

```ruby

devise_for :users, # other configuration...
, controllers: { omniauth_callbacks: 'gull/omniauth_callbacks' }
                                # actually important part ^
```

### Setting up the Google Sign-in Button into your application:

This one is even simpler, just add this to the view you want to render the button in, usually located at `views/devise/sessions/new.html.erb`

```ruby
  <%= render "gull/sign_in_button" %>
```

... And *Voilá*, you have a Google Sign-in in your Rails + Devise application, give yourself a good pat on the back, you're the champ!

### Login page

In /app/views/devise/new.html.erb is defined the default login page. If you want, you can change the settings `logo_name` and `logo_style`.
By default, this is the login page:

![image](https://i.ibb.co/mqH8PRt/screencapture-localhost-3100-users-sign-in-2019-09-05-14-49-32.png)