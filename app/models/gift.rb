class Gift < ApplicationRecord
  has_many :list_gifts
  has_many :lists, through: :list_gifts
  has_many :users, through: :lists
  has_many :category_gifts
  has_many :categories, through: :category_gifts
  has_many :reviews
  validates :name, presence: :true, uniqueness: :true
  validates :description, presence: :true
  validates_presence_of :category_gifts

  def categories_attributes=(categories_attributes)
    categories_attributes.values.each do |category_attr|
      if category_attr[:name] != ""
        category = Category.find_or_create_by(name: category_attr[:name])
        category.name = "Uncategorized" if category.name == ""
        self.categories << category
      end
    end
  end

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      self.all
    end
  end

  def self.new_gift_from_amazon(item)
    new_gift = where(url: item["DetailPageURL"]).first_or_initialize
    if item.dig("MediumImage")
      new_gift.image = item.dig("MediumImage", "URL")
    elsif item.dig("ImageSets", "ImageSet", 0)
      new_gift.image = item.dig("ImageSets", "ImageSet", 0, "MediumImage", "URL")
    elsif item.dig("ImageSets", "ImageSet")
      new_gift.image = item.dig("ImageSets", "ImageSet", "MediumImage", "URL")
    else
      new_gift.image = ""
    end

    new_gift.name = item["ItemAttributes"]["Title"]
    new_gift.url = item["DetailPageURL"]

    if item.dig("OfferSummary", "LowestNewPrice")
      new_gift.price = item.dig("OfferSummary", "LowestNewPrice", "Amount").to_f/100
    elsif item.dig("OfferSummary", "LowestUsedPrice")
      new_gift.price = item.dig("OfferSummary", "LowestUsedPrice", "Amount").to_f/100
    else
      new_gift.price = nil
    end

    if item["ItemAttributes"]["Feature"].is_a?(Array)
      new_gift.description = item["ItemAttributes"]["Feature"].join(" ")
    elsif item["ItemAttributes"]["Feature"]
      new_gift.description = item["ItemAttributes"]["Feature"]
    else
      new_gift.description = "No description"
    end

    new_gift.categories.build(name: item["ItemAttributes"]["Binding"])

    new_gift
  end

end
