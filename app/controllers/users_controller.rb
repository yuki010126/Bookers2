class UsersController < ApplicationController
  before_action :authenticate_user!


  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @user = current_user
    @users = User.all
    @book = Book.new

  end

  def create
     @book = Book.new(book_params)
     @book.save
     redirect_to  '/book', notice: 'error'
  end


  def edit

    @user = User.find(params[:id])

  end


  def update
      @user = User.find(params[:id])
      if
      @user.update(user_params)
      flash[:notice] = "successfully"
        redirect_to user_path(@user.id)
      else
         render :edit
      end
  end


  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

   def correct_user
    @user = User.find(params[:id])
    redirect_to(user_url(current_user)) unless @user == current_user
   end


end

