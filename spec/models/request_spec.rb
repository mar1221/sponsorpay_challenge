require "spec_helper"

describe Request do
  let (:request) { Request.new(uid: 1, pub0: '1', page: 1) }

  it 'is valid with valid attributes' do
    request.should be_valid
  end

  it 'is invalid without a uid' do
    request.uid = nil
    request.should_not be_valid
  end

  it 'is invalid without a page' do
    request.page = nil
    request.should_not be_valid
  end

  it 'is invalid if a page is not a positive integer' do
    request.page = 'a'
    request.should_not be_valid
  end
end