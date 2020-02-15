# OmniAuth::Octobat

Octobat OAuth2 Strategy for OmniAuth 1.0.

Supports the OAuth 2.0 server-side and client-side flows.
Read the Octobat Plaza docs for more details: https://www.octobat.com/developers/plaza-quickstart

## Installation

Add this line to your application's Gemfile:

    gem 'omniauth-octobat'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install omniauth-octobat

## Usage

OmniAuth::Strategies::Octobat is simply a Rack middleware. Read the OmniAuth
1.0 docs for detailed instructions: https://github.com/intridea/omniauth.

### Non-Devise
Here's a quick example, adding the middleware to a Rails app in
`config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :octobat, ENV['OCTOBAT_APP_CLIENT_ID'], ENV['OCTOBAT_APP_SECRET']
end
```

### Devise

You need to declare the provider in your `config/initializers/devise.rb`:

```ruby
config.omniauth :octobat, "OCTOBAT_APP_CLIENT_ID", "OCTOBAT_APP_SECRET"
```

You'll also need to add some configuration to your devise model (e.g. User in `app/models/user.rb`) along with any other OmniAuth providers you might have:
```ruby
:omniauthable, :omniauth_providers => [:octobat]
```

### General Usage

Your `OCTOBAT_APP_CLIENT_ID` is application-specific and your `OCTOBAT_APP_SECRET` is account-specific and may also be known as your Octobat application secret.

Edit your `routes.rb` file to have:
`devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }`

And create a file called `omniauth_callbacks_controller.rb` which should have this inside:
```ruby
class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def octobat
    # Delete the code inside of this method and write your own.
    # The code below is to show you where to access the data.
    raise request.env["omniauth.auth"].to_yaml
  end
end
```

Make sure to go to Octobat's Developers Settings > Applications and set your Redirect URL to:
`http://localhost:3003/users/auth/octobat/callback`

The Callback URL will be something similar:
`http://www.yourdomain.com/users/auth/octobat/callback`

Then you can hit `/auth/octobat`

If you hit `/auth/octobat` with any query params, they will be passed along to Octobat API. You can access these params from `request.env['omniauth.params']`. Read [Octobat's OAuth Reference](https://www.octobat.com/developers/plaza-quickstart) for more information.

## Auth Hash

Here is an example of the Auth Hash you get back from calling `request.env['omniauth.auth']`:

```ruby
{
  "provider"=>"octobat",
  "uid"=>"<OCTOBAT_ACCOUNT_ID>",
  "info"=> {
    "livemode"=>false
  },
  "credentials"=> {
    "token"=>"<OCTOBAT_ACCESS_TOKEN>",
  },
  "extra"=> {
    "raw_info"=> {
      "token_type"=>"bearer",
      "octobat_account_id"=>"<OCTOBAT_ACCOUNT_ID>",
      "livemode"=>false
    },
    "extra_info"=> {
      "country"=>"US",
    }
  }
}
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
