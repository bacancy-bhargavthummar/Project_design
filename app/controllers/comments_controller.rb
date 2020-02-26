class CommentsController < ApplicationController

    def create 
        @book = Book.find(params[:book_id])
        @comment = @book.comments.create(comment_params)
      # @comment.user =  current_user
        @comment.user_id = current_user.id
        @comment.save
        redirect_to book_path(@book)
    end

    def destroy
        @book = Book.find(params[:book_id])
        @comment = @book.comments.find(params[:id])
        @comment.destroy 
        redirect_to @book
    end

    private
    def comment_params
        params.require(:comment).permit(:body)
    end

end
