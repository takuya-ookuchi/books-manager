# frozen_string_literal: true

class RentalsController < ApplicationController
  def index; end

  def new
    @rental = Renatl.new
  end

  def edit; end

  def create
    @book = Book.find(params[:book_id])
    @rental = Rental.new(rental_params)

    if @rental.save
      redirect_to @book, notice: "書籍「#{@book.title}」を借りました。"
    else
      @rentals = @book.rentals.order(created_at: :desc)
      render template: 'books/show'
    end
  end

  def update
    @book = Book.find(params[:book_id])
    @rental = @book.going_rental

    if @rental
      @rental.update(returned_at: Time.current)
      redirect_to @book, notice: "書籍「#{@book.title}」を返却しました。"
    else
      redirect_to @book, alert: "書籍「#{@book.title}」をまだ借りていないので返却できません"
    end
  end

  private

  def rental_params
    params.permit(:user_id, :book_id)
  end
end
