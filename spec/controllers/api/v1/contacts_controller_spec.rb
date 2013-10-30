require 'spec_helper'

describe API::V1::ContactsController do

  before :each do
    @contact_user = create(:user)

  end

  context 'with correct user token and email' do 

    before :each do
      # @request.env["devise.mapping"] = Devise.mappings[:user]
      # sign_in :user, @contact_user

    end


    describe 'GET #index' do
      it 'returns http success' do
        get :index, user_email: @contact_user.email, user_token: @contact_user.authentication_token, format: :js
        expect(response).to be_success
      end

      it 'returns with JSON by default' do
        contact = create(:contact, user: @contact_user)
        get :index, user_email: @contact_user.email, user_token: @contact_user.authentication_token,format: :js
        expect(response.body).to have_content contact.to_json
      end

      # TODO: Change this to so that it displays only that user's contacts
      it 'should populate @contacts with all contacts' do
        john = create(:contact, first_name: 'John', user: @contact_user)
        tom = create(:contact, first_name: 'Tom', user: @contact_user)
        get :index, user_email: @contact_user.email, user_token: @contact_user.authentication_token, format: :js
        expect(assigns(:contacts)).to match_array([tom, john])
      end
      
    end

    describe 'GET #show' do

      it 'returns http success' do
        user = create(:user)
        contact = create(:contact, user: user)
        get :show, id: contact, user_email: @contact_user.email, user_token: @contact_user.authentication_token, format: :js
        expect(response).to be_success
      end

      it 'returns with JSON' do
        contact = create(:contact, user: @contact_user)
        get :show, id: contact, user_email: @contact_user.email, user_token: @contact_user.authentication_token, format: :js
        expect(response.body).to have_content contact.to_json
      end

      it 'should assign the requested contact to @contact' do
        contact = create(:contact, user: @contact_user)
        get :show, id: contact, user_email: @contact_user.email, user_token: @contact_user.authentication_token, format: :js
        expect(assigns(:contact)).to eq contact
      end

      it 'should throw an error for a nonexistent @contact'


    end

    describe 'PATCH #update' do
      before :each do
        @contact = create(:contact, first_name: 'Harry', last_name: 'Potter', user: @contact_user)
      end
      context 'valid attributes' do
        it 'locates the requested @contact' do
          put :update, id: @contact, contact: attributes_for(:contact), user_email: @contact_user.email, user_token: @contact_user.authentication_token, format: :js
          expect(assigns(:contact)).to eq(@contact)
        end

        it 'changes the contact attributes' do
          put :update, id: @contact, contact: attributes_for(:contact, first_name: 'Tom', last_name: 'Riddle'), user_email: @contact_user.email, user_token: @contact_user.authentication_token, format: :js
          @contact.reload
          expect(@contact.first_name).to eq('Tom')
          expect(@contact.last_name).to eq('Riddle')
        end


      end

      context 'invalid attributes' do
        it 'does not change the contact attributes' do
          put :update, id: @contact, contact: attributes_for(:contact, first_name: nil, last_name: nil), user_email: @contact_user.email, user_token: @contact_user.authentication_token, format: :js
          @contact.reload
          expect(@contact.first_name).to eq('Harry')
          expect(@contact.last_name).to eq('Potter')
        end

        it 'throws an error'

      end


    end
  end

  context 'without correct user token and email' do

    before :each do
      # Ensure the testing is actually signed out
    end

    describe 'GET #index' do
      it 'responds with a 401' do
        get :index, format: :js
        expect(response.response_code).to eq 401
      end
    end

    describe 'GET #show' do
      it 'responds with a 401' do
        contact = create(:contact, user: @contact_user)
        get :show, id: contact, format: :json
        expect(response.response_code).to eq 401
      end
    end

    describe 'PATCH #update' do
      it 'responds with a 401' do
        contact = create(:contact, first_name: 'Harry', last_name: 'Potter', user: @contact_user)
        patch :update, id: contact, contact: attributes_for(:contact), format: :js
        expect(response.response_code).to eq 401
      end
    end


  end

end
