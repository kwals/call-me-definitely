require 'authy'

Authy.api_key = Figaro.env.AUTHY_API_KEY
Authy.api_uri = 'https://api.authy.com/'