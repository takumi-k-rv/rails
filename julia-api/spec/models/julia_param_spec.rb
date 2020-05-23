require 'rails_helper'

RSpec.describe JuliaParam, type: :model do
  # ensure each column is present before saving
  it { should validate_presence_of(:min_x) }
  it { should validate_presence_of(:max_x) }
  it { should validate_presence_of(:min_y) }
  it { should validate_presence_of(:max_y) }
  it { should validate_presence_of(:real) }
  it { should validate_presence_of(:img) }
end
