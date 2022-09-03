# frozen_string_literal: true

class CreateWeatherReports < ActiveRecord::Migration[6.1]
  def change
    create_table :weather_reports do |t|
      t.datetime :time
      t.float :temperature, default: 0

      t.timestamps
    end
  end
end
