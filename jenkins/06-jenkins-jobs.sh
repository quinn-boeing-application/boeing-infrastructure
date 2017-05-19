#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

JENKINS_HOME="/var/lib/jenkins"


# create "test" job

mkdir -p "$JENKINS_HOME/jobs/test/builds"

cat > "$JENKINS_HOME/jobs/test/config.xml" <<"EOF"
<?xml version='1.0' encoding='UTF-8'?>
<project>
  <actions/>
  <description>runs after commits to https://github.com/quinn-boeing-application/boeing-service&#xd;
&#xd;
- pulls latest commits&#xd;
- runs mocha tests</description>
  <keepDependencies>false</keepDependencies>
  <properties>
    <hudson.model.ParametersDefinitionProperty>
      <parameterDefinitions>
        <hudson.model.StringParameterDefinition>
          <name>BRANCH</name>
          <description>used to specify which branch to run tests against</description>
          <defaultValue>master</defaultValue>
        </hudson.model.StringParameterDefinition>
      </parameterDefinitions>
    </hudson.model.ParametersDefinitionProperty>
  </properties>
  <scm class="hudson.plugins.git.GitSCM" plugin="git@3.3.0">
    <configVersion>2</configVersion>
    <userRemoteConfigs>
      <hudson.plugins.git.UserRemoteConfig>
        <url>https://github.com/quinn-boeing-application/boeing-service/</url>
      </hudson.plugins.git.UserRemoteConfig>
    </userRemoteConfigs>
    <branches>
      <hudson.plugins.git.BranchSpec>
        <name>*/${BRANCH}</name>
      </hudson.plugins.git.BranchSpec>
    </branches>
    <doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
    <submoduleCfg class="list"/>
    <extensions/>
  </scm>
  <canRoam>true</canRoam>
  <disabled>false</disabled>
  <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
  <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
  <triggers>
    <hudson.triggers.SCMTrigger>
      <spec>H/10 * * * *</spec>
      <ignorePostCommitHooks>false</ignorePostCommitHooks>
    </hudson.triggers.SCMTrigger>
  </triggers>
  <concurrentBuild>false</concurrentBuild>
  <builders>
    <hudson.tasks.Shell>
      <command>pm2 delete all || true
pm2 start index.js
npm test</command>
    </hudson.tasks.Shell>
  </builders>
  <publishers/>
  <buildWrappers/>
</project>
EOF

cd "$JENKINS_HOME/jobs/test/builds"
ln -s -- -1 lastFailedBuild
ln -s -- -1 lastStableBuild
ln -s -- -1 lastSuccessfulBuild
ln -s -- -1 lastUnstableBuild
ln -s -- -1 lastUnsuccessfulBuild
touch legacyIds


# create "build" job

mkdir -p "$JENKINS_HOME/jobs/build/builds"

cat > "$JENKINS_HOME/jobs/build/config.xml" <<"EOF"
<?xml version='1.0' encoding='UTF-8'?>
<project>
  <actions/>
  <description>builds a container to be deployed to dev, test, demo, or production environments</description>
  <keepDependencies>false</keepDependencies>
  <properties>
    <hudson.plugins.copyartifact.CopyArtifactPermissionProperty plugin="copyartifact@1.38.1">
      <projectNameList>
        <string>deploy</string>
      </projectNameList>
    </hudson.plugins.copyartifact.CopyArtifactPermissionProperty>
    <hudson.model.ParametersDefinitionProperty>
      <parameterDefinitions>
        <hudson.model.StringParameterDefinition>
          <name>BRANCH</name>
          <description>used to specify which branch to build a container from</description>
          <defaultValue>master</defaultValue>
        </hudson.model.StringParameterDefinition>
      </parameterDefinitions>
    </hudson.model.ParametersDefinitionProperty>
  </properties>
  <scm class="hudson.plugins.git.GitSCM" plugin="git@3.3.0">
    <configVersion>2</configVersion>
    <userRemoteConfigs>
      <hudson.plugins.git.UserRemoteConfig>
        <url>https://github.com/quinn-boeing-application/boeing-service/</url>
      </hudson.plugins.git.UserRemoteConfig>
    </userRemoteConfigs>
    <branches>
      <hudson.plugins.git.BranchSpec>
        <name>*/${BRANCH}</name>
      </hudson.plugins.git.BranchSpec>
    </branches>
    <doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
    <submoduleCfg class="list"/>
    <extensions/>
  </scm>
  <canRoam>true</canRoam>
  <disabled>false</disabled>
  <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
  <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
  <triggers>
    <jenkins.triggers.ReverseBuildTrigger>
      <spec></spec>
      <upstreamProjects>test, </upstreamProjects>
      <threshold>
        <name>SUCCESS</name>
        <ordinal>0</ordinal>
        <color>BLUE</color>
        <completeBuild>true</completeBuild>
      </threshold>
    </jenkins.triggers.ReverseBuildTrigger>
  </triggers>
  <concurrentBuild>false</concurrentBuild>
  <builders>
    <hudson.tasks.Shell>
      <command>docker rmi helloimage || true
