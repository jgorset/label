module Label
  class DescriptionFormatter

    FIRST_SENTENCE_REGEXP = /(?<first_sentence>.+?(\.\s|\Z))/m
    CHARACTERS_PER_LINE = 90

    # Formats a description
    #
    # description - A description String to be formatted.
    # separator   - A String to be used as aditional separator formatting
    def self.format description, separator = ''
      if md = description.match(FIRST_SENTENCE_REGEXP)
        break_in_lines md[:first_sentence].strip, separator
      else
        "#{separator} #{description}"
      end
    end

    private

    # split lines that are too long in multiple lines
    def self.break_in_lines description, separator = ''
      description.gsub!(/\n/, ' ')
      description = "#{separator} #{description}"

      index = CHARACTERS_PER_LINE
      while description.length > index
        index = previous_space_index description, index
        new_line_string = "\n#{separator} "
        description[index] = new_line_string
        index += CHARACTERS_PER_LINE + new_line_string.length
      end
      description
    end

    # given a string returns and an index returns the index of the first previous
    # space character in the given string
    def self.previous_space_index description, index
      limit_char = description[index]
      while limit_char != ' '
        index -= 1
        limit_char = description[index]
      end
      index
    end
  end

end
