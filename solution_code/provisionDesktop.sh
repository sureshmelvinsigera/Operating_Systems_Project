
# Update the OS
sudo apt-get update
sudo apt-get upgrade -y

# Install the basic tools
sudo apt-get install chromium-browser inkscape gimp supertux  -y

# Install the development tools
# Reference: https://code.visualstudio.com/docs/setup/linux
echo "code code/add-microsoft-repo boolean true" | sudo debconf-set-selections
sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
sudo apt-get install apt-transport-https -y
sudo apt-get update
sudo apt-get install code -y

# Install the printer
sudo apt-get install smbclient -y
sudo lpadmin -p "PCLPrinter" -v "smb://50.17.69.191/SharedPCLPrinter" 


# Create the user groups and users
sudo groupadd students

# Set default dconf behavior when usesrs are created

# Create the student user and add to student group
sudo useradd k12student -m -G students -s /bin/bash


# Create the teacher user and add to admin group
# We can use the existing 'admin' group
sudo useradd procurator -m -G admin -s /bin/bash

# Set default password for the student and teacher
sudo echo "k12student:student" | sudo chpasswd
sudo echo "procurator:teacher" | sudo chpasswd

# Block the student user from changing their desktop
sudo mkdir /home/k12student/Desktop
sudo chown k12student:students /home/k12student/Desktop
sudo chmod 440 /home/k12student/Desktop


sudo mkdir /usr/local/share/backgrounds/
sudo cp /home/ubuntu/wallpaper.jpg /usr/local/share/backgrounds/
sudo chmod 755 /usr/local/share/backgrounds/wallpaper.jpg

# Create a custom dconf profile for the students
sudo bash -c 'echo "user-db:user" >> /etc/dconf/profile/students'
sudo bash -c 'echo "system-db:students" >> /etc/dconf/profile/students'

# Create the lock file for the students
sudo mkdir /etc/dconf/db/students.d/
sudo bash -c "echo \"[org/gnome/desktop/background]\" >> /etc/dconf/db/students.d/00_wallpaper"
sudo bash -c "echo \"picture-uri='file:///usr/local/share/backgrounds/wallpaper.jpg'\" >> /etc/dconf/db/students.d/00_wallpaper"
sudo bash -c "echo \"picture-options='scaled'\" >> /etc/dconf/db/students.d/00_wallpaper"
sudo bash -c "echo \"primary-color='000000'\" >> /etc/dconf/db/students.d/00_wallpaper"
sudo bash -c "echo \"secondary-color='000000'\" >> /etc/dconf/db/students.d/00_wallpaper"

# Set the profile
sudo dconf update
sudo bash -c 'echo "export DCONF_PROFILE=\"students\"" >> /home/k12student/.profile'

# Set Automatic Upgrades
sudo apt-get install unattended-upgrades -y

# Enable the automatic upgrades
sed -i 's|\s*//\s*"\${distro_id}:\${distro_codename}";|\t"\${distro_id}:\${distro_codename}";|' /etc/apt/apt.conf.d/50unattended-upgrades
sed -i 's|\s*//\s*"\${distro_id}:\${distro_codename}-security";|\t"\${distro_id}:\${distro_codename}-security";|' /etc/apt/apt.conf.d/50unattended-upgrades
sed -i 's|\s*//\s*"\${distro_id}:\${distro_codename}-updates";|\t"\${distro_id}:\${distro_codename}-updates";|' /etc/apt/apt.conf.d/50unattended-upgrades

# Reload the Upgrade Service
sudo systemctl restart unattended-upgrades
