require "label"

require "coveralls"
Coveralls.wear!

def fixture file
  File.read "spec/fixtures/#{file}"
end
