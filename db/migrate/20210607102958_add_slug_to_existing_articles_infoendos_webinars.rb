class AddSlugToExistingArticlesInfoendosWebinars < ActiveRecord::Migration[6.0]
  def change
    Article.find_each(&:save)
    Infoendo.find_each(&:save)
    Webinar.find_each(&:save)
  end
end
