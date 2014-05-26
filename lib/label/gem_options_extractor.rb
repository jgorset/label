module Label
  # Takes a line gotten from a Gemfile and returns all the options associated
  # to that gem
  class GemOptionsExtractor
    attr_reader :gem_options

    def initialize(line)
      @line = line
      @gem_options = {}
    end

    # parses into a hash all the option specified for a gem including the
    # source which is <tt>:rubygems</tt> by default (optional values: :github,
    # :git or :path)
    def extract!
      @raw_options = line.split(',')
      extract_version_if_defined
      normalize_options.each do |option|
        gem_options[option[:name]] = option[:value]
      end
      gem_options[:rubygems] = true if source_empty?
    end

    private

    attr_reader :line
    attr_writer :gem_options
    attr_accessor :raw_options

    def extract_version_if_defined
      # the second position always should be
      # the version number
      if raw_options[1] && !raw_options[1].match(/:/)
        gem_options[:version] = clean_value(raw_options[1])
      end
    end

    def normalize_options
      raw_options.map do |raw_option|
        if raw_option.match(':')
          args = raw_option.split(':').map { |arg| clean_value(arg) }
          { name: args.first.to_sym, value: args.last }
        end
      end.compact
    end

    def clean_value(value)
      value.to_s.strip.gsub(/('|\")/, '')
    end

    def source_empty?
      !(gem_options.key?(:github) ||
        gem_options.key?(:git) ||
        gem_options.key?(:path))
    end
  end
end
