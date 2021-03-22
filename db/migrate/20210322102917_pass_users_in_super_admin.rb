class PassUsersInSuperAdmin < ActiveRecord::Migration[6.0]
  def change
    u = User.find_by(email: "clairegautier1809@gmail.com")
    u.superadmin = true
    u.save
    v = User.find_by(email: "nicolasvandenbussche0@gmail.com")
    v.superadmin = true
    v.save
  end
end
