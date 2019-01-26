class Secret < ApplicationRecord
	belongs_to :user, optional: true
	validates :encrypted_secret, presence: true, uniqueness: true, length: { minimum: 5 }	
end
