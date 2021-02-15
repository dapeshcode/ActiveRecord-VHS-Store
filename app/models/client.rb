class Client < ActiveRecord::Base
    has_many :rentals 
    has_many :vhs, through: :rentals

    
    
    def self.first_rental(client_hash, vhs)
        client = Client.create(client_hash)
        if vhs.is_available_to_rent?
            Rental.create(client_id: client.id, vhs_id: vhs.id, current: true)
        else
            puts "Please pick an available Vhs"
        end
    end
    # returns a list of top 5 most active clients (i.e. those who had the most non-current / returned rentals)

    def past_rentals 
        self.rentals.select{|v| v.current == false}
        # binding.pry
    end 

    def self.most_active
        Client.all.sort_by{|client| client.num_past_rentals.count}.reverse.slice(0,5)
    end 

    def self.non_grata 
        Rental.past_due_date.map{|r| r.client}.uniq
    end
    




end
