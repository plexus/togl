RSpec.describe Togl::Config::Builder do
  let(:config) { Togl::Config.new }
  let!(:builder) {
    Togl::Config::Builder.new(config) do
      feature :foo, default: :on
      feature :bar
      adapters :rack_session
    end
  }

  describe "#initialize" do
    it "takes a Togl config and a configuration block" do
      expect(config.fetch(:foo)).to eql Togl::Feature.new(name: :foo, default: :on, config: config)
    end
  end

  describe "#feature" do
    it "works with only a name" do
      expect(config.fetch(:bar)).to eql Togl::Feature.new(name: :bar, config: config)

    end
  end
end
