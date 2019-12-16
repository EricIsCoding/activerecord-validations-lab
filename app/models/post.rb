
class ClickbaitValidator < ActiveModel::Validator
    def validate(record)
      unless record.title.include?("Won't Believe" || "Secret" || "Top [number]" || "Guess")
        record.errors[:post] << 'Be More ClickBait-y!'
      end
    end
  end

class Post < ActiveRecord::Base
    validates :title, presence: true
    validates :content, length: { minimum: 250 }
    validates :summary, length: { maximum: 250 }
    validates :category, inclusion: { in: %w(Fiction Non-Fiction)}
    validate :title_is_clickbait

    def title_is_clickbait
        if title
            unless title.include?("Won't Believe" || "Secret" || "Top [number]" || "Guess")
                errors.add(:title, 'Must be More ClickBait-y!')
            end
        else
            errors.add(:title, 'No Title') 
        end
    end
end
