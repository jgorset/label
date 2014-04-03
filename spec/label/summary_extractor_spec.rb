require "label/summary_extractor"

describe Label::SummaryExtractor do

  describe "#extract_summary" do
    it "should extract summary" do
      # different scenarios regarding different types of string delimitations
      content = "s.email       = [\"fespinozacast@gmail.com\"]\n  s.homepage    = \"fespinoza.github.io\"\n  s.summary     = \"A series of generators an other rails 'defaults' for my projects\"\n  s.description = \"TODO.\"\n  s.license     = \"MIT\"\n\n"
      extractor = Label::SummaryExtractor.new(content)
      expect(extractor.extract_summary).to eq "A series of generators an other rails 'defaults' for my projects"

      content = "s.email       = [\"fespinozacast@gmail.com\"]\n  s.homepage    = \"fespinoza.github.io\"\n  s.summary     = 'A series of generators an other rails \"defaults\" for my projects'\n  s.description = \"TODO.\"\n  s.license     = \"MIT\"\n\n"
      extractor = Label::SummaryExtractor.new(content)
      expect(extractor.extract_summary).to eq "A series of generators an other rails \"defaults\" for my projects"

      content = "s.email       = [\"fespinozacast@gmail.com\"]\n  s.homepage    = \"fespinoza.github.io\"\n  s.summary     = %q{A series of generators an other rails \"defaults\" for my 'projects'}\n  s.description = \"TODO.\"\n  s.license     = \"MIT\"\n\n"
      extractor = Label::SummaryExtractor.new(content)
      expect(extractor.extract_summary).to eq "A series of generators an other rails \"defaults\" for my 'projects'"

      content = "g.email       = [\"fespinozacast@gmail.com\"]\n  g.homepage    = \"fespinoza.github.io\"\n  g.summary     = %q{A series of generators an other rails \"defaults\" for my 'projects'}\n  g.description = \"TODO.\"\n  g.license     = \"MIT\"\n\n"
      extractor = Label::SummaryExtractor.new(content)
      expect(extractor.extract_summary).to eq "A series of generators an other rails \"defaults\" for my 'projects'"
    end

  end
end
