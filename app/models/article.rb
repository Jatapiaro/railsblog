class Article < ActiveRecord::Base

	#La tabla => articles
	#Campos => article.title() =>"El titulo del articulo"
	#Escribir metodos

	##Se valida que traiga eso
	validates :title, presence: true, length: {minimum: 4}, uniqueness: true
	validates :body, presence: true, length: {minimum: 20}


end
