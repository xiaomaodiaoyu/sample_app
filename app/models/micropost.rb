class Micropost < ActiveRecord::Base
  attr_accessible :contents
  belongs_to :user

  validates :user_id, presence: true
  validates :contents, presence: true, length: { maximum: 140 }

  default_scope order: 'microposts.created_at DESC'

  # Returns microposts from the users being followed by the given user.
  def self.from_users_followed_by(user)
  	followed_user_ids = "SELECT followed_id FROM relationships
                     WHERE follower_id = :user_id"

	where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
           user_id: user.id)
  end
end
