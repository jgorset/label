require "label/version"
require "label/description_formatter"

require "bundler"
require "optparse"
require "ostruct"

module Label

  class << self

    GEM_REGEXP = /^(?<whitespace> *)gem ['"](?<name>.+?)['"](:?, ['"](?<version>.+?)['"])?/

    def label gemfile = "Gemfile"
      describing = lambda { |name| STDOUT.write "#{name}: " }
      described  = lambda { |description| STDOUT.puts description }

      output = process gemfile, describing, described

      write gemfile, output
    end

    # Process the given Gemfile.
    #
    # gemfile    - A String describing the path to a Gemfile.
    # describing - A Proc to be called once a query to describe a gem begins.
    #              Receives the name of the gem as an argument.
    # described  - A Proc to be called once a query to describe a gem completes.
    #              Receives the description as an argument.
    def process gemfile, describing = nil, described = nil
      file = read gemfile

      lines = file.read.split "\n"

      processed_lines = []

      lines.each_with_index do |line, i|
        match = line.match GEM_REGEXP

        if match
          previous_line = lines[i - 1]

          whitespace = match[:whitespace]
          name       = match[:name]
          version    = match[:version]

          unless previous_line =~ /^ *#/
            describing.call(name) if describing

            description = describe(name, version)

            described.call(description) if described

            processed_lines << format(description, "#{whitespace}#")
          end
        end

        processed_lines << line
      end

      processed_lines.join("\n") + "\n"
    end

    # Read the given file.
    #
    # file - A String describing the path to a file.
    def read file
      File.open file
    end

    # Write to the given file.
    #
    # file - A String describing the path to a file.
    # text - A String describing text to be written.
    def write file, text
      File.open file, "w" do |file|
        file.write text
      end
    end

    # Describe the given gem.
    #
    # name    - A String with the name of a gem.
    # version - A String describing the version of a gem.
    #
    # Returns a String.
    def describe name, version = nil
      requirement = Gem::Requirement.new(version)

      or_raise = -> do
        raise Gem::LoadError.new("Could not find '#{name}' (#{requirement})")
      end

      specs.find or_raise do |spec|
        spec.name == name &&
        requirement.satisfied_by?(spec.version)
      end.summary
    end

    private

    def specs
      @specs ||= Bundler.load.specs
    end

    def format description, prepend_string
      DescriptionFormatter.format description, prepend_string
    end

  end

end
