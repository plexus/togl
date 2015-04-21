RSpec.describe Togl::Feature do
  subject(:feature) do
    described_class.new(
      name: name,
      config: config,
      default: default,
      adapters: adapters
    )
  end

  let(:name) { :eric }
  let(:config) { Togl::Config.new }
  let(:default) { :off }
  let(:adapters) { [] }

  describe "#on?" do
    it "should be disabled by default" do
      expect(feature.on?).to be false
    end

    context "when on by default" do
      let(:adapters) { [:s1, :s2] }
      let(:default) { :on }

      it "should be on if all strategues return nil" do
        config
          .add_adapter(:s1, ->(name){ nil })
          .add_adapter(:s2, ->(name){ nil })
        expect(feature.on?).to be true
      end
    end

    context "with adapters" do
      let(:adapters) { [:s1, :s2] }

      it "should be on if the adapter returns true - skipping nils" do
        config
          .add_adapter(:s1, ->(name){ nil })
          .add_adapter(:s2, ->(name){ name == :eric })
        expect(feature.on?).to be true
      end

      it "should be off if the adapter returns false - skipping nils" do
        config
          .add_adapter(:s1, ->(name){ nil })
          .add_adapter(:s2, ->(name){ name != :eric })
        expect(feature.on?).to be false
      end

      it "should be on if the adapter returns true" do
        config
          .add_adapter(:s1, ->(name){ name == :eric })
        expect(feature.on?).to be true
      end

      it "should be off if the adapter returns false" do
        config
          .add_adapter(:s1, ->(name){ name != :eric })
        expect(feature.on?).to be false
      end
    end
  end
end
