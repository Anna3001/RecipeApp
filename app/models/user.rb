class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :recipes, dependent: :destroy   
  
  validate :password_complexity

  def password_complexity
    if password.present?
      unless password.match?(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{10,}$/)
        errors.add(:password, "musi zawierać co najmniej 10 znaków, w tym jedną małą literę, jedną dużą literę, jedną cyfrę i jeden znak specjalny.")
      end
    end
  end
end
