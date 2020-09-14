class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :article, optional: true
  belongs_to :infoendo, optional: true

  validates :article_id, uniqueness: { scope: :user_id,
    message: "Vous l'avez déjà indiqué dans vos favoris" }
  validates :infoendo_id, uniqueness: { scope: :user_id,
    message: "Vous l'avez déjà indiqué dans vos favoris" }
end
