<h1>
  <span class="headline">Operating Systems: Hands-on</span>
  <span class="subhead">Linux System & User Management Overview</span>
</h1>

## Scenario

We've been tasked with setting up workstations for a small school. The school has chosen to use Ubuntu Linux for their computer labs as it is open source, well-maintained, and can be properly secured. The students will need to print assignments to a network printer, access the internet, use a word processor, draw graphics, and during recess, play appropriate games.

## Preparation

Before arriving on the client's we should prepare and review key concepts. This is going to be a constant pattern in our career as we'll regularly need to update our knowledge and skills. It's also a fact that we can't remember everything and even seasoned hands will consult the documentation (if they are good at their job).

Your group will review the roles of several key components in Linux system and user management and how each component performs its role.

To complete this task, you may use your work from the following Turn-in Assignments:
* Course 2 Module 1 “Recommend basic wired network hardware”
* Course 2 Module 2 “Planning secure wireless networks”
* Notes from your prior lessons on Linux user management

## Group Discussion

Discuss the following questions with your group:
1. What are some of the different ways to install software in Ubuntu Linux (or any Debian-based system)?
2. What some ways we can reasonably determine that software is from a reliable source and is being updated? And why does it matter?
3. Aside from installing software, what should we do to make this system secure and reliablel enough to allow children to access in their lab?
4. How can we keep the software updated? Are they ways to make this more efficient?
5. If we allow automatic updates, what are some of the risks? Do you think they are worth it in this scenario?
6. How can we ensure that all of the steps we do are repeatable so we can make sure that every lab computer is built the same way? Can Bash scripting help with this?

## Key Concepts and Useful Commands

### Creating and Managing User Accounts, Groups, and Permissions
*Role*: Establishes user identities and access levels within the system.
*Processes*: Using commands like `useradd`, `groupadd`, `chmod`, and `chown` to create and modify users and permissions.
*Commands/Protocols*: `useradd`, `usermod`, `groupadd`, `chmod`, `chown`, `passwd`.

### Understanding Sudo Privileges vs. Standard User Privileges
*Role*: Differentiates between users with administrative rights and those with limited access.
*Processes*: Configuring the `/etc/sudoers` file to grant or restrict sudo access. Alternatively, add administrative users to the sudo group or a group that already is in the sudo group.
*Commands/Protocols*: `sudo`, `visudo`, `sudoers` file configurations.

### Familiarizing with the Ubuntu (or Ubuntu MATE) Interface and Package Manager (e.g., apt)
*Role*: Manages software installation, updates, and system configurations.
*Processes*: Using the terminal or GUI tools to install, update, and remove packages.
*Commands/Protocols*: `apt-get`, `apt`, `dpkg`.

### Children’s Center User Requirements:
Ages 10-18 with Limited Permissions
*Role*: Ensures young users have restricted access to prevent unauthorized changes.
*Processes*: Creating standard user accounts with limited permissions.
*Commands/Protocols*: `useradd`, `chmod`, `chown`, `groupadd`.

### Administrators Who Can Install Software and Change System Settings
*Role*: Allows trusted users to manage and configure the system.
*Processes*: Assigning sudo privileges to administrator accounts.
*Commands/Protocols*: `sudo`, `visudo`, `useradd`.

### Identify Potential Security Concerns:
Preventing Unauthorized Software Installations
*Role*: Maintains system integrity by restricting software changes.
*Processes*: Limiting sudo access and enforcing strict permission settings.
*Commands/Protocols*: `chmod`, `chown`, sudoers configurations.

### Restricting Where Children Can Save Files
*Role*: Protects the file system and sensitive data by controlling file locations.
*Processes*: Setting directory permissions and using user quotas.
*Commands/Protocols*: `chmod`, `chown`