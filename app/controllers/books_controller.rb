class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]

  def index
    @books = Book.all
  end

  def show
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def create
    @book = Book.new(book_params)

    # associates the book with its authors
    # by the author open library keys specified in a book record
    @book.associate_authors_by_open_library_keys(params[:book][:authors_open_library_keys])

    respond_to do |format|
      if @book.save
        @book.update_cover_images_list(params[:book][:cover_images])

        format.html { redirect_to book_url(@book), notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    # updates the book's attributes prior to saving
    @book.assign_attributes(book_params)

    # associates the book with its authors
    @book.associate_authors_by_open_library_keys(params[:book][:authors_open_library_keys])

    respond_to do |format|
      if @book.save
        @book.update_cover_images_list(params[:book][:cover_images])

        format.html { redirect_to book_url(@book), notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:open_library_key, :title, :number_of_pages, :first_sentence, :description)
  end
end
