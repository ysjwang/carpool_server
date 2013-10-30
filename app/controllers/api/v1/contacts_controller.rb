class API::V1::ContactsController < ApplicationController

  respond_to :html, :xml, :json, :js

  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/javascript' || c.request.format == 'application/json' }

  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers



  # If this is a preflight OPTIONS request, then short-circuit the
  # request, return only the necessary headers and return an empty
  # text/plain.

  def cors_preflight_check
    # puts 'i am in preflight start'
    # puts "method is #{request.method}"
    if request.method == :options
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
      headers['Access-Control-Max-Age'] = '1728000'
      render :text => '', :content_type => 'text/plain'
      # puts 'preflight works'
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
    # puts "i am in show..."
    # puts params.inspect
    @contact = Contact.find(params[:id])
    respond_with(@contact) do |format|
      format.html { render json: @contact }
      format.js { render json: @contact, callback: params[:callback] }
    end
  end

  def index
    # puts "I am in index!"
    # puts params.inspect
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
    # puts "I am in update!"
    # puts params.to_yaml
    @contact = Contact.find(params[:id])
    respond_to do |format|
      if @contact.update(contact_params)
        # puts "update succeed"
        @contacts = Contact.all.order('id')
        @contacts = @contacts.reload

        format.html { render json: @contacts }
        format.js { render json: @contacts, callback: params[:callback] }
      else
        # puts "update failed"
        @contacts = Contact.all.order('id')
        @contacts = @contacts.reload

        format.html { render json: @contacts }
        format.js { render json: @contacts, callback: params[:callback] }
      end
    end
  end

  # def update
  #   respond_to do |format|
  #     if @contact.update(contact_params)
  #       format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: 'edit' }
  #       format.json { render json: @contact.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  private

  def contact_params
    params.require(:contact).permit(:first_name, :last_name)
  end
end
