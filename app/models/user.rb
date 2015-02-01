class User < ActiveRecord::Base
  include Clearance::User

  def can_delete_songs?
    if self.admin?
      true
    else
      false
    end
  end
end
