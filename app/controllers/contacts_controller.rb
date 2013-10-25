class ContactsController < ApplicationController

  respond_to :html, :xml, :json, :js

  def create
  end

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
end
