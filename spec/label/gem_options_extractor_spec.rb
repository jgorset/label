require 'label/gem_options_extractor'

def extract(gem_line)
  extractor = Label::GemOptionsExtractor.new(gem_line)
  extractor.extract!
  extractor.gem_options
end

describe Label::GemOptionsExtractor, :wip do

  describe '#extract' do
    it 'extracts source if available' do
      result = extract("gem 'rspec', github: 'rspec/rspec'")
      expect(result).to eq(github: 'rspec/rspec')
    end

    it 'defaults source to rubygems' do
      expect(extract("gem 'rspec'")).to eq(rubygems: true)
    end

    it 'extracts gem version if available' do
      result = extract("gem 'rspec', '~> 3.0.0.beta'")
      expect(result).to eq(version: '~> 3.0.0.beta', rubygems: true)
    end

    it 'extracts the rest of the options as a hash' do
      result = extract("gem 'rspec', github: 'jgorset/rspec'"\
                       ", tag: 'awesome_feature'")
      expect(result).to eq(github: 'jgorset/rspec', tag: 'awesome_feature')
    end

  end

end
