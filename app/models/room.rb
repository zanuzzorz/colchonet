class Room < ActiveRecord::Base
	extend FriendlyId

	scope :most_recent, -> {order(:created_at)}

	# É necessário definir o has_many primeiro!
	has_many :reviews, dependent: :destroy
	has_many :reviewed_rooms, through: :reviews, source: :room

	belongs_to :user

	validates_presence_of :title
	validates_presence_of :slug

	mount_uploader :picture, PictureUploader
	friendly_id :title, use: [:slugged, :history]

	def self.search(query)
		if query.present?
			where(['location ILIKE :query OR title ILIKE :query OR description ILIKE :query', query: "%#{query}%"])
		else
			all
		end
	end

	def complete_name
		"#{title}, #{location}"
	end

end