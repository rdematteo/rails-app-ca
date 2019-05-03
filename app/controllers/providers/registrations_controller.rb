# frozen_string_literal: true

class Providers::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  after_action :add_cuisine_id_to_provider, only: :create   
  #GET /resource/sign_up
  def new
    @cuisine = Cuisine.all
    super
  end

  #POST /resource
  def create
    super
  end

  #GET /resource/edit
  def edit
    super
  end

  #PUT /resource
  def update
    super
  end

  #DELETE /resource
  def destroy
    super
  end

  #GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    super
  end

  protected
  def add_cuisine_id_to_provider
    last_provider = Provider.last 
    last_provider.cuisine_id = params["cuisine_id"]
    last_provider.save
  end 
  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    # devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :username, :password, :password_confirmation, :firstname, :lastname, :name, :city, :state, :postcode, :minimum_persons, :cost_per_head, :dob, :remember_me, :cuisine_id) }
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
    @provider = current_provider
    @listing = Listing.create(name: params[:provider][:name], provider: @provider)
    listing_path(@listing)
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end
end