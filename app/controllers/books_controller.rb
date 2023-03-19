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

    respond_to do |format|
      if @book.save
        associate_authors_with_book
        update_cover_images_list(params[:book][:cover_images])

        format.html { redirect_to book_url(@book), notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @book.update(book_params)
        associate_authors_with_book
        update_cover_images_list(params[:book][:cover_images])

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

  def associate_authors_with_book
    authors_open_library_keys = params[:book][:authors_open_library_keys].gsub(/\s+/, '').split(',')

    authors_open_library_keys.each do |open_library_key|
      author = Author.find_or_create_by(open_library_key: open_library_key)
      @book.authors << author
    end
  end

  def update_cover_images_list(cover_images)
    cover_image_ids = cover_images.gsub(/\s+/, '').split(',')
    @book.update(cover_images: cover_image_ids)
  end

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:open_library_key, :title, :number_of_pages, :first_sentence, :description,
                                  author_attributes: [:id, :open_library_key, :name, :birth_date, :alternate_names, :_destroy])
  end
end
