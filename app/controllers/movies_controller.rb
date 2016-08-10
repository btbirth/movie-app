class MoviesController < ApplicationController
  before_action :find_movie, only: [:show, :destroy]
  
  def index
  	@movies = current_user.movies
  end
  
  def search
  	# MAY NEED FIXING
  	#  create the endpoint/ and the url string for the off site search cool!!!!
  	
  	q = params[:q]
  	url = "http://www.omdbapi.com/?s="
  	end_point = url + q

  	# makes the API call to get what the query was
  	response = RestClient.get(end_point)

  	# parses the response return into a JSON struct
  	data  =  JSON.parse(response.body)
  	
  	@movies = data["Search"]
  	if @movies
  		render :search
  	else
  		flash[:alert] = "Your search came back empty"
  		redirect_to root_path
  	end
  end

  def details
  	# NEEDS FIXING
  	@movie = Movie.new
  	imdb_id = params[:id]
  	url = "http://www.omdbapi.com/?i="
  	end_point = url + imdb_id

  	response = RestClient.get(end_point)
  	@movie_info = JSON.parse(response.body)
  end

  def create
    if current_user.movies.map(&:imdb_id).include? movie_params[:imdb_id]
      flash[:alert] = "Sorry, you've already favorited this movie, please try again."
      redirect_to root_path
    else
      @movie = current_user.movies.build(movie_params)
      if current_user.save
        redirect_to [current_user, @movie]
      else
        flash[:alert] = "Sorry, your movie couldn't be favorited, please try again."
        redirect_to root_path
      end
    end
  end

  def show

  end

  def destroy
  	@movie.destroy
  	redirect_to root_path
  end

  private
    def find_movie
        @movie = Movie.find(params[:id])
    end

    def movie_params
        params.require(:movie).permit(:title, :year, :plot)
    end
end
