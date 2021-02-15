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
        self.select {|rental| rental.past_due_date?}
    end

end


# Rental.past_due_date - 
# returns a list of all the rentals - iterate over that list to return - if updated_at - created_at > 7days return that array
# - all that are past due date, 
# - currently rented 
# - or rented in the past