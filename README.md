# ResourceManagerVM

**Overview**

This is the **Vagrant** environment coupled with a **Puppet** provisioning that will spin up a **VM** and install and deploy the **ResourceManager** project on it, ready for use. 

**Requirements**

In order to use this Vagrant environment, you need to install the latest *VirtualBox* and *Vagrant*. 

**Usage**

Once all the requirements satisfied, clone or download this git project and go into the directory where it is to run: 
```
vagrant up
```
It could take at least 30 minutes for the VM to be provisioned (due to the maven build and TomEE download) depending on your machine’s power and Internet connection.

Once the VM is up, you can use the ResourceManager services through _http://localhost:8081_. For example, you can directly take a look in your browser at this address: 
[http://admin:admin@localhost:8081/ResourceManager/rest/resources/](http://admin:admin@localhost:8081/ResourceManager/rest/resources/)

See the _ResourceManager_ manual page for more details about how to use it.

**Reference**

When you _up_ Vagrant, it will provision the VM with Puppet. Puppet will install _openjdk, git, maven and mysql_. TomEE is downloaded and to be extracted. We clone the ResourceManager git repo and build it with maven. The resulting war will be deployed in TomEE. 

We then add a database and user in MySQL and the corresponding data resource file in TomEE as well as a freshly downloaded mysql connector jar. 
We also add two users to the TomEE authentication. 
