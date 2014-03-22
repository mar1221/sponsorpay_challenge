class OffersController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json do
        request = Request.new(uid: params[:uid], pub0: params[:pub0], page: params[:page])
        if request.valid?
          response = OffersApiService.new(request).get_offers
          render json: response, status: response.code
        else
          render json: request.errors.to_json, status: 422
        end
      end
    end
  end
end
