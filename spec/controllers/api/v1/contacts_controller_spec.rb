require 'spec_helper'

describe API::V1::ContactsController do


  context 'with user correctly authenticated' do 

    before :each do
      # sign the user in...
    end

    describe 'GET #index' do
      it 'returns http success' do
        get :index
        expect(response).to be_success
      end

      it 'should populate @contacts with all contacts'
      
    end

    describe 'GET #show' do

      it 'returns http success' do
        user = create(:user)
        contact = create(:contact, user: user)
        get :show, id: contact
        expect(response).to be_success
      end

      it 'should assign the requested contact to @contact'


    end

    describe 'PATCH #update' do
      before :each do
        user = create(:user)
        contact = user.contacts.first
      end

      context 'valid attributes' do
        it 'locates the requested @contact'
        it 'changes the contact attributes'
        it 'redirects to the updated contact'
      end

      context 'invalid attributes' do
        it 'does not change the contact attributes'
        it 'throws an error'

      end


    end
  end

  context 'with user incorrectly authenticated' do

    it 'throws an error'
    
  end

end
