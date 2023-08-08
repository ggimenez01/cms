class About < ApplicationRecord
<<<<<<< HEAD
  def self.ransackable_attributes(auth_object = nil)
    ["title", "description", "content"]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
=======

    def self.ransackable_attributes(auth_object = nil)
        ["title", "description", "content"]
      end
    
      def self.ransackable_associations(auth_object = nil)
        []
      end    
>>>>>>> origin/master
end
