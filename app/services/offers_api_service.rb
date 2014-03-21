class OffersApiService
  class InvalidObjectAsArgument < StandardError
    def to_s
      'Argument must be object of class Request'
    end
  end
  class InvalidRequest < StandardError
    def to_s
      'Request object is invalid'
    end
  end
  class MissingSignature < StandardError
    def to_s
      'Response lacks signature or has been tempered'
    end
  end

  include HTTParty
  base_uri 'http://api.sponsorpay.com/feed/v1/offers.json'

  def initialize(request)
    raise InvalidObjectAsArgument unless request.class.name == 'Request'
    raise InvalidRequest unless request.valid?

    service_config = HashWithIndifferentAccess.new(
      YAML.load(File.read(File.expand_path(
        '../../../config/service_config.yml', __FILE__))
      )
    )

    @api_key = service_config[:api_key]

    @options = {
      query: {
        appid: service_config[:appid],
        locale: 'de',
        os_version: '6.0',
        timestamp: Time.now.to_i,
        ip: '109.235.143.113',
        device_id: '2b6f0cc904d137be2e1730235f5664094b831186',
        offer_types: 112,
        uid: request.uid,
        pub0: request.pub0,
        page: request.page
      }
    }

    @options[:query][:hashkey] = calculate_hashkey(@options)
  end

  def get_offers
    response = self.class.get('', @options)
    verify_response_signature(response)
  end

  private

    def calculate_hashkey(options)
      sorted_array = options[:query].sort.map do |key,value|
        "#{key.to_s}=#{value.to_s}"
      end
      Digest::SHA1.hexdigest(sorted_array.join('&') + '&' + @api_key)
    end

    def verify_response_signature(response)
      hashed_response = Digest::SHA1.hexdigest(response.body + @api_key)
      response_signature = response.headers['x-sponsorpay-response-signature']
      raise MissingSignature unless hashed_response == response_signature
      response
    end
end
