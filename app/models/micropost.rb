class Micropost < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.content_micropost_maxlength}
  scope :od, ->{order created_at: :desc}
end
