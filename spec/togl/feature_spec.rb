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
end
