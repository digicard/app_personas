class PersonsController < ApplicationController
	def list_view
		if (params[:search] == nil)
			if (params[:id] == 'index')
				query = <<-SQL 
	  				SELECT dca_taPersonasCa.*, dc_taPersonas.*
					FROM dca_taPersonasCa
					INNER JOIN dc_taPersonas ON dca_taPersonasCa.PersonaID = dc_taPersonas.PersonaID
					ORDER BY dc_taPersonas.Apellido, dc_taPersonas.Nombre;
					SQL
			else
				query = <<-SQL 
	  				SELECT dca_taPersonasCa.*, dc_taPersonas.*
					FROM dca_taPersonasCa
					INNER JOIN dc_taPersonas ON dca_taPersonasCa.PersonaID = dc_taPersonas.PersonaID
					WHERE dc_taPersonas.Apellido LIKE '#{params[:id]}%'
					ORDER BY dc_taPersonas.Apellido, dc_taPersonas.Nombre;
				SQL
			end
		else#searchbar
			query = <<-SQL 
  				SELECT dca_taPersonasCa.*, dc_taPersonas.*
				FROM dca_taPersonasCa
				INNER JOIN dc_taPersonas ON dca_taPersonasCa.PersonaID = dc_taPersonas.PersonaID
				WHERE dc_taPersonas.Apellido LIKE '%#{params[:search]}%' OR dc_taPersonas.Nombre LIKE '%#{params[:search]}%'
				ORDER BY dc_taPersonas.Apellido, dc_taPersonas.Nombre;
			SQL
		end

		result = PersonCa.find_by_sql(query)
		@persons = Kaminari.paginate_array(result).page params[:page]
	end

	def icon_view
		if (params[:search] == nil)
			if (params[:id] == 'index')
				query = <<-SQL 
	  				SELECT dca_taPersonasCa.*, dc_taPersonas.*
					FROM dca_taPersonasCa
					INNER JOIN dc_taPersonas ON dca_taPersonasCa.PersonaID = dc_taPersonas.PersonaID
					ORDER BY dc_taPersonas.Apellido, dc_taPersonas.Nombre;
					SQL
			else
				query = <<-SQL 
	  			SELECT dca_taPersonasCa.*, dc_taPersonas.*
				FROM dca_taPersonasCa
				INNER JOIN dc_taPersonas ON dca_taPersonasCa.PersonaID = dc_taPersonas.PersonaID
				WHERE dc_taPersonas.Apellido LIKE '#{params[:id]}%'
				ORDER BY dc_taPersonas.Apellido, dc_taPersonas.Nombre;
				SQL
			end
		else#searchbar
			query = <<-SQL 
  				SELECT dca_taPersonasCa.*, dc_taPersonas.*
				FROM dca_taPersonasCa
				INNER JOIN dc_taPersonas ON dca_taPersonasCa.PersonaID = dc_taPersonas.PersonaID
				WHERE dc_taPersonas.Apellido LIKE '%#{params[:search]}%' OR dc_taPersonas.Nombre LIKE '%#{params[:search]}%'
				ORDER BY dc_taPersonas.Apellido, dc_taPersonas.Nombre;
			SQL
		end

		result = PersonCa.find_by_sql(query)
		@persons = Kaminari.paginate_array(result).page params[:page]
	end

	def show_person
		query = <<-SQL 
  			SELECT *
			FROM dc_taPersonas AS P
			WHERE P.PersonaID = '#{params[:pid]}'
		SQL

		@person = Person.find_by_sql(query)
		render json: @person
	end

  	def edit
		query = <<-SQL 
  			SELECT dca_taPersonasCa.*, dc_taPersonas.*
			FROM dca_taPersonasCa
			INNER JOIN dc_taPersonas ON dca_taPersonasCa.PersonaID = dc_taPersonas.PersonaID
			WHERE dca_taPersonasCa.PersonaCaID = '#{params[:id]}'
		SQL

		@personca = PersonCa.find_by_sql(query)
		@person = Person.find_by_sql(query)
  	end

  	def create
    		query = <<-SQL 
  			INSERT INTO dc_taPersonas ([Apellido], [Nombre], [TDoc], [NDoc], [Habil], [CUIL])
  			VALUES ('#{params[:person][:Apellido]}', '#{params[:person][:Nombre]}', '#{format_tdoc}', '#{params[:person][:NDoc]}',
  					'#{params[:Habil]}', '#{params[:person][:CUIL]}')
		SQL

		Person.find_by_sql(query)

    		redirect_to new_person_path, notice: 'La persona ha sido ingresada correctamente'
    	end

  	def create_person_ca
  		query = <<-SQL 
  			INSERT INTO dca_taPersonasCa ([FecAlta], [FecBaja], [Habil], [Contacto], [CategID], [PersonaID], [EmpresaID], UltMovimID)
  			VALUES (GETDATE(), NULL, '#{params[:person_ca][:Habil]}', '#{params[:person_ca][:Contacto]}',
  					'#{format_categ}', '#{params[:pid]}', '1', NULL)
		SQL

    		@personca = PersonCa.find_by_sql(query)

    		redirect_to new_person_path
  	end

  	def update
		query = <<-SQL 
  			UPDATE P
			SET P.Apellido = '#{params[:person][:Apellido]}', P.Nombre =  '#{params[:person][:Nombre]}',
				P.TDoc =  '#{format_tdoc}', P.NDoc =  '#{params[:person][:NDoc]}',
				P.Habil =  '#{params[:Habil]}', P.CUIL = '#{params[:person][:CUIL]}'
			FROM dc_taPersonas AS P
			INNER JOIN dca_taPersonasCa ON P.PersonaID = (SELECT dc_taPersonas.PersonaID
								      FROM dca_taPersonasCa
								      INNER JOIN dc_taPersonas ON dca_taPersonasCa.PersonaID = dc_taPersonas.PersonaID
								      WHERE dca_taPersonasCa.PersonaCaID = '#{params[:id]}')
		SQL

		@person = Person.find_by_sql(query)

		puts @person

		redirect_to root_path
  	end

  	def update_person_ca
  		query = <<-SQL 
  			UPDATE P
			SET P.Habil = 1, P.Contacto =  '#{params[:person_ca][:Contacto]}', P.CategID = '#{format_categ}'
			FROM dca_taPersonasCa AS P
			WHERE P.PersonaCaID = '#{params[:id]}'
		SQL

		@personca = PersonCa.find_by_sql(query)

		redirect_to root_path
  	end

  	def show_persons_wout_ca
  		query = <<-SQL
  			SELECT *
			FROM dc_taPersonas
			WHERE NOT EXISTS (SELECT * FROM dca_taPersonasCa WHERE dca_taPersonasCa.PersonaID = dc_taPersonas.PersonaID);
		SQL

		result = Person.find_by_sql(query)
		return result
  	end
  	helper_method :show_persons_wout_ca

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
