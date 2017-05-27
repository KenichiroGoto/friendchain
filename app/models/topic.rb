class Topic < ActiveRecord::Base
  default_scope -> {order(updated_at: :desc)}

  validates :content, presence: true

  belongs_to :user

  has_many :comments, dependent: :destroy

  mount_uploader :picture, PictureUploader

end
