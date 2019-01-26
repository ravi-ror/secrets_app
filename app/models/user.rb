class User < ApplicationRecord
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
	has_one :secret, dependent: :nullify
  validates_presence_of :first, :last
  validate :secret_exists?
  
  protected

  def secret_exists?
    errors.add(:code, "is not valid") unless secret
  end

  def password_required?
    false
  end
end
