class Item < ApplicationRecord
  #model assosiation
  belongs_to :todo

  #valitdation
  validates_presence_of :name
end
