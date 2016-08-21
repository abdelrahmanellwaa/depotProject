class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_secure_password
  #we can make it also before destroy
  after_destroy :ensure_an_admin_remains
private
	def ensure_an_admin_remains
		if User.count.zero?
			#raise an error so can be found in flash and also to rollback the 
			#transactions that deletes the only admin
			raise "Can't delete last user"
		end 	
	end
end
