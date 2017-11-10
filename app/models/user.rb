# frozen_string_literal: true

# User model methods.
class User < ApplicationRecord
  def self.find_or_create_from_auth_hash(auth_hash)
    user = where(
      provider: auth_hash.provider, uid: auth_hash.uid
    ).first_or_create
    user.update(
      name: auth_hash.info.nickname,
      token: auth_hash.credentials.token,
      secret: auth_hash.credentials.secret
    )
    user
  end

  validates :provider, presence: true
  validates :uid, presence: true
  validates :name, presence: true
  validates :token, presence: true
  validates :secret, presence: true
end
