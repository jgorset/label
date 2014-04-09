require "label"

require "coveralls"
Coveralls.wear!

def fixture file
  File.read "spec/fixtures/#{file}"
end

def mock_github_response!
  gemspec_contents = File.readlines("./label.gemspec").join("\n")
  response_double  = double :response_double, body: gemspec_contents
  expect(Net::HTTP).to receive(:get_response).with(anything())
                                             .and_return(response_double)
end
