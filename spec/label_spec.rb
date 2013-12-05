require "spec_helper"

describe Label do
  describe "#process" do
    it "should label unlabelled gems" do
      allow(File).to receive(:open).with("Gemfile").and_return(StringIO.new fixture("stock_gemfile"))

      allow(subject).to receive(:describe).with("rspec").and_return("BDD for Ruby")

      allow(subject).to receive(:describe).with("carrierwave").and_return(
        "Upload files in your Ruby applications, map them to a range of ORMs, " + 
        "store them on different backends."
      )

      expect(subject.process("Gemfile")).to eq fixture("processed_gemfile")
    end
  end

  describe "#describe" do
    it "should describe a given gem" do
      expect(Gems).to receive(:info).with("label").and_return("info" => "Label gems in your Gemfile")

      expect(subject.describe("label")).to eq "Label gems in your Gemfile"
    end
  end
end
