class User < ActiveRecord::Base
  include Clearance::User

  def can_delete_songs?
    true if self.admin?
  end
end
