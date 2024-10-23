# hackathon-starter CI & CDep Pipeline

## Design

### CI Pipeline
```
..................     ..................     ..................     .....................
|  Checkout SCM  | --> |    Unit Test   | --> |    Dockerize   | --> | Docker image scan |
''''''''''''''''''     ''''''''''''''''''     ''''''''''''''''''     '''''''''''''''''''''
```

### Trigger
|   Event   |   Action   |
|---|---|
|  Push on master  |  Build & scan corresponding commit |

### Tech-stack
| Tech | Purpose | Why should we use it? |
|---|---|---|
| GoGs | SCM | Lightweight, for testing/lab purpose |
| Jenkins | CI | Popular tool for CI |
| Trivy   | Docker image scanning | Open Source, lightweight |

## Implementation
### Setup guides
#### Setup git repository
1. Init GoGs (only the first time run)
2. Create Jenkins user for integrating with Jenkins
3. Create repository 
4. Init git repository & add remote
5. Publish repo

#### Setup integration Gogs <--> Jenkins for job trigger
6. Setup webhooks for integrating
   
| Item | Value |
|---|---|
| Add a new webhook: | Gogs |
| Payload URL        | http://jenkins-controller:8080/gogs-webhook/?job=hackathon-starter |
| Content Type       | application/json |
| Secret             | gogs             |
| When should this webhook be triggered? | Just the push event |


### User guide
#### WHEN: Verify your code changes
1. Commit change and push to the configured remote repository on GoGs
2. Login to Jenkins, navigate to job `duong.buivan/hackathon-starter`
3. Enjoy a cup of coffee and wait for the pipeline execution
4. See the status of pipeline

#### WHEN: You want to update the pipeline
1. Applying changes to `./Jenkinsfile`
2. Commit change and push to the configured remote repository on GoGs
2. Login to Jenkins, navigate to job `duong.buivan/hackathon-starter`
3. Enjoy a cup of coffee and wait for the pipeline execution
4. See the status of pipeline
