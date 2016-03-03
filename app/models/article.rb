class Article < ActiveRecord::Base

	
	belongs_to :user
	has_many :comments

	#La tabla => articles
	#Campos => article.title() =>"El titulo del articulo"
	#Escribir metodos

	##Se valida que traiga eso
	validates :title, presence: true, length: {minimum: 4}, uniqueness: true
	validates :body, presence: true, length: {minimum: 20}
	before_create :set_visits_count
	after_create :save_categories

	has_attached_file :cover, styles: { medium: "300x300>", thumb: "100x100>" }
	validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

	def categories=(value)
		@categories=value
	end

	def update_visits_count
		self.update(visitsCount: self.visitsCount+1)
	end  

	private 

	def save_categories
		@categories.each do |category_id|
			HasCategory.create(category_id:category_id,
				article_id:self.id)
		end
	end

	def set_visits_count
		self.visitsCount=0;
	end




end
