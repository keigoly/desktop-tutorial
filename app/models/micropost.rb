class Micropost < ApplicationRecord
  has_many :notifications,dependent: :destroy
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate  :picture_size

  private

    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
    
    def create_notification_by(current_user)
    notification=current_user.active_notifications.new(
      micropost_id:self.id,
      visited_id:self.contributer.id,
      action:"like"
    )
    notification.save if notification.valid?
    end
end
