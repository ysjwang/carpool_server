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

class Contact < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validate :validate_first_or_last_name_present


  private

  def validate_first_or_last_name_present
    if first_name.blank? && last_name.blank? 
      errors.add(:first_name, "or last name must be set.")
      errors.add(:last_name, "or last name must be set")

    end
  end
end
