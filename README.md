# RuboCop::Itamae

Code style checking for [itamae](https://github.com/itamae-kitchen/itamae) recipes

[![Gem Version](https://badge.fury.io/rb/rubocop-itamae.svg)](https://badge.fury.io/rb/rubocop-itamae)
[![test](https://github.com/sue445/rubocop-itamae/actions/workflows/test.yml/badge.svg)](https://github.com/sue445/rubocop-itamae/actions/workflows/test.yml)
[![Maintainability](https://qlty.sh/gh/sue445/projects/rubocop-itamae/maintainability.svg)](https://qlty.sh/gh/sue445/projects/rubocop-itamae)
[![Maintainability](https://api.codeclimate.com/v1/badges/bf2f4b2cbf9c2cfc0e92/maintainability)](https://codeclimate.com/github/sue445/rubocop-itamae/maintainability)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rubocop-itamae'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rubocop-itamae

## Usage
Add this line to your application's `.rubocop.yml`

```yml
plugins:
  - rubocop-itamae
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sue445/rubocop-itamae.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
