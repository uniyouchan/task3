class BooksController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @user = current_user
    @books = Book.all
    @book = Book.new
  end
  
  def create
    @user = current_user
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      render :index
    end
  end

  def show
   @showbook = Book.find(params[:id])
   @book = Book.new
   @books = current_user
   @user = @showbook.user
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  
  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render :edit
    else
      redirect_to books_path
    end
  end
  
  def update
    @book = Book.find(params[:id])
   if @book.update(book_params)
     redirect_to book_path(@book.id), notice: "You have update book successfully."
   else
      render :edit
   end
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
end