class BooksController < ApplicationController
    
    def create
        # １. データを新規登録するためのインスタンス作成
         @book = Book.new(book_params)
        # ２. データをデータベースに保存するためのsaveメソッド実行
        
        if @book.save
            # ３. 詳細画面へリダイレクト
            redirect_to book_path(@book.id)
            flash[:notice] = "Book was successfully create"
        else
            @books = Book.all
            render :index
        end
       
    end
    def index
        @books = Book.all
        @book = Book.new
    end
    
    def show
        @books = Book.find(params[:id])
    end
    
    def destroy
  	    book = Book.find(params[:id])
  	    book.destroy
  	    flash[:notice] = "Book was successfully destroyed"
  	    redirect_to '/books'
    end
    
    def edit
        @book = Book.find(params[:id])
    end
    
    def update
        @book = Book.find(params[:id])
  	    if  @book.update(book_params)
  	        redirect_to book_path(@book.id)
  	        flash[:notice] = "Book was successfully update"
  	    else
  	        render :edit
        end
    end
private
  # ストロングパラメータ
    def book_params
        params.require(:book).permit(:title, :body)
    end
    
end
