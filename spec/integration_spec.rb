RSpec.describe "high level usage examples" do
  let(:togl) do
    Togl::Config.new do
      strategies :rack_session

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

    expect(called).to be true
  end
end
