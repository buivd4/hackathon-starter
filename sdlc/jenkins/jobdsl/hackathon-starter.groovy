import hudson.util.Secret;

pipelineJob('duong.buivan/hackathon-starter') {
    description('Build on push hackathon-starter project. From Duong.BuiVan with love <3')
    properties {
        gogsProjectProperty {
            gogsSecret(Secret.fromString('gogs'))                
            gogsUsePayload(false)
            gogsBranchFilter('')
        }
        
    }
    triggers {
        gogsTrigger {}
    }
    definition {
        cpsScm {
            scriptPath('Jenkinsfile')
            scm {
                git {
                    remote {
                        url('http://gogs:3000/gogs/hackathon-starter.git')
                        credentials('gogs_int')
                    }
                    branch('*/master')
                }
            }
        }
    }
}