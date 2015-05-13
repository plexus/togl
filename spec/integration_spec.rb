RSpec.describe "high level usage" do
  context "using the rack session" do
    let(:togl) do
      Togl::Config.new do
        use Togl::Adapter::RackSession.new

        feature :hero
        feature :frontend
      end
    end

    specify do
      called = false

      app = ->(env) do
        called = true

        expect(togl.on? :hero).to be true
        expect(togl.on? :frontend).to be false
      end

      app = togl.rack_middleware.new(app)
      env = {
        "rack.session" => {},
        "QUERY_STRING" => "enable_feature=hero"
      }
      app.call(env)
      app.call("rack.session" => env["rack.session"])

      expect(called).to be true
    end
  end
end
