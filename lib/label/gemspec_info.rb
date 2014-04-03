require 'label/summary_extractor'
require 'net/http'

module Label
  # A class to represent a gemspec file in order
  # to extract info from it
  class GemspecInfo
    attr_reader :gem_name, :source

    GITHUB_RAW_URL = "https://raw.githubusercontent.com"

    def initialize gem_name, source
      @gem_name = gem_name
      @source   = source
    end

    # Extracts the gemspec summary string
    def summary
      SummaryExtractor.new(content).extract_summary
    end

    # Raw contents of the gemspec file
    def content
      @content ||= fetch_gemspec_content!
    end

    private

    # Fetch the content from a gemspec file that could be remote or
    # that could be a file in the developer computer
    #
    # Returns a string with the gemspec file content
    def fetch_gemspec_content!
      return fetch_gemspec_content_from_git!    if source[:git]

      return fetch_gemspec_content_from_github! if source[:github]

      return fetch_gemspec_content_from_path!   if source[:path]

      return ""
    end

    # for simplicity git protocol calls that match with a github repo
    # will be converted to a github url
    def fetch_gemspec_content_from_git!
      if md = source[:git].match(/git:\/\/github\.com:(?<repo>.*)/)
        source[:github] = md[:repo]
        source.delete :git
        fetch_gemspec_content_from_github!
      end
    end

    def fetch_gemspec_content_from_github!
      repo   = source[:github]
      branch = source[:branch] || "master"
      file_url = "#{GITHUB_RAW_URL}/#{repo}/#{branch}/#{gem_name}.gemspec"
      Net::HTTP.get_response(URI(file_url)).body
    end

    def fetch_gemspec_content_from_path!
      File.readlines("#{source[:path]}/#{gem_name}.gemspec").join "\n"
    end

  end
end
