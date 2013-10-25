# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

require 'spec_helper'

describe Contact do
  
  context 'validations' do

    before :each do
      @user = create(:user)
    end

    it 'should be valid with a first_name, last_name, and user' do
      contact = build(:contact, first_name: 'John', last_name: 'Smith', user: @user)
      expect(contact).to be_valid
    end

    it 'should not be valid without either a first_name or a last_name' do
      contact1 = build(:contact, first_name: nil, last_name: nil, user: @user)
      expect(contact1).to have_at_least(1).errors_on(:first_name)
      expect(contact1).to have_at_least(1).errors_on(:last_name)

      contact2 = build(:contact, first_name: nil, user: @user)
      expect(contact2).to be_valid

      contact3 = build(:contact, last_name: nil, user: @user)
      expect(contact3).to be_valid
    end

    it 'should not be valid without a user_id' do
      contact = build(:contact, user: nil)
      expect(contact).to have_at_least(1).errors_on(:user_id)
    end

  end




end
