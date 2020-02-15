require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class Octobat < OmniAuth::Strategies::OAuth2
      option :name, :octobat

      option :client_options, {
        :site => 'https://auth.octobat.com',
        :authorize_path => '/oauth/authorize',
        :access_token_path => '/oauth/token'
      }

      def raw_info
        @raw_info ||= deep_symbolize(access_token.params)
      end

      def extra_info
        @extra_info ||= deep_symbolize(access_token.get('/oauth/account').parsed)
      end

      uid { raw_info[:octobat_account_id] }

      info do
        { livemode: raw_info[:livemode] }
      end

      extra do
        {
          raw_info: raw_info,
          extra_info: extra_info
        }
      end


      #option :authorize_options, [:scope, :landing, :always_prompt]
      #option :provider_ignores_state, true


      # info do
      #   {
      #     :name => extra_info[:display_name] || extra_info[:business_name] || extra_info[:email],
      #     :email => extra_info[:email],
      #     :nickname => extra_info[:display_name],
      #     :scope => raw_info[:scope],
      #     :livemode => raw_info[:livemode],
      #     :stripe_publishable_key => raw_info[:stripe_publishable_key]
      #   }
      # end
      #
      # extra do
      #   e = {
      #     :raw_info => raw_info
      #   }
      #   e[:extra_info] = extra_info unless skip_info?
      #
      #   e
      # end
    end
  end
end
