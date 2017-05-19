#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

while [ ! -f /var/lib/jenkins/secrets/initialAdminPassword ]
do
    echo "Waiting for jenkins to be ready"
    sleep 2
done

rm /var/lib/jenkins/secrets/initialAdminPassword

usermod -aG docker jenkins

mkdir -p /var/lib/jenkins/.ssh

cat > /var/lib/jenkins/.ssh/id_ed25519 <<EOF
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
QyNTUxOQAAACC3Cp34SN9+8XN18TrmUEyFFhuXNtfvWtBKkOR0WbYWFQAAAJAb9IknG/SJ
JwAAAAtzc2gtZWQyNTUxOQAAACC3Cp34SN9+8XN18TrmUEyFFhuXNtfvWtBKkOR0WbYWFQ
AAAECQ/KDGCv/68SSzkfI3B241GoLiXECpu/nkmvwPvk9YJbcKnfhI337xc3XxOuZQTIUW
G5c21+9a0EqQ5HRZthYVAAAADHF1aW5uQHJhcHRvcgE=
-----END OPENSSH PRIVATE KEY-----
EOF

cat > /var/lib/jenkins/.ssh/id_ed25519.pub <<EOF
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILcKnfhI337xc3XxOuZQTIUWG5c21+9a0EqQ5HRZthYV jenkins@localhost
EOF

chown -R jenkins: /var/lib/jenkins/.ssh
chmod 600 /var/lib/jenkins/.ssh/id_ed25519
chmod 644 /var/lib/jenkins/.ssh/id_ed25519.pub

cat > /var/lib/jenkins/users/admin/config.xml <<"EOF"
<?xml version='1.0' encoding='UTF-8'?>
<user>
  <fullName>Boeing Admin</fullName>
  <properties>
    <jenkins.security.ApiTokenProperty>
      <apiToken>{AQAAABAAAAAw/4x+3+KlBPoX6ZkLjp3ZJyqgiojndKLIHKYJUtH1xFdrEUzJqcuUjPmbeBKsQpmP04UCMML5tbtPU/MA79JSVQ==}</apiToken>
    </jenkins.security.ApiTokenProperty>
    <hudson.model.MyViewsProperty>
      <views>
        <hudson.model.AllView>
          <owner class="hudson.model.MyViewsProperty" reference="../../.."/>
          <name>all</name>
          <filterExecutors>false</filterExecutors>
          <filterQueue>false</filterQueue>
          <properties class="hudson.model.View$PropertyList"/>
        </hudson.model.AllView>
      </views>
    </hudson.model.MyViewsProperty>
    <hudson.model.PaneStatusProperties>
      <collapsed/>
    </hudson.model.PaneStatusProperties>
    <hudson.search.UserSearchProperty>
      <insensitiveSearch>false</insensitiveSearch>
    </hudson.search.UserSearchProperty>
    <hudson.security.HudsonPrivateSecurityRealm_-Details>
      <passwordHash>#jbcrypt:$2a$10$XOFfBMzkBRNXxjCPqC5nCO4pILs3eO/WIxvaMtlIaEEB.i/alTnRa</passwordHash>
    </hudson.security.HudsonPrivateSecurityRealm_-Details>
    <hudson.tasks.Mailer_-UserProperty plugin="mailer@1.20">
      <emailAddress>admin@boeing.ca</emailAddress>
    </hudson.tasks.Mailer_-UserProperty>
  </properties>
</user>
EOF

cat > /var/lib/jenkins/jenkins.install.InstallUtil.lastExecVersion <<EOF
2.46.2
EOF

service jenkins restart
