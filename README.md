# Cloud Foundry HTML5 Repository Plugin Docker image

Environment loaded with [Cloud Foundry CLI](https://github.com/cloudfoundry/cli) and [Cloud Foundry HTML5 Repository Plugin](https://sap.github.io/cf-html5-apps-repo-cli-plugin/). Created to allow deployment of static applications to Cloud Foundry in a CI/CD pipeline.

## Usage

`docker run -it lucasheim/cf-html5:1.0`

This command will fire a /bin/sh session on workdir with the Cloud Foundry CLI + Plugin available.

### Jenkins + Piper

If you're using Jenkins + Piper in your pipeline, you can call this image via [`dockerExecute`](https://sap.github.io/jenkins-library/steps/dockerExecute/), like this:

```groovy
  pipeline {
    agent any
    environment {
      CF_API = "https://your.cf.api.com"
      CF_ORG = "yourOrgName"
      CF_SPACE = "yourSpace"
      CF_HTML5_REPO = "html5RepoInstanceName"
    }

    stages {
      stage('Deploy'){
        steps {
          withCredentials([
            string(credentialsId: "CF_USER", variable: 'CF_USER'),
            string(credentialsId: "CF_PASS", variable: 'CF_PASS')
          ]) {
            dockerExecute(script: this, dockerImage: 'lucasheim/cf-html5:1.0') {
              sh """
                cf login -a $CF_API -u $CF_USER -p $CF_PASS -o '$CF_ORG' -s '$CF_SPACE'
                cf html5-push -n $CF_HTML5_REPO build
              """
            }
          } 
        }
      }
    }
  }
```

