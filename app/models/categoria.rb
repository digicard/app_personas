class Categoria < ApplicationRecord
	#Person.connection
	#self.abstract_class = true # to avoid Rails' no associated model exception
	self.table_name = 'dca_taCategs'
	self.primary_key = 'CategID'

	def table_exists?
		connection.schema_cache.data_source_exists=(table_name)
	end
end