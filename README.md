# Togl

<img align="left" src="logo.jpg">


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'togl'
```

And then execute:

    $ gem install -g


Or install it directly:

    $ gem install togl

## Usage

First have a configuration file where you add features as you introduce them

``` ruby
Togl.configure do
  feature :recommendations
  feature :threaded_comments
end
```

Now in your code you can check if a feature is on

``` ruby
if Togl.on? :recommendations
  # ... implement the feature ...
end
```



## Contributing

1. Fork it ( https://github.com/plexus/togl/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
