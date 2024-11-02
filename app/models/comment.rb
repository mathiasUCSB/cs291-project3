class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content, presence: true
  validate :no_election_influence

  private

  def no_election_influence
    prohibited_words = ["Trump", "Harris"]
    if prohibited_words.any? { |word| content.match?(/\b#{word}\b/i) }
      errors.add(:content, "cannot include words related to election influence")
    end
  end

end
