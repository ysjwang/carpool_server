# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#

require 'spec_helper'

describe User do

  context 'validations' do
    it 'should be valid with a first name, last name, and email' do
      user = build(:user, first_name: 'Joe', last_name: 'Smith', email: 'hello@email.com')
      expect(user).to be_valid
    end

    it 'should be invalid without a first name' do
      user = build(:user, first_name: nil)
      expect(user).to have_at_least(1).errors_on(:first_name)
    end

    it 'should be valid without a last name' do
      user = build(:user, last_name: nil)
      expect(user).to be_valid
    end

    it 'should be invalid without an email' do
      user = build(:user, email: nil)
      expect(user).to have_at_least(1).errors_on(:email)
    end

  end


end
