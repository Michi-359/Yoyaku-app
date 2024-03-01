class Room < ApplicationRecord
    validates :room_name, presence: true
    validates :room_content, presence: true
    validates :room_price, presence: true
    validates :room_address, presence: true
    belongs_to :user
    has_many :reservations
end
