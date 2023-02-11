class Admin < ApplicationRecord
  devise :omniauthable, omniauth_providers: [:google_oauth2]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
end
