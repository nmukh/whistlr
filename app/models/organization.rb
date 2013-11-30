class Organization < ActiveRecord::Base
  include Attributes::Social
  include Attributes::Uploadable
  include Friendly::SluggableBase

  strip_attributes

  belongs_to :parent, -> { where type: "Organization::Master" }, class_name: "Organization"
  has_many :children, -> { where type: "Organization::Master" }, class_name: "Organization", foreign_key: :parent_id
  has_many :products

  validates :name, presence: true

end