class Rental < ActiveRecord::Base
    belongs_to :client 
    belongs_to :vhs
    
    
    def due_date
        created_at + 7.days
    end
   
    def past_due_date?
        self.updated_at < self.due_date
    end

    def self.past_due_date
        binding.pry
        self.select {|rental| rental.past_due_date?}
    end

end


