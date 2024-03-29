class Admin < ApplicationRecord
  devise :omniauthable, omniauth_providers: [:google_oauth2]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # ensures that only tamu emails can be authorized
  def self.from_google(email:, full_name:, uid:, avatar_url:)
    return nil unless /@tamu.edu\z/.match?(email)

    create_with(uid: uid, full_name: full_name, avatar_url: avatar_url).find_or_create_by!(email: email)
  end

  def user
    User.find_by(email: self.email)
  end
end
