class API::V1::ContactsController < ApplicationController

  force_ssl if Rails.env.production?
  
  respond_to :html, :xml, :json, :js

  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/javascript' || c.request.format == 'application/json' }

  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers

  before_filter :authenticate_user_from_token!, except: [:cor_preflight_check, :cors_set_access_control_headers]
  before_filter :authenticate_user!, except: [:cor_preflight_check, :cors_set_access_control_headers]

  # If this is a preflight OPTIONS request, then short-circuit the
  # request, return only the necessary headers and return an empty
  # text/plain.

  def cors_preflight_check

    if request.method == :options
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
      headers['Access-Control-Max-Age'] = '1728000'
      render :text => '', :content_type => 'text/plain'

    end
  end

  # For all responses in this controller, return the CORS access control headers.

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Max-Age'] = "1728000"
    # puts 'post flight works'
  end

  def show

    @contact = Contact.find(params[:id])
    respond_with(@contact) do |format|
      format.html { render json: @contact }
      format.js { render json: @contact, callback: params[:callback] }
    end
  end

  def index

    @contacts = Contact.all.order('id')
    respond_with(@contacts) do |format|
      format.html { render json: @contacts }
      format.js  { render json: @contacts, callback: params[:callback] }
    end
  end

  # def edit
  # end

  # def options
  #   # puts "I am in options.."
  # end

  def update

    @contact = Contact.find(params[:id])
    respond_to do |format|
      if @contact.update(contact_params)

        @contacts = Contact.all.order('id')
        @contacts = @contacts.reload

        format.html { render json: @contacts }
        format.js { render json: @contacts, callback: params[:callback] }
      else

        @contacts = Contact.all.order('id')
        @contacts = @contacts.reload

        format.html { render json: @contacts }
        format.js { render json: @contacts, callback: params[:callback] }
      end
    end
  end



  private

  def contact_params
    params.require(:contact).permit(:first_name, :last_name)
  end

  def authenticate_user_from_token!
    # First we find the user based on the email provided
    user_email = params[:user_email].presence
    user = user_email && User.find_by_email(user_email)

    # Check if the user exists, and if the tokens match
    if user && Devise.secure_compare(user.authentication_token, params[:user_token])
      # sign them in but don't store session
      sign_in user, store: false
    end

  end







end
