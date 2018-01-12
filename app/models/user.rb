class User < ApplicationRecord

  has_one :list
  has_many :gifts, through: :list
  has_many :categories, through: :gifts
  has_many :reviews

  validates :username, :presence => true, :uniqueness => {
      :case_sensitive => false }
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: %i[facebook]

  after_create :create_list

  attr_accessor :login

  def create_list
    self.list = List.new
    save
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.username = make_random_username(auth.info.name)
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.image = auth.info.image
    end
  end

  def self.make_random_username(name)
    num = Random.new
    name.split(" ").first + num.rand(100000..999999).to_s
  end

  def wrote_a_review?(gift)
    id = gift.reviews.where(user: self).pluck(:id)
    review = Review.find_by(id: id)
    review == [] ? false : review
  end

  def most_popular_categories
    self.categories.group("category_id").order("COUNT(category_id) DESC").limit(3)
  end
end
