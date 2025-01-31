<h1>
  <span class="headline">Operating Systems: Hands-on</span>
  <span class="subhead">System Configuration Guide</span>
</h1>

## Goals

You've completed building the workstations for the school. Now it's time to document your work and finalize your provisioning scripts. This will ensure that the workstations can be easily rebuilt in the future.

There are some key reasons we are doing this:
1. Repeatability: We want to ensure that all workstations are built the same way.
2. Redundancy: You are likely working on a team. If you are not available, someone else should be able to pick up where you left off. This enables you to take a vacation or get sick and not have a major incident.

## Tasks

Create a new folder on googlee drive and share it with your group. This will be the location where you will store all of your documentation and scripts. Share the document with relevant team members, ensuring appropriate access permissions (view/edit).


### Documentation

Create a new Google Doc called "System Configuration Guide". Track changes and maintain version history to manage updates effectively. Organize your document with clear heading and sections:

#### Introduction
* Provide an overview of the guide’s purpose and scope.
* Outline project objectives and key outcomes.
* This should be a summary of the work and be no longer than 1 page.

#### Table of Contents
Be sure to organize your document appropriate headers and subheaders. This will enable you to automatically generate a tablee of contents for easy navigation.

#### Sections for Each Configuration Task
* Document what you needed to do and if there are any special considerations, notes, or steps.
* Do reference how to run your script(s)

##### For Each Configuration Task
* Briefly descript the goal
* List any relevant commandns and steps

###### Example

```bash
sudo groupadd children
sudo groupadd administrators
sudo usermod -aG children username
sudo usermod -aG administrators adminname
```

Configuration Files Edited:
Specify file paths and exact changes made.
Example:
File: `/etc/sudoers`
Change: Added adminname ALL=(ALL) NOPASSWD: ALL to grant sudo privileges.

Package Names Installed:
List all software packages installed, including versions if applicable.
* LibreOffice 7.5
* Firefox 112.0

Scripts or Automation Tools Used:
Mention any scripts or tools (e.g., Ansible playbooks) utilized for automation.

###### Include Visual Aids
Screenshots: Capture and insert screenshots to illustrate configurations.
User Creation Screens:
Show the process of adding users to groups.
Group Membership:
Display group memberships via commands like groups username.
Printer Configuration Dialog:
Illustrate steps taken to add and configure the network printer.
Annotated Images:
Use annotations (arrows, labels) to highlight important elements in screenshots.

##### Provide Detailed Explanations

Step-by-Step Descriptions:
Explain each step clearly and concisely to ensure replicability.

Rationale for Decisions:
Describe why specific commands, configurations, or tools were chosen if relevant. You do NOT need to document every single command, but explain the reasoning behind key decisions.

Example:
“Restricted file saving locations to prevent unauthorized data storage on the Desktop, enhancing security for child users.”

##### Validate and Verify Configurations:

Detail steps taken to confirm each configuration was successful. *DO* consider how to prove that your steps were successful and how to document them. This could be screenshots, logs, or other methods and will come in quite useful if there is a security audit or requirement to prove that security controls are in place.

Example:

Verified group assignments using `groups username`.
Tested sudo access by executing a command with elevated privileges.

##### Finalize the Document
* Review for Completeness
* Ensure all steps are documented.
* Proofread for Clarity and Accuracy.
* Check for grammatical errors and ensure technical accuracy.
* Organize for Readability
* Use bullet points, numbered lists, and consistent formatting to enhance readability.

### Scripts

Upload to the drive your bash scripts that you used to configure the workstations. Be sure to include comments in your scripts to explain what each section does. (This will be helpful for any additional team members who may need to use the scripts in the future.)

## Wrap-up and Reflection

### Group Debrief
* Share any challenges encountered, such as permission issues or difficulty installing certain applications.
* Discuss how you troubleshooted problems—did you use built-in man pages, online documentation, or an AI assistant?

### Written Reflection
Individually or as a group, compose a short (300-500 word) reflection to address:
* The effectiveness of AI or other tools in troubleshooting, command research, or script building.
* Opportunities for automation: If you had 10 or 100 workstations, how would you streamline the process? (e.g., scripts, imaging, or configuration management tools like Ansible)
* Personal insights: What did you learn about Linux system administration?
