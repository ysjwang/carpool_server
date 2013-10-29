require 'spec_helper'

describe API::V1::ContactsController do

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to be_success
    end

  end

  describe 'GET #show' do
    it 'returns http success' do
      user = create(:user)
      contact = create(:contact, user: user)
      get :show, id: contact
      expect(response).to be_success
    end
  end


  # describe "GET 'show'" do
  #   it "returns http success" do
  #     get 'show'
  #     response.should be_success
  #   end
  # end

  # describe "GET 'index'" do
  #   it "returns http success" do
  #     get 'index'
  #     response.should be_success
  #   end
  # end


end
