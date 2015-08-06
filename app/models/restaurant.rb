class Restaurant < ActiveRecord::Base
  validates :name, length: { minimum: 3 }, uniqueness: true
  has_many :reviews, dependent: :destroy
  belongs_to :user

  def average_rating
    'N/A'
  end
end
