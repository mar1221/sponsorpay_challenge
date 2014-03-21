require "spec_helper"

describe OffersController do
  describe "GET #index" do

    context "HTTP request" do
      it "responds with an HTTP 200 status code" do
        get :index
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it "renders the index template" do
        get :index
        expect(response).to render_template("index")
      end
    end

    context "json request" do
      context "with valid required params" do

        context 'without a response signature' do
          it 'raises an exception' do
            pending('Pending')
          end
        end

        context 'with a response signature' do

          it "responds with an HTTP 200 status code" do
            pending("Pending")
          end

          it 'returns a list of offers' do
            pending("Pending")
          end
        end
      end

      context "with invalid params" do
        it "responds with HTTP 422 status code" do
          get :index, format: :json
          expect(response.status).to eq(422)
        end

        it "returns a hash with errors" do
          get :index, format: :json
          expected_response = { uid: ["can't be blank"], page: ["can't be blank"] }.to_json
          expect(response.body).to eq(expected_response)
        end
      end

    end
  end
end