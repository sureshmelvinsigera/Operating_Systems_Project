<h1>
  <span class="headline">Operating Systems: Hands-on</span>
  <span class="subhead">User Settings & Permissions</span>
</h1>


**Learning objective:** By the end of this lesson, students will have set relevant users and groups. Additionally they will have limited access to settings and the desktop for the 'students'.

## Scenario

You are a system administrator for a small school. You have been tasked with setting up workstations for the students. The school has chose to use Ubuntu Linux for their computer labs as it is open source, well-maintained, and can be properly secured. The students will need to print assignments to a network printer, access the internet, use a word processor, draw graphics, and during recess, play appropriate games. 

### Users and Groups

Create a user group called "students". For the moment we only need to create one user in this group: `k12Student`.

The admins already have a group called "admin". Create a user called `procurator` in this group. This will be for the lab instructor.

### Security

We do not want the students to be able to save any files to the desktop.

### UI Setup

Like many networks, we want to pre-configure some of the UI. The students should not be able to change the desktop wallpaper.

### Repeatability

Ideally, we want to be able to repeat this setup for other workstations in the future. Once you have worked out all the command line commands, write them all into a script that can be run on a fresh install of Ubuntu.

## Steps

SSH into the box and add a password for the `ubuntu` user (if you are not still connected).

```bash
ssh -i /path/to/your/key.pem ubuntu@<your-instance-public-ip>
```

### Add the groups and users

Create the group `students` and add the user `k12Student` to it. To do this we're going to uses the commands `groupadd` and `useradd`. The useradd command in particular has a LOT of options. Take a few minutes to [explore the manual](https://manpages.ubuntu.com/manpages/xenial/man8/useradd.8.html) to see the sorts of things that can be configured with `useradd`.

```bash
sudo groupadd students
sudo adduser k12student -m -g students -s /bin/bash
```

Let also proactively create the student user's desktop folder. We also need to use `chown` to set the owner of the folder to the k12student user instead of our user.

```bash
sudo mkdir /home/k12student/Desktop
sudo chown k12student:students /home/k12student/Desktop
```

In a larger network we likely will be using Active Directory or LDAP to manage users and groups. This will allow for one central authentication system for all resources on the network. As this is a starter lab, we're going to keep it simple.

Create the administrative user `procurator` and add them to the `admin` group.

```bash
sudo useradd procurator -m -g admin -s /bin/bash
```

Since we there isn't a central login server, we'll need to create passwords for these users. If doing this for production, do NOT hardwire this into a script. For the purposes of this lab, we're going to set some obvious defaults. *IMPORTANT! DO NOT DO THIS ON A PRODUCTION SYSTEM.*

```bash
sudo echo "k12student:student" | sudo chpasswd
sudo echo "procurator:teacher" | sudo chpasswd
```

This has set the password for the users `k12student` and `procurator` to `student` and `teacher` respectively.

### Security

We need to lock down the desktop so that the students cannot change the settings. We are going to restrict the ability of the student useru to save files to the desktop. We are going to do this by changing the permissions on the desktop folder using the command `chmod`. This command allows you to set permissions on files and folders. The permissions are set in three groups: the owner, the group, and everyone else. The permissions are read, write, and execute. 

The permissions are set using a three digit number. The first digit is the owner, the second is the group, and the third is everyone else. The numbers are calculated by adding the values of the permissions. Read is 4, write is 2, and execute is 1. So, read and write is 6, read and execute is 5, and read, write, and execute is 7. 

