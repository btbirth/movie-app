class AddPlotToMovies < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :plot, :text
  end
end
