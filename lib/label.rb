require "label/version"
require "optparse"
require "ostruct"
require "gems"

module Label

  class << self

    def label
      describing = lambda { |gem| STDOUT.write "#{gem}: " }
      described  = lambda { |description| STDOUT.puts description }

      output = process "Gemfile", describing, described

      write "Gemfile", output
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
        matches = line.match /^( *)gem ['"](.+?)['"]/

        if matches
          previous_line = lines[i - 1]

          whitespace = matches[1]
          gem        = matches[2]

          unless previous_line.start_with? "#"
            describing.call gem if describing

            description = describe gem

            described.call description if described

            processed_lines << "#{whitespace}# #{description}"
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
    # gem - A String describing the name of a gem.
    #
    # Returns a String.
    def describe gem
      Gems.info(gem).fetch "info"
    end

  end

end
