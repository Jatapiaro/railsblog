class ArticlesController < ApplicationController

	#GET /articles
	def index
		##Nos permite traer todos los
		##registros que estan en la 
		##tabla articles
		@articles=Article.all
	end

	##GET /articles/:id
	def show
		##Mandas el id, de la tabla
		@article=Article.find(params[:id])
		render :show
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
	end

	##POST /articles/create
	def create

		##Primer forma sin usar strong params
		##@article=Article.new(
		##	title: params[:article][:title],
 		##	body: params[:article][:body])

		##Usando strong params

		@article=Article.new(article_params)

		if @article.save
			redirect_to @article
		else
			render :new
		end

	end

	def edit
		@article=Article.find(params[:id])
	end

	def update
		#@article.update_attributes({title: 'Nuevo titulo'})
		@article=Article.find(params[:id])
		if @article.update(article_params)
		
			redirect_to @article

		else
			render :edit
		end
	end

	def destroy
		@article=Article.find(params[:id])
		@article.destroy ##Elimina el objeto de la db
		redirect_to articles_path
	end

	private 

	def article_params
		params.require(:article).permit(:title,:body)
	end

end