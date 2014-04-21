module Label
  class DescriptionFormatter

    FIRST_SENTENCE_REGEXP = /(?<first_sentence>([^.]*https?:\/\/[^\s]*\..*\..*)|([^.]*\.))(?<rest>.*)/
    CHARACTERS_PER_LINE = 90

    def self.format input_string, prepend_string = ''
      if md = input_string.match(FIRST_SENTENCE_REGEXP)
        formatted_description = md[:first_sentence].strip
        if formatted_description.length > CHARACTERS_PER_LINE
          break_in_lines formatted_description, prepend_string
        else
          "#{prepend_string} #{formatted_description}"
        end
      else
        "#{prepend_string} #{input_string}"
      end
    end

    def self.break_in_lines input_string, prepend_string = ''
      # replace all line breaks for spaces
      input_string.gsub!(/\n/, ' ')
      input_string = "#{prepend_string} #{input_string}"

      index = CHARACTERS_PER_LINE
      while input_string.length > index

        # get the previous space an insert a new line there
        limit_char = input_string[index]
        while limit_char != ' '
          index -= 1
          limit_char = input_string[index]
        end
        new_line_string = "\n#{prepend_string} "
        input_string[index] = new_line_string

        index += CHARACTERS_PER_LINE + new_line_string.length
      end

      input_string
    end
  end
end
