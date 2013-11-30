require "label"

def fixture file
  File.read "spec/fixtures/#{file}"
end
