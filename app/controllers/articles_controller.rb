class ArticlesController < ApplicationController
	before_action :authenticate_user!, except: [:show,:index]
	before_action :set_article, except: [:index,:new,:create]
	#GET /articles
	def index
		##Nos permite traer todos los
		##registros que estan en la 
		##tabla articles
		@articles=Article.all
	end 

	##GET /articles/:id
	def show

		@article.update_visits_count
		@comment=Comment.new
		##Mandas el id, de la tabla
		##parametros seguido de signo de interrogacion
		##Article.where("id LIKE ? OR title=?", params[:id],params[:title])

		##Todo menos lo que mando
		##Article.where.not("id=1")
	end

	##GET /articles/new
	def new
		##Se usa para el formulario
		##A pesar de ser una instancia
		## No esta en la db
		##Se pone porque el form
		##Se creara usando métodos de
		##rails
		@article=Article.new
		@categories=Category.all
	end

	##POST /articles/create
	def create

		##Primer forma sin usar strong params
		##@article=Article.new(
		##	title: params[:article][:title],
 		##	body: params[:article][:body])

		##Usando strong params

		@article=current_user.articles.new(article_params)
		@article.categories=params[:categories] 
		if @article.save
			redirect_to @article
		else
			render :new
		end

	end

	def edit
	end

	def update
		#@article.update_attributes({title: 'Nuevo titulo'})
		if @article.update(article_params)
		
			redirect_to @article

		else
			render :edit
		end
	end

	def destroy
		@article.destroy ##Elimina el objeto de la db
		redirect_to articles_path
	end

	private 

	def set_article
		@article=Article.find(params[:id])
	end

	def article_params
		params.require(:article).permit(:title,:body,:cover)
	end

	def validate_user
		redirect_to new_user_session_path, notice: "Necesitas inicar sesión"
	end

end