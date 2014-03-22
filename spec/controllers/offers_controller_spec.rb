require "spec_helper"

describe OffersController do
  describe "GET #index" do

    subject { response }

    context "HTTP request" do
      before { get :index }

      it { should be_success }
      it { should render_template('index') }
    end

    context "json request" do
      before do
        matching_uri = VCR.request_matchers.uri_without_params(:timestamp, :hashkey)
        VCR.use_cassette('valid_response', match_requests_on: [:method, matching_uri]) do
          get :index, uid: 1, page: 1, format: :json
        end
      end

      context "with valid required params" do
        let!(:parsed_offers) { ActiveSupport::JSON.decode(response.body)['offers'] }

        it { should be_success }
        it 'returns a list of offers' do
            expect(parsed_offers).to eq([])
        end

        context "when requesting non-existent page" do
          before do
            matching_uri = VCR.request_matchers.uri_without_params(:timestamp, :hashkey)
            VCR.use_cassette('nonexistent_page', match_requests_on: [:method, matching_uri]) do
              get :index, uid: 1, page: 2, format: :json
            end
          end
          let!(:parsed_code) { ActiveSupport::JSON.decode(response.body)['code'] }

          it 'returns appropriate error code' do
            expect(parsed_code).to eq('ERROR_INVALID_PAGE')
          end
        end
      end

      context "with invalid params" do
        before { get :index, format: :json }
        let!(:response_body) { response.body }
        let!(:expected_response) { { uid: ["can't be blank"], page: ["can't be blank"] }.to_json }

        it { should_not be_success }
        it "returns a hash with errors" do
          expect(response_body).to eq(expected_response)
        end
      end

    end
  end
end