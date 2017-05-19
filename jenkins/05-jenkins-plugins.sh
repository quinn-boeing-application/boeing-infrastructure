#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

CREDENTIALS="admin:override"
JENKINS_JAR_PATH="/var/cache/jenkins/war/WEB-INF/jenkins-cli.jar"
JENKINS_URL="http://127.0.0.1:8080/"

jenkins-ready() {
    java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" help 2>/dev/null >/dev/null
    return $?
}

update-center-data-ready() {
    java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin ace-editor 2>/dev/null >/dev/null
}

until jenkins-ready
do
    echo "Waiting for jenkins to be ready"
    sleep 2
done

until update-center-data-ready
do
    echo "Waiting for update center data to be downloaded"
    sleep 2
done

java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin ace-editor
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin ant
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin antisamy-markup-formatter
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin authentication-tokens
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin bouncycastle-api
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin branch-api
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin build-timeout
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin cloudbees-folder
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin conditional-buildstep
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin copyartifact
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin credentials-binding
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin credentials
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin display-url-api
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin docker-commons
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin docker-workflow
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin durable-task
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin external-monitor-job
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin git-client
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin git-server
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin git
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin github-api
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin github
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin handlebars
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin icon-shim
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin javadoc
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin jquery-detached
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin junit
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin ldap
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin mailer
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin matrix-auth
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin matrix-project
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin maven-plugin
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin momentjs
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin pam-auth
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin pipeline-build-step
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin pipeline-graph-analysis
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin pipeline-input-step
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin pipeline-milestone-step
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin pipeline-model-api
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin pipeline-model-declarative-agent
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin pipeline-model-definition
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin pipeline-model-extensions
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin pipeline-rest-api
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin pipeline-stage-step
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin pipeline-stage-tags-metadata
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin pipeline-stage-view
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin plain-credentials
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin resource-disposer
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin run-condition
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin scm-api
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin script-security
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin ssh-credentials
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin structs
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin token-macro
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin windows-slaves
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin workflow-aggregator
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin workflow-api
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin workflow-basic-steps
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin workflow-cps-global-lib
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin workflow-cps
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin workflow-durable-task-step
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin workflow-job
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin workflow-multibranch
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin workflow-scm-step
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin workflow-step-api
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin workflow-support
java -jar "$JENKINS_JAR_PATH" -s "$JENKINS_URL" -auth "$CREDENTIALS" install-plugin ws-cleanup

service jenkins restart
