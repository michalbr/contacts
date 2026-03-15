class Contact < ApplicationRecord
  has_and_belongs_to_many :labels
  validates_presence_of :first_name, :last_name
  validates :email, email: { allow_blank: true }
end
