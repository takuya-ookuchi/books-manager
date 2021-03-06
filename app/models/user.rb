# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { maximum: 30 }
  validates :furigana, presence: true
  validates :furigana, length: { maximum: 30 }

  has_many :rentals, dependent: :nullify

  def renting_book
    rentals.where(returned_at: nil).last&.book
  end
end
