class Amazonapi < ApplicationRecord

  # Amazon API Constants
  ENDPOINT = "webservices.amazon.com"
  REQUEST_URI = "/onca/xml"

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

  def self.search_results(keywords)
    HTTParty.get(search_aws_by_keyword(keywords))
  end
end
