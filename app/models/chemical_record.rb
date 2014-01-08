class ChemicalRecord < ActiveRecord::Base

	def self.to_csv
	  CSV.generate do |csv|
	    csv << column_names
	    all.each do |chemical_record|
	      csv << chemical_record.attributes.values_at(*column_names)
	    end
	  end
	end
end
