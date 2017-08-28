class AddClickCount < ActiveRecord::Migration[5.0]
	def change
		add_column :urls, :click_count, :integer
	end
end
