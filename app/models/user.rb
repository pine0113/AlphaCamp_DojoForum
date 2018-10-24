class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
    role == 'admin'
  end

  def join_admin
    if update_attributes(role: 'admin')
      puts 'Success!'
    else
      puts 'Failed to update record. Handle the error.'
    end
  end
end
