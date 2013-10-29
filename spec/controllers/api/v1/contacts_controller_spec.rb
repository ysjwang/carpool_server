require 'spec_helper'

describe API::V1::ContactsController do

  before :each do
    @contact_user = create(:user)
  end

  context 'with user correctly authenticated' do 

    before :each do
      # sign the user in...
    end

    describe 'GET #index' do
      it 'returns http success' do
        get :index
        expect(response).to be_success
      end

      it 'returns with JSON' do
        contact = create(:contact, user: @contact_user)
        get :index, format: :json
        expect(response.body).to have_content contact.to_json
      end

      it 'should populate @contacts with all contacts' do
        john = create(:contact, first_name: 'John', user: @contact_user)
        tom = create(:contact, first_name: 'Tom', user: @contact_user)
        expect(assigns(:contacts)).to match(array([tom, john]))
      end
      
    end

    describe 'GET #show' do

      it 'returns http success' do
        user = create(:user)
        contact = create(:contact, user: user)
        get :show, id: contact
        expect(response).to be_success
      end

      it 'returns with JSON' do
        contact = create(:contact, user: @contact_user)
        get :show, id: contact
        expect(response.body).to have_content contact.to_json
      end

      it 'should assign the requested contact to @contact' do
        contact = create(:contact, user: @contact_user)
        get :show, id: contact
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
          patch :update, id: @contact, contact: attributes_for(:contact)
          expect(assigns(:contact)).to eq(contact)
        end

        it 'changes the contact attributes' do
          patch :update, id: @contact, contact: attributes_for(:contact, first_name: 'Tom', last_name: 'Riddle')
          @contact.reload
          expect(@contact.first_name).to eq('Tom')
          expect(@contact.last_name).to eq('Riddle')
        end

      
      end

      context 'invalid attributes' do
        it 'does not change the contact attributes' do
          patch :update, id: @contact, contact: attributes_for(:contact, first_name: 'Tom', last_name: nil)
          @contact.reload
          expect(@contact.first_name).to eq('Harry')
          expect(@contact.last_name).to eq('Potter')
        end

        it 'throws an error'

      end


    end
  end

  context 'with user incorrectly authenticated' do

    it 'throws an error'

  end

end
