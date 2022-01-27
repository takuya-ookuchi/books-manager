# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { maximum: 30 }
end
