# frozen_string_literal: true

module API
  module V1
    class Health < Grape::API
      include API::V1::Defaults

      namespace :health do
        desc 'Return ok status.'
        get do
          status :ok
        end
      end
    end
  end
end
