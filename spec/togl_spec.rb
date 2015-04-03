RSpec.describe Togl do
  describe ".config" do
    it "should return a Togl::Config" do
      expect(Togl.config).to be_a Togl::Config
    end

    it "should memoize" do
      expect(Togl.config).to equal Togl.config
    end
  end
end
