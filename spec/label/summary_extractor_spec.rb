require "label/summary_extractor"

shared_examples "extracts summary" do |expected_summary|
  it "should extract summary" do
    extractor = Label::SummaryExtractor.new(content)
    expect(extractor.extract_summary).to eq expected_summary
  end
end

describe Label::SummaryExtractor do

  describe "#extract_summary" do
    context "for double quoted strings containing single quoted strings" do
      let(:content) { "s.email       = [\"fespinozacast@gmail.com\"]\n  s.homepage    = \"fespinoza.github.io\"\n  s.summary     = \"A series of generators an other rails 'defaults' for my projects\"\n  s.description = \"TODO.\"\n  s.license     = \"MIT\"\n\n" }

      include_examples "extracts summary", "A series of generators an other rails 'defaults' for my projects"
    end

    context "for single quoted strings containing double quoted strings" do
      let(:content) { "s.email       = [\"fespinozacast@gmail.com\"]\n  s.homepage    = \"fespinoza.github.io\"\n  s.summary     = 'A series of generators an other rails \"defaults\" for my projects'\n  s.description = \"TODO.\"\n  s.license     = \"MIT\"\n\n" }

      include_examples "extracts summary", "A series of generators an other rails \"defaults\" for my projects"
    end

    context "for strings defined with %q{}" do
      let(:content) { "s.email       = [\"fespinozacast@gmail.com\"]\n  s.homepage    = \"fespinoza.github.io\"\n  s.summary     = %q{A series of generators an other rails \"defaults\" for my 'projects'}\n  s.description = \"TODO.\"\n  s.license     = \"MIT\"\n\n" }

      include_examples "extracts summary", "A series of generators an other rails \"defaults\" for my 'projects'"
    end

    context "for different gem configuration variable names" do
      let(:content) { "g.email       = [\"fespinozacast@gmail.com\"]\n  g.homepage    = \"fespinoza.github.io\"\n  g.summary     = %q{A series of generators an other rails \"defaults\" for my 'projects'}\n  g.description = \"TODO.\"\n  g.license     = \"MIT\"\n\n" }

      include_examples "extracts summary", "A series of generators an other rails \"defaults\" for my 'projects'"
    end

  end
end
