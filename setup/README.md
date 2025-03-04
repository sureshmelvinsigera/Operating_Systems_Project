<h1>
  <span class="headline">Operating Systems: Hands-on</span>
  <span class="subhead">Setup</span>
</h1>


## Pre-Requisites

You will need these tools and items to complete this exercise:
- Access to the course AWS account
- An ssh key set up on the AWS account
- A terminal application capable of SSH
- A Remote Desktop Protocol (RDP) client (this is built into Windows, and available for Mac and Linux)

## Setup

Log into your AWS account and launch a T3a.Large instance using the following AMI:

[Ubuntu 24.04 LTS Desktop with GUI /RDP Access](https://aws.amazon.com/marketplace/pp/prodview-kepyp5mpwie7i) 

Use the security group: `os-hands-on` (or create a new one that allows: SSH, and RDP to all traffic, and all ports on 192.168.0.0/16)

Your EC2 should be in a 'public' subnet of your VPC.

Note: This security group is NOT secure for production use. It's only for this lab.


This AMI will launch an Ubuntu 24.04 instance with a desktop interface installed (most AMIs on AWS do not include a desktop interface). Once booted, we need to enable our user to log in via RDP.

Take note of the PUBLIC IP address of your instance.

### Enable RDP Access with a password

Open your Terminal application SSH into your new instance using the following command (replacing your key and your-instance-public-ip with your actual key and public IP):

```bash
ssh -i /path/to/your/key.pem ubuntu@<your-instance-public-ip>
```

Once you are logged in, run the following command to set a password for your ubuntu user:

```bash
sudo passwd ubuntu
```

You can now log into your VM either with SSH or RDP. 

