require 'facter/util/wmi'

Facter.add(:windows_users) do
  confine :kernel => 'Windows'

  setcode do
    wql = Facter::Util::WMI.execquery("select * from win32_useraccount")

    users = []
    wql.each do |u|
      users << u.name
    end
    users.join(",")
  end
end
