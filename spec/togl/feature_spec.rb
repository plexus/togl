RSpec.describe Togl::Feature do
  subject(:feature) do
    described_class.new(
      name: name,
      config: config,
      default: default,
      strategies: strategies
    )
  end

  let(:name) { :eric }
  let(:config) { Togl::Config.new }
  let(:default) { :off }
  let(:strategies) { [] }

  describe "#on?" do
    it "should be disabled by default" do
      expect(feature.on?).to be false
    end

    context "when on by default" do
      let(:strategies) { [:s1, :s2] }
      let(:default) { :on }

      it "should be on if all strategues return nil" do
        config
          .with_strategy(:s1, ->(name){ nil })
          .with_strategy(:s2, ->(name){ nil })
        expect(feature.on?).to be true
      end
    end

    context "with strategies" do
      let(:strategies) { [:s1, :s2] }

      it "should be on if the strategy returns true - skipping nils" do
        config
          .with_strategy(:s1, ->(name){ nil })
          .with_strategy(:s2, ->(name){ name == :eric })
        expect(feature.on?).to be true
      end

      it "should be off if the strategy returns false - skipping nils" do
        config
          .with_strategy(:s1, ->(name){ nil })
          .with_strategy(:s2, ->(name){ name != :eric })
        expect(feature.on?).to be false
      end

      it "should be on if the strategy returns true" do
        config
          .with_strategy(:s1, ->(name){ name == :eric })
        expect(feature.on?).to be true
      end

      it "should be off if the strategy returns false" do
        config
          .with_strategy(:s1, ->(name){ name != :eric })
        expect(feature.on?).to be false
      end
    end
  end
end
