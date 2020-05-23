class JuliaParam < ApplicationRecord
  # validations
  validates_presence_of :min_x, :max_x, :min_y, :max_y, :real, :img
end
