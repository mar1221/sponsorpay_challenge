require 'active_model'

class Request
  include ActiveModel::Model

  attr_accessor(:uid, :pub0, :page)

  validates :uid, presence: true
  validates :page, presence: true, format: {
    with: /^\d*$/,
    multiline: true,
    message: 'must be a positive integer.'
  }
end