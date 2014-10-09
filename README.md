# GcmFaraday

Simple Google Cloud Message api to allow you to simply send messages.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gcm_faraday'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gcm_faraday

## Usage

### Configuration

```ruby
GCMFaraday.configure do |c|
  c.api_key = '<your GCM api key>'
end
```

### Sending a notification

```ruby
data = { message: 'Sent from the cloud' }
registration_ids = ['reg id', 'reg id']
response = GCMFaraday::Send(data, *registration_ids)


# See <https://developer.android.com/google/gcm/http.html#response>
response.success? # => true of http response was 200
response.falure? # => true if http response was not 200
response.unauthorized? # => true if http response was 401
response.bad_request? # => true if http response was 400
response.error? # => true if http response was 5xx

response.cannonical_ids do |old_id, new_id|
  puts "Replace old_id with new_id"
end

response.falures do |registration_id, result|
  puts "These ids failed to send with result[:error] being the error and result[:message_id] being the message id"
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/gcm_faraday/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
