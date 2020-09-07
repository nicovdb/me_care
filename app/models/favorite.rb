class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :article, optional: true

  validates :article_id, uniqueness: { scope: :user_id,
    message: "Vous l'avez déjà indiqué dans vos favoris" }
end
