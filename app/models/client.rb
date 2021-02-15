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
        binding.pry
    end

end