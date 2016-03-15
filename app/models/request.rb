class Request < ActiveRecord::Base
  belongs_to :user
  has_many :items, dependent: :destroy
  has_one :location, dependent: :destroy
  has_one :deliver, dependent: :destroy
  belongs_to :category
  belongs_to :status
  has_one :profile, :through => :user

  acts_as_mappable :through => :location

  accepts_nested_attributes_for :items, reject_if: lambda {|attributes| attributes['ItemsName'].blank?}
  accepts_nested_attributes_for :location, reject_if: lambda {|attributes| attributes['address'].blank?}
  accepts_nested_attributes_for :location, reject_if: lambda {|attributes| attributes['Lat'].blank?}

  validates :PlaceName, :cost, :fees, presence: true


  scope :request_deliver_select, -> { select(:id, :PlaceName, :created_at, :cost, :fees, :delivery_at, :first_name, :last_name, :email, :CatName, :picture, :Lat, :Long, :receipt_img ) }
  scope :current_delivery, ->(current) { joins(:deliver, :profile, :category, :location).where('delivers.user_id = ?', current ) }
  scope :recent_deliver , -> { order('delivers.request_id desc') }




end
