class Endorsement < ActiveRecord::Base
  belongs_to :review, dependent: :destroy
  belongs_to :user, dependent: :destroy
end
