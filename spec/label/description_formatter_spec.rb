# encoding: utf-8

require 'label/description_formatter'

def format input_string, prepend_string = "#"
  Label::DescriptionFormatter.format input_string, prepend_string
end

describe Label::DescriptionFormatter do

  describe '.format' do
    it 'does not change descriptions that are not that long' do
      description = "An IRB alternative and runtime developer console"
      expect(format(description)).to eq "# #{description}"
    end

    it 'ignores dots that do not end a sentence' do
      description = "Ruby 2.0 is awesome"
      expect(format(description)).to eq "# #{description}"
    end

    context 'with long descriptions' do
      it 'returns the first sentence (ended by ".") for long descriptions' do
        long_description = "Nokogiri (é\u008B¸) is an HTML, XML, SAX, and Reader "+
          "parser.  Among Nokogiri's\nmany features is the "+
          "ability to search documents via XPath or CSS3 "+
          "selectors.\n\nXML is like violence - if it "+
          "doesnâ\u0080\u0099t solve your problems, you are not"+
          "using\nenough of it."
        result = format(long_description)
        expect(result).to eq "# Nokogiri (é\u008B¸) is an HTML, XML, SAX, and Reader parser."
      end

      it 'returns the first sentence an include urls correctly' do
        long_description = "Pg is the Ruby interface to the {PostgreSQL RDBMS}"+
          "[http://www.postgresql.org/].\n\nIt works with {PostgreSQL 8.4 and later}"+
          "[http://www.postgresql.org/support/versioning/].\n\nA small example usage:\n\n"+
          "  #!/usr/bin/env ruby\n\n  require 'pg'\n\n# Output a table of current "+
          "connections to the DB\n  conn =PG.connect( dbname: 'sales' )\n  conn.exec("+
          " \"SELECT * FROM pg_stat_activity\" ) do |result|\n    puts \"     PID |"+
          " User             | Query\"\n  result.each do|row|\n      puts \" %7d |"+
          " %-16s | %s \" %\nrow.values_at('procpid', 'usename', 'current_query')\n"+
          "    end\n  end"
        result = format long_description, '#'
        expect(result).to eq "# Pg is the Ruby interface to the {PostgreSQL RDBMS}[http://www.postgresql.org/]."
      end

      it 'returns the first sentence in multiple lines when this is too long' do
        long_description = "\\Unicorn is an HTTP server for Rack applications "+
          "designed to only serve\nfast clients on low-latency, high-bandwidth "+
          "connections and take\nadvantage of features in Unix/Unix-like kernels. "+
          "Slow clients should\nonly be served by placing a reverse proxy capable"+
          " of fully buffering\nboth the the request and response in between "+
          "\\Unicorn and slow clients."

        expected_description = "  # \\Unicorn is an HTTP server for Rack applications "+
          "designed to only serve fast clients\n  # on low-latency, high-bandwidth "+
          "connections and take advantage of features in\n  # Unix/Unix-like kernels."
        expect(format(long_description, '  #')).to eq expected_description
      end
    end

  end

end
