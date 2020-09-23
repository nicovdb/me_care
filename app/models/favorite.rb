class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :article, optional: true
  belongs_to :infoendo, optional: true

  validates :article_id, uniqueness: { scope: :user_id,
    message: "Vous l'avez déjà indiqué dans vos favoris" }, unless: Proc.new { |f| f.article_id.nil? }
  validates :infoendo_id, uniqueness: { scope: :user_id,
    message: "Vous l'avez déjà indiqué dans vos favoris" }, unless: Proc.new { |f| f.infoendo_id.nil? }
end
