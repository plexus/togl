RSpec.describe Togl::Config do
  let(:config) do
    described_class.new
      .with_feature("foo")
      .with_strategy("foo", ->(n){ :result })
      .with_strategy("bar", ->(n){ :rasilt })
  end

  describe "#with_feature" do
    it "should append a feature to the list" do
      expect(config.features).to eql [Togl::Feature.new(name: :foo, config: config)]
    end

    it "takes options" do
      config.with_feature(:wammie, strategies: [:redis, :rack])
      expect(config.fetch(:wammie))
        .to eql Togl::Feature.new(name: :wammie, config: config, strategies: [:redis, :rack])
    end

    it "should use default strategies if none given" do
      config.default_strategies.push(:rack)
      config.with_feature(:lisa)
      expect(config.fetch(:lisa)).to eql Togl::Feature.new(name: :lisa, config: config, strategies: [:rack])
    end
  end

  describe '#fetch' do
    let(:config) do
      described_class.new
        .with_feature(:foo)
        .with_feature("bar")
        .with_feature(:baz)
    end

    it "should find a feature object by name" do
      expect(config.fetch("bar")).to eql Togl::Feature.new(name: :bar, config: config)
    end
  end

  describe "#on?" do
    fake(:feature, name: :disrupt)
    it "should delegate to the feature" do
      config = self.config.append_to(:features, feature)

      config.on?("disrupt")
      expect(feature).to have_received.on?
    end
  end

  describe "#with_strategy" do

    it "should store the strategy" do
      expect(config.strategies[:foo].call(:bar)).to equal :result
    end
  end

  describe "#fetch_strategy" do
    it "should return the strategy by name" do
      expect(config.fetch_strategy("bar").call(1)).to equal :rasilt
    end
  end
end
