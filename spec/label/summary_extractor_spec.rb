require "label/summary_extractor"

describe Label::SummaryExtractor do

  describe "#extract_summary" do
    # TODO: use contexts
    context "for double quoted strings containing single quoted strings" do
      it "should extract summary" do
        content = "s.email       = [\"fespinozacast@gmail.com\"]\n  s.homepage    = \"fespinoza.github.io\"\n  s.summary     = \"A series of generators an other rails 'defaults' for my projects\"\n  s.description = \"TODO.\"\n  s.license     = \"MIT\"\n\n"
        extractor = Label::SummaryExtractor.new(content)
        expect(extractor.extract_summary).to eq "A series of generators an other rails 'defaults' for my projects"
      end
    end

    context "for single quoted strings containing double quoted strings" do
      it "should extract summary" do
        content = "s.email       = [\"fespinozacast@gmail.com\"]\n  s.homepage    = \"fespinoza.github.io\"\n  s.summary     = 'A series of generators an other rails \"defaults\" for my projects'\n  s.description = \"TODO.\"\n  s.license     = \"MIT\"\n\n"
        extractor = Label::SummaryExtractor.new(content)
        expect(extractor.extract_summary).to eq "A series of generators an other rails \"defaults\" for my projects"
      end
    end

    context "for strings defined with %q{}" do
      it "should extract summary" do
        content = "s.email       = [\"fespinozacast@gmail.com\"]\n  s.homepage    = \"fespinoza.github.io\"\n  s.summary     = %q{A series of generators an other rails \"defaults\" for my 'projects'}\n  s.description = \"TODO.\"\n  s.license     = \"MIT\"\n\n"
        extractor = Label::SummaryExtractor.new(content)
        expect(extractor.extract_summary).to eq "A series of generators an other rails \"defaults\" for my 'projects'"
      end
    end

    context "for different gem configuration variable names" do
      it "should extract summary" do
        content = "g.email       = [\"fespinozacast@gmail.com\"]\n  g.homepage    = \"fespinoza.github.io\"\n  g.summary     = %q{A series of generators an other rails \"defaults\" for my 'projects'}\n  g.description = \"TODO.\"\n  g.license     = \"MIT\"\n\n"
        extractor = Label::SummaryExtractor.new(content)
        expect(extractor.extract_summary).to eq "A series of generators an other rails \"defaults\" for my 'projects'"
      end
    end

  end
end
