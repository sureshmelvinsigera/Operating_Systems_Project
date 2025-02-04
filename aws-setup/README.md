<h1>
  <span class="headline">Operating Systems: Hands-on</span>
  <span class="subhead">AWS Setup</span>
</h1>

## AWS Setup

This section is intended for instructors and course producers. It contains a list of resources and configuration steps required to set up the AWS environment for students.

### Network / VPC

The students will need a VPC with the following:
-- A public subnet that is able to access 192.168.14.0/24
-- A subnet of 192.168.14.0/24
-- Security groups assume that all internal IP's are in the 192.168.0.0/16 range

Region is not particularly important. US-East is a good starting point.

### Security Groups

`os-hands-on` security group that allows:
- SSH from anywhere
- RDP from anywhere
- All traffic from 192.168.0.0/16

### EC2 Instances

#### Pre-created

There needs to be one Windows server pre-created to stand-in as a print server. You might need a custom AMI as the off-the-shelf print server AMI's require additional configuration. This server should have the following:
- Windows Server 2025
- Suggested size is T3a Large
- Default volume size
- Installation Steps:
    - Go to printers and scanners
    - Add a printer
    - Add a local printer (select manual installation)
    - Use port LPT1 for the printer
    - Select the Microsoft PCL6 driver for the printer
    - Share the printer as `SharedPCLPrinter`
- Optional: Create a unique security group for the print server that only allows traffic from 192.168.0.0/16


#### Student Instances

Students will need to be deploy their own instances. These instances should be based on the following AMI:
[Ubuntu 24.04 LTS Desktop with GUI /RDP Access](https://aws.amazon.com/marketplace/pp/prodview-kepyp5mpwie7i) 

Recommended size is T3a Large

#### Resource limits

For this exercise, students should not be able to create more than:
- 2 concurrant instances (not counting the pre-created windows instance)
- Up to 60gb of volumes at any given time
- They should bel allowed to create security groups.

For this exercise, they should not need to create any other resources on AWS.
