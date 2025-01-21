<h1>
  <span class="headline">Operating Systems: Hands-on</span>
  <span class="subhead">Configure the Machine: Software</span>
</h1>


**Learning objective:** By the end of this lesson, students will have set up a workstation with a printer.

## Scenario

You are a system administrator for a small school. You have been tasked with setting up workstations for the students. The school has chose to use Ubuntu Linux for their computer labs as it is open source, well-maintained, and can be properly secured. The students will need to print assignments to a network printer, access the internet, use a word processor, draw graphics, and during recess, play appropriate games. 

### Software
The lab instructor has asked you to ensure that this software is available for the students:

- Chrome Browser (or open source equivalent)
- LibreOffice Writer
- Visual Studio Code
- GIMP (graphics editor)
- Inkscape (vector graphics editor)
- Supertux (game)

The student will also need to access a network printer. The printer is a shared printer on the network using a PCL6 driver. The printer is shared as "SharedPCLPrinter" via windows networks (also known as smb).

### Repeatability

Ideally, we want to be able to repeat this setup for other workstations in the future. Once you have worked out all the command line commands, write them all into a script that can be run on a fresh install of Ubuntu.

## Steps

SSH into the box and add a password for the `ubuntu` user.

```bash
ssh -i /path/to/your/key.pem ubuntu@<your-instance-public-ip>
```

Update the package list and run any software updates.

```bash
sudo apt-get update
sudo apt-get upgrade -y
```

Install the software requested by the lab instructor. While of the packages are available in the default repositories, Visual Studio code is not. You will need to add the repository and key.

Note: LibreOffice writer is already installed by default on Ubuntu!

Question: why are we adding `-y` to the end of the `apt-get` command?

```bash
sudo apt-get install chromium-browser inkscape gimp supertux -y
```

Add the Visual Studio Code repository and key. Microsoft provides a set of [instructions for you to follow](https://code.visualstudio.com/docs/setup/linux
). 


```bash
echo "code code/add-microsoft-repo boolean true" | sudo debconf-set-selections
sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https -y
sudo apt update
sudo apt install code -y
```

So the `-y` will automatically answer yes to the apt commands which makes the script non-interactive (you don't need to type anything). Why are we running `apt update` again before we install `code`? This is because adding the Visual Studio Code (aka `code`) repository doesn't update the list of software available for install. We have to do that first for `code` to be available.


## Connecting the Printer

To connect the printer we have to install a client for smb. This is a protocol that Windows (and now linux and Mac OS) uses to share printers and files. The SMB client package is called `smbclient` and can also be used to access file shares and other windows network resources. Note: many linux-based systems also support smb sharing. It's perfectly normal for a network comprised entirely of linux and/or MacOS machines to use smb for sharing files and printers.

```bash
sudo apt-get install smbclient -y
```

Now we can connect to the printer. The printer is shared as "SharedPCLPrinter" on the network. The command lpadmin can be used to connect the printer. Let's call it `PCLPrinter`. Older versions of lpadmin may require the specification of a driver. Modern linux systems do not require this.

```bash
sudo lpadmin -p "PCLPrinter" -v "smb://192.168.14.22/SharedPCLPrinter" 
```


## Testing Software Installation and Printer

Stop and test the machine to verify that the software installed. Using RDP connect to the machine and open each application to ensure that it is installed. Use the usesrname 'ubuntu' and the password you set earlier.

Open the chromium web browser and navigate to any website. Try to print the page and make sure that there is a printer available that is NOT the default "PDF Printer".
