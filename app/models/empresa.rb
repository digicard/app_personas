class Empresa < ApplicationRecord
	#has_many :persons, foreign_key: "PersonaID"
	#Empresa.connection
	#self.abstract_class = true # to avoid Rails' no associated model exception
	self.table_name = 'dc_taEmpresas'
	self.primary_key = 'EmpresaID'

	def table_exists?
		connection.schema_cache.data_source_exists=(table_name)
	end
end