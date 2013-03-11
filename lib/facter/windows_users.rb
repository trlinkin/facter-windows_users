require 'win32ole'

Facter.add(:windows_users) do
  confine :kernel => 'Windows'

  setcode do
    begin
      wmi = WIN32OLE.connect("winmgmts:{impersonationLevel=impersonate}!//./root/cimv2")
      wql = wmi.execquery("select * from win32_useraccount")

      users = []
      wql.each do |u|
        users << u.name
      end
      users.join(",")
    end
  end
end
