require "spec_helper"
require "label/gemspec_info"

describe Label::GemspecInfo do

  describe "#summary" do
    it "should extract the summary from a gem from a github repo" do
      mock_github_response!
      info = Label::GemspecInfo.new "label", github: "jgorset/label"
      expect(info.summary).to eq "Label labels the gems in your Gemfile"
    end

    it "should extract the summary from a gem from a git repo" do
      mock_github_response!
      info = Label::GemspecInfo.new "label", git: "git://github.com:jgorset/label"
      expect(info.summary).to eq "Label labels the gems in your Gemfile"
    end

    it "should extract the summary from a gem from a path" do
      info = Label::GemspecInfo.new "label", path: "./"
      expect(info.summary).to eq "Label labels the gems in your Gemfile"
    end
  end

end
