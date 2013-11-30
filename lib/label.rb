require "label/version"
require "optparse"
require "ostruct"
require "gems"

module Label

  class << self

    def label
      output = process "Gemfile"

      write "Gemfile", output
    end
    
    # Process the given Gemfile.
    #
    # gemfile - A String describing the path to a Gemfile.
    def process gemfile
      file = read gemfile

      lines = file.read.split "\n"

      processed_lines = []

      lines.each_with_index do |line, i|
        gem = line[/gem ['"](.+?)['"]/, 1]

        if gem
          previous_line = lines[i - 1]

          unless previous_line.start_with? "#"
            processed_lines << "# #{describe gem}"
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
