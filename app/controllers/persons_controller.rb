class PersonsController < ApplicationController

	def index
		#@persons = PersonCa.order(:PersonaID).page params[:page]
		#@persons = Person.all
	end

	def list_view
		if (params[:search] == nil)
			if (params[:id] == 'index')
				@persons = Person.joins(:person_ca).order(:Apellido, :Nombre).page params[:page]
			else
				@persons = Person.joins(:person_ca).order(:Apellido, :Nombre).where('"Apellido" LIKE ?', "#{params[:id]}%").page params[:page]
			end
		else#searchbar
			@persons = Person.joins(:person_ca).order(:Apellido, :Nombre).where('"Apellido" LIKE ? OR "Nombre" LIKE ? OR "Apellido" LIKE ? OR "Nombre" LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search].capitalize}%", "%#{params[:search].capitalize}%").page params[:page]
		end
	end

	def icon_view
		if (params[:search] == nil)
			if (params[:id] == 'index')
				@persons = Person.joins(:person_ca).order(:Apellido, :Nombre).page params[:page]
			else
				@persons = Person.joins(:person_ca).order(:Apellido, :Nombre).where('"Apellido" LIKE ?', "#{params[:id]}%").page params[:page]
			end
		else#searchbar
			@persons = Person.joins(:person_ca).order(:Apellido, :Nombre).where('"Apellido" LIKE ? OR "Nombre" LIKE ? OR "Apellido" LIKE ? OR "Nombre" LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search].capitalize}%", "%#{params[:search].capitalize}%").page params[:page]
		end
	end

	def show
		@person = Person.joins(:person_ca).find(params[:id])
	end

	def show_person
		@person = Person.find(params[:pid])
		if @person.Foto != nil
			#Convierte de formato '/xFF' a Base64 para poder mostrar la foto en la vista
			@person.Foto = [@person.Foto].pack('m0')
		end
		render json: @person
	end

	def new
		@personca = PersonCa.new
		@person = Person.new
		@empresa = Empresa.new
		@categoria = Categoria.new
	end

  	def edit
		@person = Person.select('"dc_taPersonas".*').joins(:person_ca).find(params[:id])
		@personca = PersonCa.select('"dca_SujetoC".*').where(:PersonaID => "#{params[:id]}")
  	end

  	def create
    	@person = Person.new(person_params)

    	@person.Apellido = params[:person][:Apellido]
    	@person.Nombre = params[:person][:Nombre]
    	@person.TDoc = params[:person][:TDoc]#format_tdoc
    	@person.NDoc = params[:person][:NDoc]
    	@person.Habil = params[:person][:Habilitada]
    	#Si Foto es nulo, entonces se sube una imagen con la webcam
    	if (params[:person][:Foto] == nil)
    		@person.Foto = decode_photo_base64(params[:person][:image])
    	else
    		@person.Foto = file_to_blob(params[:person][:Foto].tempfile)
    	end
    	@person.CUIL = params[:person][:CUIL]

		if @person.save
			redirect_to new_person_path, notice: 'La persona ha sido ingresada correctamente'
		else
			render 'new'
		end
    end

  	def create_person_ca
    	@personca = PersonCa.new(personca_params)

    	@personca.FecAlta = params[:person_ca][:FecAlta]
    	@personca.FecBaja = nil
    	@personca.Habil = params[:person_ca][:Habilitada]
    	@personca.Contacto = params[:person_ca][:Contacto]
    	@personca.CategID = params[:person_ca][:CategID]#format_categ
    	@personca.PersonaID = params[:pid]
    	@personca.EmpresaID = 1
    	@personca.UltMovimID = nil

		if @personca.save
			redirect_to new_person_path, notice: 'La persona ha sido ingresada correctamente'
		else
			render 'new'
		end
  	end

  	def update
		@person = Person.find(params[:id])

		@person.Apellido = params[:person][:Apellido]
    	@person.Nombre = params[:person][:Nombre]
    	@person.TDoc = params[:person][:TDoc]#format_tdoc
    	@person.NDoc = params[:person][:NDoc]
    	@person.Habil = params[:person][:Habilitada]
    	#Si alguno de los dos cambia es porque se va a actualizar la foto
    	if (params[:person][:Foto] != nil || params[:person][:image] != "")
    		#Si Foto es nulo, entonces se sube una imagen con la webcam
    		if (params[:person][:Foto] == nil)
    			@person.Foto = decode_photo_base64(params[:person][:image])
    		else
    			@person.Foto = file_to_blob(params[:person][:Foto].tempfile)
    		end
    	end
		@person.CUIL = params[:person][:CUIL]

		if @person.update(person_params)
			#Si la foto cambia, se actualiza en la aplicacion
			if (params[:person][:Foto] != nil || params[:person][:image] != "")
				blob_to_file(params[:id])
			end
			redirect_to persons_list_view_path('index')
		else
			render 'edit'
		end
  	end

  	def update_person_ca
  		#Where retorna un array, find un objeto
		@personca = PersonCa.select('"dca_SujetoC".*').where(:PersonaID => "#{params[:id]}")

    	@personca[0].FecAlta = params[:person_ca][:FecAlta]
    	@personca[0].FecBaja = nil
    	@personca[0].Habil = params[:person_ca][:Habilitada]
    	@personca[0].Contacto = params[:person_ca][:Contacto]
    	@personca[0].CategID = params[:person_ca][:CategID]#format_categ
    	#@personca.PersonaID = params[:id]
    	@personca[0].EmpresaID = 1
    	@personca[0].UltMovimID = nil

		if @personca.update(personca_params)
			redirect_to persons_list_view_path('index')
		else
			render 'edit'
		end
  	end

  	def destroy
    	@person = @personca = PersonCa.select('"dca_SujetoC".*').where(:PersonaID => "#{params[:id]}")
    	@person[0].destroy

    	/begin
    		if @person[0].destroy
    			redirect_to root_path
    		end
		rescue ActiveRecord::RecordNotFound => e
		  	# handle not found error
		  	redirect_to show, :flash => { :error => e.message }
		  	puts e.message
		rescue ActiveRecord::ActiveRecordError => e
		  	# handle other ActiveRecord errors
		  	redirect_to show, :flash => { :error => e.message }
		  	puts e.message
		rescue # StandardError
		  	# handle most other errors
		  	redirect_to show, :flash => { :error => e.message }
		  	puts e.message
		rescue Exception  => e
		  	# handle everything else
		  	redirect_to show, :flash => { :error => e.message }
		  	puts e.message
		end/

    	redirect_to root_path, notice: 'La persona ha sido eliminado correctamente'
  	end

  	def show_persons_wout_ca
  		query = <<-SQL
  			SELECT *
			FROM "dc_taPersonas"
			WHERE NOT EXISTS (SELECT * FROM "dca_SujetoC" WHERE "dca_SujetoC"."PersonaID" = "dc_taPersonas"."PersonaID");
		SQL

		result = Person.find_by_sql(query)
		return result
  	end
  	helper_method :show_persons_wout_ca

  	def get_categs(id)
  		query = <<-SQL
  			SELECT * FROM
			(
			SELECT 1 AS posicion, * FROM "dca_taCategs" AS t1
			WHERE "CategID" = '#{id}'
			UNION
			SELECT 2 AS posicion, * FROM "dca_taCategs" AS t2
			WHERE "CategID" != '#{id}' ORDER BY "CategID" ASC
			) t3 ORDER BY posicion, "CategID" ASC
	  		SQL

	  	categoria = Categoria.find_by_sql(query)

	  	return categoria.map{ |c| [c.Nombre, c.CategID] }.to_h
  	end
  	helper_method :get_categs

  	def search
  		query = <<-SQL 
  			SELECT dca_taPersonasCa.*, dc_taPersonas.*
			FROM dca_taPersonasCa
			INNER JOIN dc_taPersonas ON dca_taPersonasCa.PersonaID = dc_taPersonas.PersonaID
			WHERE dc_taPersonas.Apellido LIKE '%#{params[:search]}%'
			ORDER BY dc_taPersonas.Apellido, dc_taPersonas.Nombre;
		SQL

		result = PersonCa.find_by_sql(query)
		@persons = Kaminari.paginate_array(result).page params[:page]
	end
	helper_method :search

	def show_image
		@person = Person.find(params[:id])
		img = MiniMagick::Image.read(@person.Foto)
		img.resize('100x100')
		send_data img, :type => 'image/png',:disposition => 'inline'
	end

	def blob_to_file (id)
		@person = Person.find(id)
		File.open(File.join('app/assets/images/', id.to_s + '.jpg'), 'wb') do |f|
			f.write(@person.Foto)
		end
	end
	helper_method :blob_to_file

	#Para imagenes almacenadas en la dase de datos
	def blob_to_base64 (photo)
		#Convierte de formato '/xFF' a Base64 para poder mostrar la foto en la vista
		return "data:image/jpeg;base64," + [photo].pack('m0')
	end
	helper_method :blob_to_base64

	#Para imagenes almacenadas en disco
	def file_to_base64 (photo)
		puts [photo].pack('m0')
		#Convierte de formato '/xFF' a Base64 para poder mostrar la foto en la vista
		return [photo].pack('m0')
	end
	helper_method :file_to_base64

	def file_to_blob (path)
		f = File.open(path, 'rb') do |io|
			f = io.read
		end

		return f
		#return f.unpack('0xH*')

	end
	helper_method :file_to_blob

	#Fuerza formato de fecha a "dd/mm/yyyy"
	def format_date (date)
		return date.strftime("%d/%m/%Y")
	end
	helper_method :format_date

	private

	def check_for_cancel
  		if params[:commit] == "Cancel"
    		redirect_to root_path
  		end
	end

	def person_params
		params.permit(:Apellido, :Nombre, :TDoc, :NDoc, :Habil, :Foto, :CUIL)
	end

	def personca_params
		params.permit(:FecAlta, :FecBaja, :Habil, :Contacto, :CategID, :PersonaID, :EmpresaID, :UltMovimID)
	end

	def format_tdoc
		case params[:person][:TDoc]
		when 'Documento Nacional de Identidad'
			return 'DNI'
		when 'Libreta de Enrolamiento'
			return 'LE'
		when 'Libreta Civica'
			return 'LC'
		when 'Cedula de Identidad'
			return 'CI'
		end
	end

	def format_categ
		case params[:person_ca][:CategID]
		when 'Empleado'
			return 1
		when 'Pasante'
			return 2
		when 'Contratado'
			return 3
		when 'Proveedor'
			return 4
		when 'Visitante'
			return 5
		end
	end

	def decode_photo_base64(photo)
		if (photo != "")
			#remove base64 header (first 23 bytes)
			photo = photo[23..photo.length]
			return Base64.decode64(photo)
		end
	end
end