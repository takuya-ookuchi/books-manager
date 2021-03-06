# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]

  def index
    @q = Book.ransack(params[:q])
    @books = @q.result.order(:title)
  end

  def show
    @rentals = @book.rentals.order(created_at: :desc)
  end

  def new
    @book = Book.new
  end

  def edit; end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to @book, notice: "書籍「#{@book.title}」を登録しました。"
    else
      render :new
    end
  end

  def destroy
    @book.destroy
    redirect_to books_url, notice: "書籍「#{@book.title}」を削除しました。"
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: "書籍「#{@book.title}」の登録情報を更新しました。"
    else
      render :edit
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :image)
  end

  def set_book
    @book = Book.find(params[:id])
  end
end
