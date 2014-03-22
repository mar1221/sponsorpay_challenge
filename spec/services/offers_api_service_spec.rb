require "spec_helper"

describe OffersApiService do
  def matching_uri
    VCR.request_matchers.uri_without_params(:timestamp, :hashkey)
  end

  describe '#initialize' do

    let!(:service_config) { HashWithIndifferentAccess.new(
      YAML.load(File.read(File.expand_path(
        '../../../config/service_config.yml', __FILE__))
      )
    ) }

    context 'using valid request object' do
      let! (:request) { Request.new(uid: 1, page: 1) }
      let! (:service) { OffersApiService.new(request) }

      it 'should initialize with correct api_key' do
        api_key = service.instance_variable_get(:@api_key)
        api_key.should eq(service_config[:api_key])
      end

      it 'should initialize with correct appid' do
        options = service.instance_variable_get(:@options)
        options[:query][:appid].should eq(service_config[:appid])
      end

      it 'should initialize with correct uid' do
        options = service.instance_variable_get(:@options)
        options[:query][:uid].should eq(request.uid)
      end

      it 'should initialize with correct pub0' do
        options = service.instance_variable_get(:@options)
        options[:query][:pub0].should eq(request.pub0)
      end

      it 'should initialize with correct page' do
        options = service.instance_variable_get(:@options)
        options[:query][:page].should eq(request.page)
      end
    end

    context 'using invalid request object' do
      let!(:request) { Request.new(page: 1) }

      it 'should raise an exception' do
        expect { OffersApiService.new(request) }.to raise_error(OffersApiService::InvalidRequest)
      end
    end
    context 'using other object as a Request class object' do
      it 'should raise an exception' do
        expect { OffersApiService.new(String.new('s')) }.to raise_error(OffersApiService::InvalidObjectAsArgument)
      end
    end
  end

  describe '#get_offers' do
    let! (:service) { OffersApiService.new(Request.new(uid: 1, page: 1)) }
    before do
      VCR.use_cassette('valid_response', match_requests_on: [:method, matching_uri]) do
        @response = service.get_offers
      end
    end

    it 'should return a list of offers' do
      @response['offers'].should match_array([])
    end

    context 'with signature mismatch' do
      it 'should raise an exception' do
        VCR.use_cassette('wrong_signature', match_requests_on: [:method, matching_uri]) do
          expect { service.get_offers }.to raise_error(OffersApiService::MissingSignature)
        end
      end
    end

  end
end
