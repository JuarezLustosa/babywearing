# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    skip_before_action :require_no_authentication, only: %i[new create]

    def create
      super
      return unless resource.persisted?

      set_flash_message!(:notice, current_user == resource ? :signed_up : :signed_up_by_user)
      resource.send_welcome_email
    end

    private

    # so as not to sign in new user when user created by volunteer
    def sign_up(resource_name, resource)
      super unless current_user
    end

    def sign_up_params
      params.require(:user).permit(:email, :password, :password_confirmation,
                                   :first_name, :last_name, :street_address,
                                   :street_address_second, :city, :state,
                                   :postal_code, :phone_number)
    end

    def account_update_params
      params.require(:user).permit(:email, :password, :password_confirmation,
                                   :current_password, :first_name, :last_name,
                                   :street_address, :street_address_second,
                                   :city, :state, :postal_code, :phone_number)
    end
  end
end
