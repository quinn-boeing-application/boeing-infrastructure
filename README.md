# Prerequisites

- virtualbox
`apt -y install virtualbox-qt`

- vagrant
`wget https://releases.hashicorp.com/vagrant/1.9.5/vagrant_1.9.5_x86_64.deb; dpkg -i vagrant_1.9.5_x86_64.deb`


# Usage

### Provisioning

`vagrant up`

### Add worker nodes to docker swarm

```
export JOIN_TOKEN=$(vagrant ssh manager1 -c "sudo docker swarm join-token --quiet worker" | tr -d '\r' | tr -d '\n')
export JOIN_COMMAND="sudo docker swarm join --token $JOIN_TOKEN 10.0.0.12:2377"
vagrant ssh worker1 -c "$JOIN_COMMAND"
vagrant ssh worker2 -c "$JOIN_COMMAND"
vagrant ssh workerN -c "$JOIN_COMMAND"
```

# Other Details

- jenkins running @ http://localhost:8080/
  - username: `admin`
  - password: `override`

- nginx ingress running @ http://localhost:8000