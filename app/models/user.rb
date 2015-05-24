class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # def after_sign_in_path_for(users)
  #   /users/:id
  # end

  # def after_sign_out_path_for(resource_or_scope)
  #   # your_path
  # end
end