docker build --no-cache -t helloimage .
docker save helloimage &gt; helloimage.tar</command>
    </hudson.tasks.Shell>
  </builders>
  <publishers>
    <hudson.tasks.ArtifactArchiver>
      <artifacts>helloimage.tar</artifacts>
      <allowEmptyArchive>false</allowEmptyArchive>
      <onlyIfSuccessful>false</onlyIfSuccessful>
      <fingerprint>false</fingerprint>
      <defaultExcludes>true</defaultExcludes>
      <caseSensitive>true</caseSensitive>
    </hudson.tasks.ArtifactArchiver>
  </publishers>
  <buildWrappers/>
</project>
EOF

cd "$JENKINS_HOME/jobs/build/builds"
ln -s -- -1 lastFailedBuild
ln -s -- -1 lastStableBuild
ln -s -- -1 lastSuccessfulBuild
ln -s -- -1 lastUnstableBuild
ln -s -- -1 lastUnsuccessfulBuild
touch legacyIds


# create "deploy" job

mkdir -p "$JENKINS_HOME/jobs/deploy/builds"

cat > "$JENKINS_HOME/jobs/deploy/config.xml" <<"EOF"
<?xml version='1.0' encoding='UTF-8'?>
<project>
  <actions/>
  <description>deploys container artifact to docker swarm</description>
  <keepDependencies>false</keepDependencies>
  <properties/>
  <scm class="hudson.scm.NullSCM"/>
  <canRoam>true</canRoam>
  <disabled>false</disabled>
  <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
  <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
  <triggers>
    <jenkins.triggers.ReverseBuildTrigger>
      <spec></spec>
      <upstreamProjects>build, </upstreamProjects>
      <threshold>
        <name>SUCCESS</name>
        <ordinal>0</ordinal>
        <color>BLUE</color>
        <completeBuild>true</completeBuild>
      </threshold>
    </jenkins.triggers.ReverseBuildTrigger>
  </triggers>
  <concurrentBuild>false</concurrentBuild>
  <builders>
    <hudson.plugins.copyartifact.CopyArtifact plugin="copyartifact@1.38.1">
      <project>build</project>
      <filter>helloimage.tar</filter>
      <target></target>
      <excludes></excludes>
      <selector class="hudson.plugins.copyartifact.StatusBuildSelector">
        <stable>true</stable>
      </selector>
      <doNotFingerprintArtifacts>false</doNotFingerprintArtifacts>
    </hudson.plugins.copyartifact.CopyArtifact>
    <hudson.tasks.Shell>
      <command>rm /var/lib/jenkins/.ssh/known_hosts || true

if [ ! -f /var/lib/jenkins/.ssh/known_hosts ]; then
    ssh-keyscan -H 10.0.0.12 &gt; /var/lib/jenkins/.ssh/known_hosts
fi

scp helloimage.tar ubuntu@10.0.0.12:/tmp/

ssh ubuntu@10.0.0.12 &lt;&lt;EOF
sudo docker load &lt; /tmp/helloimage.tar
sudo docker tag helloimage localhost:5000/helloimage:latest
sudo docker push localhost:5000/helloimage:latest
SERVICES=$(sudo docker service ls --filter name=helloservice --quiet | wc -l)
if [[ &quot;$SERVICES&quot; -eq 0 ]]; then
    sudo docker service create --name helloservice --replicas 3 --update-delay 10s --publish 8888:8888 localhost:5000/helloimage
else
    sudo docker service update --force --image helloimage:latest helloservice
fi
EOF</command>
    </hudson.tasks.Shell>
  </builders>
  <publishers/>
  <buildWrappers/>
</project>
EOF

cd "$JENKINS_HOME/jobs/deploy/builds"
ln -s -- -1 lastFailedBuild
ln -s -- -1 lastStableBuild
ln -s -- -1 lastSuccessfulBuild
ln -s -- -1 lastUnstableBuild
ln -s -- -1 lastUnsuccessfulBuild
touch legacyIds

chown -R jenkins: "$JENKINS_HOME"

service jenkins restart
