class Gift < ApplicationRecord
  has_many :list_gifts
  has_many :lists, through: :list_gifts
  has_many :users, through: :lists
  has_many :category_gifts
  has_many :categories, through: :category_gifts

  # Amazon API Constants
  ENDPOINT = "webservices.amazon.com"
  REQUEST_URI = "/onca/xml"

  def categories_attributes=(categories_attributes)
    categories_attributes.each do |i, cat_attr|
      self.categories << (Category.find_or_create_by(name: cat_attr[:name]))
    end
  end

  def self.generate_aws_request_url(params)
    # Set current timestamp if not set
    params["Timestamp"] = Time.now.gmtime.iso8601 if !params.key?("Timestamp")

    # Generate the canonical query
    canonical_query_string = params.sort.collect do |key, value|
      [URI.escape(key.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]")), URI.escape(value.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))].join('=')
    end.join('&')

    # Generate the string to be signed
    string_to_sign = "GET\n#{ENDPOINT}\n#{REQUEST_URI}\n#{canonical_query_string}"

    # Generate the signature required by the Product Advertising API
    signature = Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), ENV['AWS_SECRET_KEY'], string_to_sign)).strip()

    # Generate the signed URL
    request_url = "http://#{ENDPOINT}#{REQUEST_URI}?#{canonical_query_string}&Signature=#{URI.escape(signature, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))}"
  end

  def self.search_aws_by_keyword(keywords)
    params = {
      "Service" => "AWSECommerceService",
      "Operation" => "ItemSearch",
      "AWSAccessKeyId" => ENV['AWS_ACCESS_KEY_ID'],
      "AssociateTag" => ENV['AWS_ASSOCIATE_TAG'],
      "SearchIndex" => "All",
      "Keywords" => keywords,
      "ResponseGroup" => "Images,ItemAttributes,Offers"
    }
    generate_aws_request_url(params)
  end

  def self.amazon_search_results(keywords)
    HTTParty.get(search_aws_by_keyword(keywords))
  end

  def self.new_gift_from_amazon(item)
    new_gift = self.new

    if item["MediumImage"]["URL"]
      new_gift.image = item["MediumImage"]["URL"]
    elsif item["ImageSets"]["ImageSet"][0]["MediumImage"]["URL"]
      new_gift.image = item["ImageSets"]["ImageSet"][0]["MediumImage"]["URL"]
    else
      new_gift.image = ""
    end

    new_gift.name = item["ItemAttributes"]["Title"]
    new_gift.url = item["DetailPageURL"]
    new_gift.price = item["OfferSummary"]["LowestNewPrice"]["Amount"].to_f/100 if item["OfferSummary"]["LowestNewPrice"]

    if item["ItemAttributes"]["Feature"].is_a?(Array)
      new_gift.description = item["ItemAttributes"]["Feature"].join(" ")
    elsif item["ItemAttributes"]["Feature"]
      new_gift.description = item["ItemAttributes"]["Feature"]
    else
      new_gift.description = "No description"
    end

    new_gift
  end
end
