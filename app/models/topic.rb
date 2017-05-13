class Topic < ActiveRecord::Base
  default_scope -> {order(updated_at: :desc)}

  validates :content, presence: true

  belongs_to :user

  mount_uploader :picture, PictureUploader

end
