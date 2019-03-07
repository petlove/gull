# frozen_string_literal: true

module Gull
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      omni_auth = request.env['omniauth.auth'].except('extra')
      @user = User.from_omniauth(omni_auth)

      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
      else
        session['devise.google_data'] = omni_auth
        redirect_to new_user_registration_url
      end
    end

    def failure
      redirect_to root_path
    end
  end
end
