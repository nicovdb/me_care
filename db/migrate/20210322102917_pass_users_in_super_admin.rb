class PassUsersInSuperAdmin < ActiveRecord::Migration[6.0]
  def change
    u = User.find_by(email: "clairegautier1809@gmail.com")
    if u
      u.superadmin = true
      u.save
    end
    v = User.find_by(email: "nicolasvandenbussche0@gmail.com")
    if u
      v.superadmin = true
      v.save
    end
  end
end
