module MoviesHelper
  def star score
    link_to rates_path(score: score, movie_id: @movie.id), method: :post,
                      class: "click-rate", remote: true do
      content_tag(:span, "☆")
    end
  end
end
