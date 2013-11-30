class Product < ActiveRecord::Base
  include Attributes::Social
  include Attributes::Uploadable
  include Friendly::SluggableBase

  strip_attributes

  belongs_to :organization, -> { where type: "Organization::Master" }, class_name: "Organization"

  validates :name, presence: true
  validates :ean13, allow_nil: true, numericality: { only_integer: true }, length: { is: 13 }
  validates :organization, presence: true

  delegate :name, to: :organization, prefix: true

end