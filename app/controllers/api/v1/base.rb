# frozen_string_literal: true

require 'grape-swagger'

module API
  module V1
    class Base < Grape::API
      mount API::V1::Weather
      mount API::V1::Health
      add_swagger_documentation
    end
  end
end
