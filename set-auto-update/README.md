<h1>
  <span class="headline">Operating Systems: Hands-on</span>
  <span class="subhead">Configure the Machine: Software</span>
</h1>

## Scenario

You are a system administrator for a small school. You have been tasked with setting up workstations for the students. The school has chose to use Ubuntu Linux for their computer labs as it is open source, well-maintained, and can be properly secured. The students will need to print assignments to a network printer, access the internet, use a word processor, draw graphics, and during recess, play appropriate games. 

## Automatic Updates

We don't want administrators or students to have the task of regularly running updates. What has to be done manually often just will not get done. Thankfully it's possible to have Ubuntu automatically download and apply updates. We need to install the unnatended-upgrades package and then configure it.


This will install the automatic upgrade package.

```bash
sudo apt install unattended-upgrades
```

Next, we need to configure the upgrades. We want to ensure that the operating system, security, and software updates are automatically installed. Edit the configuration file and ensure that these three lines are uncommented:

`"${distro_id}:${distro_codename}-updates";
"${distro_id}:${distro_codename}";
"${distro_id}:${distro_codename}-security";`

```bash
sudo nano /etc/apt/apt.conf.d/50unattended-upgrades
```

Once the configuration is updated, reload the service and ensure that it works.

```bash
sudo systemctl restart unattended-upgrades.service
sudo unattended-upgrades --dry-run
```

## Level Up

This task can be somewhat challenging as the goal is to uncomment already existing lines in a configuration file. Research ways to use `sed` to find and uncomment the lines. You may want to test your commands on a COPY of the configuration file first to see how it works.

### Hints

Example `sed` command:
```bash
sed -i 's/find/replace/g' file.txt
```

The site [Regexr](https://regexr.com/) is a great tool to test regular expressions.