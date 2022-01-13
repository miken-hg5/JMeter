pipeline {
   agent any
    options {
      buildDiscarder(logRotator(numToKeepStr:'30'))
      timeout(time: 2, unit: 'MINUTES')
      timestamps()
    }   
    environment{
        EXPECTED_RESULT = 'Running'
    }
   stages {
      stage('Pull code from Repo') {
         steps {
            echo 'Pull the ps1 code from the Repo'
            cleanWs()
            git credentialsId: 'github-pat', url: 'https://github.com/miken-hg5/JMeter'             
         }
      }
      stage('Execute JMeter') {
          steps {
            echo 'JMeter command line syntax'
            bat 'set OUT=jmeter.save.saveservice.output_format'
            bat 'set JMX=DVLA_Lookup.jmx'
            bat 'set JTL=DVLA_Lookup.report.jtl'
            bat 'set'
            bat 'C:\\apache-jmeter-5.4\\bin\\jmeter -j jmeter.save.saveservice.output_format=xml -n -t DVLA_Lookup.jmx -l DVLA_Lookup.report.jtl'            
            //bat 'jmeter -n –t ${WORKSPACE}\\ -l testresults.jtl'
      }
      }
      stage('Grab Report output') {
          steps {
            echo 'Grab Report'
      }
      }      
   }
    post 
    {
        success 
        {
            archiveArtifacts artifacts: "*.jtl", onlyIfSuccessful: true
            powershell('write-host "Archived"')
        }
    }      
}
