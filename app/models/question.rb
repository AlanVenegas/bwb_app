class Question < ActiveRecord::Base
	belongs_to :user
	has_many :answers, dependent: :destroy
  default_scope -> { order('created_at DESC') }
	validates :user_id, presence: true
	validates :title, presence:true, length: { maximum: 140 }
	validates :content, presence: true
end
