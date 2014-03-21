require "spec_helper"

describe Request do
  it 'is valid with valid attributes' do
    request = Request.new(uid: 1, page: 1)
    request.should be_valid
  end

  it 'is invalid without a uid' do
    request = Request.new(page: 1)
    request.should_not be_valid
  end

  it 'is invalid without a page' do
    request = Request.new(uid: 1)
    request.should_not be_valid
  end

  it 'is invalid if a page is not a positive integer' do
    request = Request.new(uid: 1, page: 'a')
    request.should_not be_valid
  end
end