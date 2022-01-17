class Movie < ApplicationRecord

    has_many :reviews, dependent: :destroy
    has_many :favorites, dependent: :destroy
    has_many :fans, through: :favorites, source: :user

    has_many :characterizations, dependent: :destroy
    has_many :genre, through: :characterizations

    validates :title, presence: true, uniqueness: true
    validates :released_on, :duration, presence: true

    validates :description, length: { minimum: 25 }

    validates :total_gross, numericality: {greater_than_or_equal_to: 0} 

    validates :image_file_name, format: {
        with: /\w+\.(jpg|png)\z/i,
        message: "must be a JPG or PNG image"
    }

    RATINGS = %w(G PG PG-13 R NC-17)
    
    validates :rating, inclusion: { in: RATINGS} 

    scope :released, -> { Movie.where("released_on < ?", Time.now).order(released_on: :desc) } 
    scope :upcoming, -> { Movie.where("released_on > ?", Time.now).order(released_on: :desc) } 
    scope :recent, ->(max = 5) { released.limit(max) }

    before_save :set_slug

    
    def flop?
        total_gross.blank? || total_gross < 225_000_000
    end

    def average_stars
        reviews.average(:stars) || 0.0
    end

    def to_param
        slug
    end

    def set_slug
        self.slug = title.parameterize
    end
    
end
