VCR.configure do |c|
  #the directory where your cassettes will be saved
  c.cassette_library_dir = 'spec/cassettes'
  # your HTTP request service. You can also use fakeweb, webmock, and more
  c.hook_into :webmock
  c.allow_http_connections_when_no_cassette = true
end