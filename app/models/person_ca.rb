class PersonCa < ApplicationRecord
	belongs_to :person, foreign_key: "PersonaID"

	self.table_name = 'dca_SujetoC'
	self.primary_key = 'SujetoCID'

	def table_exists?
		connection.schema_cache.data_source_exists=(table_name)
	end

	#paginates_per 49
end