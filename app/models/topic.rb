class Topic < ActiveRecord::Base
  default_scope -> {order(updated_at: :desc)}

  validates :title, presence: true
  validates :content, presence: true
end
