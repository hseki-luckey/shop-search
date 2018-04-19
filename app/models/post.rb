class Post < ActiveRecord::Base
	has_many :comments

	scope :get_by_keyword, ->(keyword){
		keywords = keyword.split("　")
		table_field = Array.new
		table_field = [:shop, :area, :genre]

		cond = nil
		keywords.each{ |word|
			table_field.each{ |field|
				cond = cond ? cond.or(arel_table[field].matches('%'+word+'%')) : arel_table[field].matches('%'+word+'%')
			}
		}
		where(cond)
	}

	scope :get_by_name, ->(shop) {
		where("shop like ?", "%#{shop}%")
	}

	scope :get_by_rate_l, ->(rate_l){
		where('rate_l >= ?', "#{rate_l}")
	}

	scope :get_by_rate_u, ->(rate_u){
		where('rate_u <= ?', "#{rate_u}")
	}

	scope :search_values_or, lambda { |field, values|
    	fields = [fields] if fields.class == Symbol

    	cond = nil
    	values.each { |value| 
    		cond = cond ? cond.or(arel_table[field].matches('%'+value+'%')) : arel_table[field].matches('%'+value+'%')
    	}
    	where(cond)
    }

    paginates_per 10  # 1ページあたり5項目表示
end
