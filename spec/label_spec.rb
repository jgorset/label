# encoding: utf-8

require "spec_helper"

describe Label do
  describe "#process" do
    it "labels unlabelled gems" do
      allow(File).to receive(:open).with("Gemfile").and_return(StringIO.new fixture("stock_gemfile"))

      allow(subject).to receive(:describe).with("rspec", nil).and_return("BDD for Ruby")

      allow(subject).to receive(:describe).with("carrierwave", nil).and_return(
        "Upload files in your Ruby applications, map them to a range of ORMs, " +
        "store them on different backends."
      )

      allow(subject).to receive(:describe).with("label", nil).and_return(
        "Label labels the gems in your Gemfile"
      )

      allow(subject).to receive(:describe).with("pg", nil).and_return(
        "Pg is the Ruby interface to the {PostgreSQL RDBMS}[http://www.postgresql.org/].\n\n"+
        "It works with {PostgreSQL 8.4 and later}[http://www.postgresql.org/support/versioning/]."+
        "\n\nA small example usage:\n\n  #!/usr/bin/env ruby\n\n  require 'pg'\n\n"+
        "# Output a table of current connections to the DB\n  conn ="+
        "PG.connect( dbname: 'sales' )\n  conn.exec( \"SELECT * FROM pg_stat_activity\" )"+
        "do |result|\n    puts \"     PID | User             | Query\"\n  result.each do"+
        "|row|\n      puts \" %7d | %-16s | %s \" %\n"+
        "row.values_at('procpid', 'usename', 'current_query')\n    end\n  end"
      )

      allow(subject).to receive(:describe).with("nokogiri", nil).and_return(
        "Nokogiri (é\u008B¸) is an HTML, XML, SAX, and Reader "+
        "parser.  Among Nokogiri's\nmany features is the "+
        "ability to search documents via XPath or CSS3 "+
        "selectors.\n\nXML is like violence - if it "+
        "doesnâ\u0080\u0099t solve your problems, you are not"+
        "using\nenough of it."
      )

      allow(subject).to receive(:describe).with("unicorn", nil).and_return(
        "\\Unicorn is an HTTP server for Rack applications "+
        "designed to only serve\nfast clients on low-latency, high-bandwidth "+
        "connections and take\nadvantage of features in Unix/Unix-like kernels. "+
        "Slow clients should\nonly be served by placing a reverse proxy capable"+
        " of fully buffering\nboth the the request and response in between "+
        "\\Unicorn and slow clients."
      )

      allow(subject).to receive(:describe).with("pry", nil)
        .and_return("An IRB alternative and runtime developer console")

      allow(subject).to receive(:describe).with("rspec-rails", '~> 3.0.0.beta2').and_return(
        "Rspec for Rails"
      )

      expect(subject.process("Gemfile")).to eq fixture("processed_gemfile")
    end
  end

  describe "#describe" do
    it "describes a given gem" do
      expect(subject.describe("rake")).to eq "Rake is a Make-like program implemented in Ruby"
    end

    it "describes requested version of a given gem" do
      expect(subject.describe("bundler", "~> 1.3")).to eq "The best way to manage your application's dependencies"
    end

    it "raises when a given gem could not be found" do
      expect do
        subject.describe("missing")
      end.to raise_error Gem::LoadError, "Could not find 'missing' (>= 0)"
    end

    it "raises when requested version of a given gem could not be found" do
      expect do
        subject.describe("bundler", "~> 1000.0")
      end.to raise_error Gem::LoadError, "Could not find 'bundler' (~> 1000.0)"
    end

    it "raises when given version requirement is malformed" do
      expect do
        subject.describe("bundler", "fweep")
      end.to raise_error Gem::Requirement::BadRequirementError
    end
  end
end
