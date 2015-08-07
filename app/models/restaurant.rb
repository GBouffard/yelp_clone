class Restaurant < ActiveRecord::Base
  validates :name, length: { minimum: 3 }, uniqueness: true
  has_many :reviews, dependent: :destroy
  belongs_to :user
  has_attached_file :image, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: '/images/Guillaume-yelp.gif'
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}

  def average_rating
    return 'N/A' if reviews.none?
    reviews.average(:rating)
  end
end
