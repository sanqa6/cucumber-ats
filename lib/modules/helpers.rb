module Helpers

	# Converts matched strings to bool
	def to_bool
		return true if self == true || self =~ (/^(true|t|yes|y|1)$/i)
		return false if self == false || self.blank? || self =~ (/^(false|f|no|n|0)$/i)
		raise ArgumentError.new("invalid value for Boolean: \"#{self}\"")
	end

	#Search for a string in a table for a given column and return the value of given column
	#tableId: id of table
	#searchColumn: integer - column number to search
	#searchString: string to search
	#returnColumn: integer - returns the value of column of matched string
	def search_and_get_value_table(tableId, searchColumn, searchString, returnColumn)
	    first(:xpath, ".//*[@id='#{tableId}']/tr[contains(td[#{searchColumn}], '#{searchString}')]/td[#{returnColumn}]/a").text
	end

end