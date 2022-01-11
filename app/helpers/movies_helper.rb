module MoviesHelper
 # this is an area to have all your ruby code instead of mixed in with the index file. 
 # it makes the index view neater and seperates ruby formating code with the HTML code.
    def total_gross(movie)
        
        if movie.flop?
            "Flop!"
        else
            number_to_currency(movie.total_gross, precision: 0)
        end
    end

    def year_of(movie)
        movie.released_on.strftime("%Y")

        #can also right it like below.
        #movie.release_on.year
    end

    def small_description(movie)
        truncate(movie.description, length:40, seperator: ' ')
    end

    def average_stars(movie)
        if movie.average_stars.zero?
            content_tag(:strong, "No Reviews")
        else 
            pluralize(number_with_precision(movie.average_stars, precision: 1), "Star")
        end
    end

end
