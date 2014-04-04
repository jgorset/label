module Label
  # A class to extract the summary from the contents of a gemspec file
  class SummaryExtractor
    attr_reader :content

    STRING_REGEXPS = [
      /\"(?<content>[^"]*)\"/,
      /'(?<content>[^']*)'/,
      /%q\{(?<content>[^}]*)\}/,
    ]

    def initialize content
      @content = content
    end

    def extract_summary
      STRING_REGEXPS.each do |regexp|
        md = content.match(/\w+\.summary\s+=\s+#{regexp}/)
        return md[:content] if md
      end
    end
  end
end
