class CharactersController < ApplicationController
  def index
    matching_characters = Character.all

    @list_of_characters = matching_characters.order({ :created_at => :desc })

    render({ :template => "characters/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_characters = Character.where({ :id => the_id })

    @the_character = matching_characters.at(0)

    render({ :template => "characters/show.html.erb" })
  end

  def create
    the_character = Character.new
    the_character.name = params.fetch("query_name")
    the_character.actor_id = params.fetch("query_actor_id")
    the_character.movie_id = params.fetch("query_movie_id")

    if the_character.valid?
      the_character.save
      redirect_to("/movies/#{the_character.movie_id}", { :notice => "Character created successfully." })
    else
      redirect_to("/movies/#{the_character.movie_id}", { :alert => the_character.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("query_character_id")
    the_character = Character.where({ :id => the_id }).at(0)

    the_character.name = params.fetch("query_name")
    the_character.actor_id = params.fetch("query_actor_id")
    the_character.movie_id = params.fetch("query_movie_id")

    if the_character.valid?
      the_character.save
      redirect_to("/movies/#{the_character.movie_id}", { :notice => "Character updated successfully."} )
    else
      redirect_to("/movies/#{the_character.movie_id}", { :alert => the_character.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("query_id")
    the_character = Character.where({ :id => the_id }).at(0)
    movie_id = params.fetch("query_movie_id")

    the_character.destroy

    redirect_to("/movies/#{movie_id}", { :notice => "Character deleted successfully."} )
  end
end
