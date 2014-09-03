class Photo < ActiveRecord::Base
  belongs_to :user
  has_many :comments, as: :commentable

  has_attached_file :image , styles: {medium: "300*300>", thumb: "100*100>" },default_url: "/images/:style/missing.png"

  validates_attachment_file_name :image, matches: [/png\Z/, /jpe?g\Z/, /gif\Z/]
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
