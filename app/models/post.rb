class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, dependent: :destroy

  validates :content, presence: true
  validate :no_election_influence

  private

  # election filter
  def no_election_influence
    prohibited_words = ["Trump", "Donald Trump", "Kamala Harris", "Harris", "fake news"]
    if prohibited_words.any? { |word| content.match?(/\b#{word}\b/i) }
      errors.add(:content, "cannot include words related to election influence")
    end
  end
end
