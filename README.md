# CICD Pipelines

CI/CD pipelines are used to automate and streamline the software development lifecycle, offering numerous benefits to development teams and organizations such as:
1) **Faster time to deployment**, and in turn market - by automating the process of building, testing, and deploying software, we can enable the faster delivery updates to customers and end-users.
2) **Higher quality code** - CICD enforces best practices such as code review, comprehensive testing, and code analysis as part of the development process.
3) **Reduced Risk** - continuous delivery automates the deployment process, making releases more predictable, repeatable, and less error-prone. This reduces the risk associated with manual deployments and large, infrequent releases. 
4) **Continuous Feedback and Improvement** - CICD pipelines provide real-time feedback on the health and quality of the software through automated testing, code analysis, and deployment metrics. This feedback loop enables teams to identify areas for improvement, prioritize work effectively, and iterate rapidly, leading to continuous improvement in software delivery practices and outcomes.


![CICD example pipline](./images/cicd_diagram.png)


## Github as part of a CICD pipline

As well as providing a central repository for our code, Github can be incorported into CICD pipelines.

We can set up events on Github, such as code pushes, or merges to a specific branch, to trigger a webhook notification for something in the CICD system,(such as Jenkins, GitLab CI, or GitHub Actions).

Results of actions in the CICD system, such as the results of automatef tests, can be reported back to and stored in Github.  

## Jenkins

Jenkins is an open-source automation server for implmeneting CICD. It  can automate SDLC processes, such as building and testing code and deploying applications.

A Jenkins server is configured to the teams requirements. When it is triggered by a webhook it will then launch **nodes** to complete key tasks. 

### Jenkins nodes

Jenkins nodes are the machines (or virtual machines) that Jenkins uses to execute build and deployment tasks. Nodes can be configured with different operating systems, software configurations, and environments to accommodate various types of builds and tests. 

Jenkins nodes distribute workloads across multiple machines, such as testing and building, which helps in parallelizing builds and improving efficiency.

Jenkins **agent nodes** connect to A Jenkins **master server** and receive instructions on what jobs to execute. They then report back to the master with the results of their tasks. Such tasks include building, testing, and deploying software. 

A Jenkins **master node** is the primary Jenkins server instance responsible for managing and coordinating the entire Jenkins environment. It's where all the configurations, job definitions, plugins, and other settings are stored. The master node schedules and delegates tasks to the connected Jenkins slave nodes for execution.

## Building our cloud VM instance with CICD

Jenkins can be configured to trigger the deployment of your application to a cloud virtual machine (VM) after it has passed automated tests. This process is often part of a CI/CD (Continuous Integration/Continuous Delivery) pipeline.

We typically want to our virtual machine before deployment. This allows us to ensure  consistency, reliability, security, and scalability of your deployment process, leading to more robust and efficient application delivery for our end users.

## Guide to creating a job on Jenkins master server

1) Choose create item from the main page, enter a name and then *freestyle project*
2) Add a description, select the Github project checkbox and then add the project url. Example: `git@github.com:Ziziou91/tech258_cicd.git`
3) Under *Office 365 Connector* check the option for *Rescrict where this project can be run* and under Label Expression enter `sparta-ubuntu-node`
![Jenkin job creation step 1](./images/steps/step_1.png)
4) Under *Source Code Management* select Git. Then add the repository URL. Because we have SSH set up on the repo we are provided with a message that tells us Jenkins failed to connect to the repo.
5) We fix this by adding the private SSH key for the repo to our Jenkins, and then choose the credential from the dropdown
![Jenkin job creation step 2](./images/steps/step_2.png)
6) We need to provide Node and npm for our application. Under *Build Environment* check Provide Node & npm bin/ folder to PATH. We then specify the Node installation as `Sparta-Node-JS`
7) Under *Build* choose execute shell and then add the follow commands
   ```shell
   cd
   npm install
   npm test
   ``` 
![Jenkins job creation step 3](./images/steps/step_3.png)
8) Save. Our Jenkins Master node should now be setup to build from our github repo.
9) We can also setup our Jenkins master node to automatically build our app and test it on an agent node when triggered by a webhook on our github repo. 
10) Go to the github repo, settings and then webhooks. Under payload URL rnter the url for the jenkins server and append it as so: `http://3.9.14.9:8080/github-webhook/`
11) For content type choose `application/json`, speifcy the type of event that will trigger the webhook and then set it to active.
12) The Webhook will send a POST HTTP request to our jenkins server and provide us with a 200 status code if it's setup correctly
![Jenkins job creation step 4](./images/steps/step_4.png)
13) Finally, back on the jenkins config page for our job, under *Build Triggers* check GitHub hook trigger for GITScm polling.
![Jenkins job creation step 5](./images/steps/step_5.png)
 
Now test the trigger!


## CI testing with tech221 from localhost to Jenkins 
## Github ssh set up
### Testing Jenkins CI
### Staging 1
### Webhooks testing
![](images/CICD.png)
- Testing CI with Github & Jenkins for tech230 test 100
- testing CI with webook
- new webhook added


- CD
```
rsync -avz -e "ssh -o StrictHostKeyChecking=no" app ubuntu@ip:/home/ubuntu
rsync -avz -e "ssh -o StrictHostKeyChecking=no" environment ubuntu@ip:/home/ubuntu
ssh -o "StrictHostKeyChecking=no" ubuntu@ip <<EOF
	sudo bash ./environment/aap/provision.sh
    sudo bash ./environment/db/provision.sh
    cd app
    pm2 kill
    pm2 start app.js
EOF
```
                                                  
