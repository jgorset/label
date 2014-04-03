module Label
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
        md = content.match(/s\.summary\s+=\s+#{regexp}/)
        return md[:content] if md
      end
      return ""
    end
  end
end
