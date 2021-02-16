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

    def return_one(vhs) 
        self.rentals.find{|rental| rental.vhs == vhs}.update(current: false)
    end

    def return_all
        self.rentals.update(current: false)
    end

    def last_return
        self.return_all 
        self.destroy
        
    end

    def rental_fees
        self.rentals.count * 5.35
    end

    def late_fees
        self.rentals.count{|rental| rental.past_due_date?} * 12 
    end
    
    def total_fees
        rental_fees + late_fees
    end

    def self.paid_most
        Client.all.max_by{|client| client.total_fees}
    end

    




end
