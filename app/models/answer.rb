class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :subject
  has_rich_text :content
end