The ubuntu documentation has an even more detailed explanation of [how permissions work](https://help.ubuntu.com/community/FilePermissions).

```bash
sudo chmod 440 /home/k12student/Desktop
```

This command sets the permissions on the Desktop folder for the user `k12student` to read only for the owner and group, and no permissions for everyone else.

### UI Setup

The UI of Ubuntu linux is controlled by Gnome's configuration system called dconf. We can create a custom dconf profile to pre-set and harden some of the settings. Note: this is not a fool-proof way to lock down the desktop. It's a good start, but there are ways around it.

Upload [this wallpaper](./assets/wallpaper.jpg) file to the instance. You can use `scp` to do this. Run this on YOUR local machine and not the VM.

```bash
scp -i /path/to/your/key.pem /path/to/your/wallpaper.jpg ubuntu@<your-instance-public-ip>:/home/ubuntu/
```

The next steps are run on the vm. First create a common folder to store the wallpaper across many users and then copy our wallpaper to it.

```bash
sudo mkdir /usr/local/share/backgrounds/
sudo cp /home/ubuntu/wallpaper.jpg /usr/local/share/backgrounds/
sudo chmod 755 /usr/local/share/backgrounds/wallpaper.jpg
```

Now that we have a wallpaper file handly, we can start setting up the dconf profile. The first step is to create a new profile called `students`. To do this we are going to create a file in `/etc/dconf/profile/` called `students`. This file will contain the name of the profile and the path to the settings file.

The file should hold:

```
user-db:user
system-db:students
```

```bash
sudo bash -c 'echo "user-db:user" >> /etc/dconf/profile/students'
sudo bash -c 'echo "system-db:students" >> /etc/dconf/profile/students'
```

The way the above command works is by using `echo` to write the text to the file. The `>>` operator appends the text to the file. If you use a single `>` it will overwrite the file. We have to wrap this with `bash -c` because we need to run this as root and the `>>` operator is a shell feature.

The next task is to create the students settings file(s). These will contain the settings that we want to lock down. We are going to create a file in `/etc/dconf/db/students.d/` called `00_wallpaper`. This file will contain the settings for the wallpaper.

```bash
sudo mkdir /etc/dconf/db/students.d/
sudo bash -c "echo \"[org/gnome/desktop/background]\" >> /etc/dconf/db/students.d/00_wallpaper"
sudo bash -c "echo \"picture-uri='file:///usr/local/share/backgrounds/wallpaper.jpg'\" >> /etc/dconf/db/students.d/00_wallpaper"
sudo bash -c "echo \"picture-options='scaled'\" >> /etc/dconf/db/students.d/00_wallpaper"
sudo bash -c "echo \"primary-color='000000'\" >> /etc/dconf/db/students.d/00_wallpaper"
sudo bash -c "echo \"secondary-color='000000'\" >> /etc/dconf/db/students.d/00_wallpaper"
```

The above commands create a file in the students settings directory and then write the settings to it. The settings are for the wallpaper. The `picture-uri` is the path to the wallpaper file. The `picture-options` is how the wallpaper is displayed. The `primary-color` and `secondary-color` are the colors of the desktop.

The complete dconf manual [dconf manual](https://developer.gnome.org/dconf/unstable/dconf-tool.html) has more settings.

The final step is to reload dconf and apply it to the user.

```bash
sudo dconf update
sudo bash -c 'echo "export DCONF_PROFILE=\"students\"" >> /home/k12student/.profile'
```



## Testing Software Installation

Unlike the software installation step, we need to do a bit more testing. Using RDP log in as a student and:
- Try to save a file on the desktop. You *should not* be able to.

Log out and log in as the user `procurator`. You should be able to:
- Try to save a file on the desktop. You *should* be able to.

## Level Up: Test Your Script

Hopefully you've been saving each successful command in a script file (named something like `provision.sh`). To test if it works:

- Terminate your ubuntu instance (this will delete all your existing work)
- Launch a new instance just like the old one
- Instead of running all the commands manually, upload your script:
  ```bash
  scp -i /path/to/your/key.pem provision.sh ubuntu@<your-instance-public-ip>:/home/ubuntu
  ```
- Log into your script with SSH and run your script:
  ```bash
  ssh -i /path/to/your/key.pem ubuntu@<your-instance-public-ip>
  sudo bash /home/ubuntu/provision.sh
  ```
- Log in as the student via RDP and test it! Check for the installed software and the permissions on the desktop.