# deploying a website to AWS EC2 Instance using Terraform and Ansible.  

In this project, I used Terraform to provision an EC2 instance and used Ansible to configure it by installing Apache web server and coping my static website to it.

## Pre-requisites

install [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) 

install [Terraform](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwio_JmE1vP3AhXt4IUKHQV6A1oQFnoECAMQAQ&url=https%3A%2F%2Fwww.terraform.io%2Fcli%2Finstall%2Fapt&usg=AOvVaw1vAVVZc0bqi_CgFIuhallb)

AWS Account -- with access key & secret access key.


## Steps
1- create new directory 
```bash
mkdir project_1 && cd project_1
```
2- copy `create_ec2_instance.tf` file to your directory

3- add `access-key` and `secret key` to the file. -- access key and secret access key shouldn't be as plain text in the code but it's done for simplicity.

4- open the terminal and navigate to the directory and initiate teraform by 
```bash
terraform init
```

5- create a key-pair using
 ```bash 
ssh-keygen -f myblog-key
```

6- provision the server with 
 ```bash 
terraform apply
```

* note :  we created a new key-pair and added the public key to the ec2 instance and we will use the private key to connect to the server.

7- check the connection using 
```bash
ssh -i "myblog-key" ubuntu@server-name
```
where myblog-key is the private key which would exist in >  ~/.ssh/myblog-key

* Now, we have our ec2 instance created and ssh, HTTP, HTTPS ports open.
Next, we will configure our web server with ansible.

8- create new directory for ansible
```bash 
mkdir ansible_configure && cd ansible_configure
```
9- add ```inventory.txt``` file into the directory

10- in the inventory.txt file, modify the ansible-host=  {ip}>> with your instance IP and ansible-user with your server user also specify the location of your private key.

11- all ```apache-install.yml``` to your directory

12- create a folder named my-website and add your website files to it.

13- run the ansible playbook ausing
```bash
ansible-playbook apache-install.yml -i inventory.txt
```
14- Now, you can paste your instance IP into the web browser and enjoy your website ONLINE!










