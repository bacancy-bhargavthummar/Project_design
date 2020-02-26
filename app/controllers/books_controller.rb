class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show,:index,:index2]
   
  # GET /books
  # GET /books.json

  def index
    # @book = Book.ransack(params[:q])
    # @books_result = @book.result(distinct: true) 
       
    if params[:query].present?
    
    @books_result = Book.searching(params[:query])
    else
    @books_result = Book.all
    end

  end

  def index2
  
    # @book = Book.ransack(params[:q])
    # @s = BookSeller
    # @s = @s.where('seller_id = ?', current_user.id)
    # @s = @s.select('book_id')
    # @q = Book
    # @books_result = @book.result.where(id: [@s])

      @s = BookSeller
      @s = @s.where('seller_id = ?', current_user.id)
      @s = @s.select('book_id')
      @q = Book

      if params[:query].present?
      @books_result = Book.searching(params[:query]).where(id: [@s])
      else
      @books_result = @q.where(id: [@s])
      end 
   end

  # GET /books/1
  # GET /books/1.json 
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

  
    respond_to do |format|
      if @book.save
        @book_seller = BookSeller.new(seller_id: current_user.id, book_id: @book.id)
        # @book_seller.seller_id = current_user.id
        # @book_seller.book_id = @book.id
        @book_seller.save
        format.html { redirect_to book_path(@book ,@book_seller), notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to book_path(@book, @book_seller), notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
      @book_seller = BookSeller.find_by(book: @book, seller: current_user)
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:book_name, :book_description, :book_author, :book_price, :book_qty, :isbn, :category_id, :image)
    end
end
