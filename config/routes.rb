# frozen_string_literal: true

Rails.application.routes.draw do
  mount API::Base, at: '/'
  # mount GrapeSwaggerRails::Engine, at: "/documentation"
end
