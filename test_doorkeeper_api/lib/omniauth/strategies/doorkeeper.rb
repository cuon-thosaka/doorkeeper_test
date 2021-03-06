module OmniAuth
  module Strategies
    class Doorkeeper < OmniAuth::Strategies::OAuth2
      option :name, :doorkeeper
      option :client_options, site: "http://localhost:3000", authorize_path: "/oauth/authorize"

      # uidとして設定するデータを指定
      uid { raw_info['user']['id'] }
      # providerから送られてきたデータの内、どれを使いたいか
      info do
        { email: raw_info['user']['email'] }
      end

      # providerのAPIを叩いて、データを取ってくる
      def raw_info
        @raw_info ||= access_token.get('/api/login.json').parsed
      end
    end
  end
end
