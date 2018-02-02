# ruby-location-finder
Gem for locating sources of a ruby class


### Example
```ruby
LocationFinder.get_class_location(Integrations::Parser::CSV).select { |s| s['/bundler/gems/'] }
```
