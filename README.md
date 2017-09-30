gem install skipio_api

require 'skipio'

Skipio.new({ token: Rails.application.secrets.skipio_api, params: @options })

