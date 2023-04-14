class BookmarksController < ApplicationController

  #before_action(:load_current_user)

  #def load_current_user
    
    #the_user_id = session.fetch(:user_id)
    #@the_user = User.where({ :id => the_user_id}).first
  #end

  def my_bookmarks
    #self.load_current_user

    @matching_bookmarks = @the_user.bookmarks

    render({ :template => "bookmarks/my_bookmarks.html.erb"})
  end

  def show
    the_id = params.fetch("path_id")

    @matching_bookmarks = Bookmark.where({ :id => the_id }).all

    render({ :template => "bookmarks/show.html.erb" })
  end

  def create
    the_bookmark = Bookmark.new
    the_bookmark.user_id = session.fetch(:user_id)
    the_bookmark.movie_id = params.fetch("query_movie_id")

    if the_bookmark.valid?
      the_bookmark.save
      redirect_to("/bookmarks", { :notice => "Bookmark created successfully." })
    else
      redirect_to("/bookmarks", { :alert => the_bookmark.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_bookmark = Bookmark.where({ :id => the_id }).at(0)

    the_bookmark.user_id = params.fetch("query_user_id")
    the_bookmark.movie_id = params.fetch("query_movie_id")

    if the_bookmark.valid?
      the_bookmark.save
      redirect_to("/bookmarks/#{the_bookmark.id}", { :notice => "Bookmark updated successfully."} )
    else
      redirect_to("/bookmarks/#{the_bookmark.id}", { :alert => the_bookmark.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_bookmark = Bookmark.where({ :id => the_id }).at(0)

    the_bookmark.destroy

    redirect_to("/bookmarks", { :notice => "Bookmark deleted successfully."} )
  end
end
