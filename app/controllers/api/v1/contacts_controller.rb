class API::V1::ContactsController < ApplicationController

  respond_to :html, :xml, :json, :js

  


  def show
  end

  def index
    @contacts = Contact.all
    respond_with(@contacts) do |format|
      format.js  { render json: @contacts, callback: params[:callback] }
    end
  end

  def edit
  end

  def update
    puts "I am in update!"
    @contact = Contact.find(params[:id])
    respond_to do |format|
      if @contact.update(contact_params)
        @contacts = Contact.all
        format.js { render json: @contacts, callback: param[:callback] }
      else
        @contacts = Contact.all
        format.js { render json: @contacts, callback: param[:callback] }
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
