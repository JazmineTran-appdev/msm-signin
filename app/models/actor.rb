# == Schema Information
#
# Table name: actors
#
#  id         :integer          not null, primary key
#  bio        :text
#  dob        :date
#  image      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Actor < ApplicationRecord
  # not including paranthesis because you don't have to!
  has_many :characters
  # dropped curlies around this hash because the hash literal is the last argument
  # check movies.rb to see with the paranthesis or curlies
  has_many :filmography, :through => :characters, :source => :movie

  validates(:name, { :presence => true })
end
