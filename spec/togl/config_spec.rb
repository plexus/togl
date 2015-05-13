RSpec.describe Togl::Config do
  let(:config) do
    described_class.new
      .feature("foo")
  end

  describe "#initialize" do
    it "should take a block for building the config" do
      config = described_class.new do
        feature :foo
      end

      expect(config.features.map(&:name)).to eql [:foo]
    end

    it "should take arguments to override the defaults" do
      config = described_class.new(default_adapters: [:rack, :session])
      expect(config.default_adapters).to eql [:rack, :session]
    end

    it "should have defaults for its attributes" do
      config = described_class.new
      expect(config.features).to eql []
      expect(config.adapters).to eql({})
      expect(config.default_adapters).to eql []
    end
  end

  describe "#add_feature" do
    it "should append a feature to the list" do
      expect(config.features).to eql [Togl::Feature.new(name: :foo, config: config)]
    end

    it "takes options" do
      config.feature(:wammie, adapters: [:redis, :rack])
      expect(config.fetch(:wammie))
        .to eql Togl::Feature.new(name: :wammie, config: config, adapters: [:redis, :rack])
    end

    it "should use all adapters as default if not explicitly configured given" do
      config.use Togl::Adapter::RackSession.new
      config.feature(:lisa)
      expect(config.fetch(:lisa)).to eql Togl::Feature.new(name: :lisa, config: config, adapters: [:rack_session])
    end
  end

  describe '#fetch' do
    let(:config) do
      described_class.new
        .feature(:foo)
        .feature("bar")
        .feature(:baz)
    end

    it "should find a feature object by name" do
      expect(config.fetch("bar")).to eql Togl::Feature.new(name: :bar, config: config)
    end
  end

  describe "#on?" do
    fake(:feature, name: :disrupt)
    it "should delegate to the feature" do
      config.features << feature

      config.on?("disrupt")
      expect(feature).to have_received.on?
    end
  end

  describe "rack_middleware" do
    it "should return a rack middleware builder" do
      expect(config.rack_middleware.new(->(env){})).to be_a Togl::Rack::Middleware
    end
  end
end
