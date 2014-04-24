# encoding: utf-8
require "spec_helper"

describe Label do
  describe "#process" do
    it "should label unlabelled gems" do
      allow(File).to receive(:open).with("Gemfile").and_return(StringIO.new fixture("stock_gemfile"))

      allow(subject).to receive(:describe).with("rspec", rubygems: true).and_return("BDD for Ruby")

      allow(subject).to receive(:describe).with("carrierwave", rubygems: true).and_return(
        "Upload files in your Ruby applications, map them to a range of ORMs, " +
        "store them on different backends."
      )

      allow(subject).to receive(:describe).with("label", path: "./").and_return(
        "Label labels the gems in your Gemfile"
      )

      allow(subject).to receive(:describe).with("pg", rubygems: true).and_return(
        "Pg is the Ruby interface to the {PostgreSQL RDBMS}[http://www.postgresql.org/].\n\n"+
        "It works with {PostgreSQL 8.4 and later}[http://www.postgresql.org/support/versioning/]."+
        "\n\nA small example usage:\n\n  #!/usr/bin/env ruby\n\n  require 'pg'\n\n"+
        "# Output a table of current connections to the DB\n  conn ="+
        "PG.connect( dbname: 'sales' )\n  conn.exec( \"SELECT * FROM pg_stat_activity\" )"+
        "do |result|\n    puts \"     PID | User             | Query\"\n  result.each do"+
        "|row|\n      puts \" %7d | %-16s | %s \" %\n"+
        "row.values_at('procpid', 'usename', 'current_query')\n    end\n  end"
      )

      allow(subject).to receive(:describe).with("nokogiri", rubygems: true).and_return(
        "Nokogiri (é\u008B¸) is an HTML, XML, SAX, and Reader "+
        "parser.  Among Nokogiri's\nmany features is the "+
        "ability to search documents via XPath or CSS3 "+
        "selectors.\n\nXML is like violence - if it "+
        "doesnâ\u0080\u0099t solve your problems, you are not"+
        "using\nenough of it."
      )

      allow(subject).to receive(:describe).with("unicorn", rubygems: true).and_return(
        "\\Unicorn is an HTTP server for Rack applications "+
        "designed to only serve\nfast clients on low-latency, high-bandwidth "+
        "connections and take\nadvantage of features in Unix/Unix-like kernels."+
        "Slow clients should\nonly be served by placing a reverse proxy capable"+
        " of fully buffering\nboth the the request and response in between "+
        "\\Unicorn and slow clients."
      )

      allow(subject).to receive(:describe).with("pry", github: "pry/pry", branch: "development")
        .and_return("An IRB alternative and runtime developer console")

      allow(subject).to receive(:describe).with("rspec-rails", rubygems: true).and_return(
        "Rspec for Rails"
      )

      expect(subject.process("Gemfile")).to eq fixture("processed_gemfile")
    end
  end

  describe "#describe" do
    it "should describe a given gem" do
      expect(Gems).to receive(:info).with("label").and_return("info" => "Label gems in your Gemfile")

      expect(subject.describe("label")).to eq "Label gems in your Gemfile"
    end

    it "should describe a given gem from a github source" do
      mock_github_response!
      expect(subject.describe("label", github: "jgorset/label")).to eq "Label labels the gems in your Gemfile"
    end
  end
end
