class Person < ApplicationRecord
	has_one :person_ca, foreign_key: "PersonaID"
	has_one :empresa, foreign_key: "EmpresaID"
	has_one :categoria, foreign_key: "CategID"

	#validates :NDoc, presence: true,
	#				 length: { minimum: 3 }
	#mount_base64_uploader :image, PersonImageUploader
	mount_uploader :image, PersonImageUploader

	self.table_name = 'dc_taPersonas'
	self.primary_key = 'PersonaID'

	def table_exists?
		connection.schema_cache.data_source_exists=(table_name)
	end
end