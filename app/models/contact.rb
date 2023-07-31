class Contact < ApplicationRecord
    def self.ransackable_attributes(auth_object = nil)
        ["name", "email", "address", "phone_number"]
      end
    
      def self.ransackable_associations(auth_object = nil)
        []
      end
end
