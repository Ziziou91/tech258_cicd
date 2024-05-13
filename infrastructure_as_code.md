# Infrastructure as Code

So far we've been able to automate multiple tasks with jenkins, such as testing and integration, but there are some things we still have do manually. Currently we need to manually launch our EC2 instances before we can deploy our code. **Infrastructure as code** gives us a way to launch virtual machines, and associates cloud services, through **orchestration**. We can specify the conditions and constants with a **configuration file**, typically written in YAML. 

A popular suite of tools for infrastructure as code is Ansible - alternatives include terraform, chef, puppet, cloudformation (AWS only and paid for).
