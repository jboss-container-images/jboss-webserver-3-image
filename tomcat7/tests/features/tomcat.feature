@jboss-webserver-3/webserver30-tomcat7
Feature: Standalone Tomcat tests

  Scenario: Check labels in Tomcat image
    Given image is built
    Then the image should contain label name with value jboss-webserver-3/webserver30-tomcat7
     And the image should contain label com.redhat.component with value jboss-webserver-3-webserver30-tomcat7-docker
     And the image should contain label org.jboss.deployments-dir with value /opt/webserver/webapps
     And the image should contain label com.redhat.deployments-dir with value /opt/webserver/webapps
     And the image should contain label com.redhat.dev-mode with value DEBUG:true
     And the image should contain label com.redhat.dev-mode.port with value JPDA_ADDRESS:8000

  Scenario: Check that Tomcat stats in container in a expected way
    When container is ready
    Then check that page is served
         | property | value |
         | port     | 8080  |
         | expected_phrase | If you're seeing this, you've successfully installed Tomcat. Congratulations! |
      And container log should contain INFO: Starting ProtocolHandler ["http-apr-8080"]
      And container log should contain INFO: Server startup in

  Scenario: Check that AJP port is disabled
     When container is ready
     Then container log should contain Server startup in
      And available container log should not contain INFO [main] org.apache.coyote.AbstractProtocol.start Starting ProtocolHandler ["ajp-apr-8009"]

  @ci
  Scenario: Check that the Tomcat image contains 5 layers
    Given image is built
     Then image should contain 5 layers

  # https://issues.jboss.org/browse/CLOUD-243
  Scenario: Check debug port is available
    When container is started with env
     | variable | value |
     | DEBUG    | true  |
    Then check that port 8000 is open

  # https://issues.jboss.org/browse/CLOUD-243
  Scenario: Check custom debug port is available
    When container is started with env
     | variable     | value |
     | DEBUG        | true  |
     | JPDA_ADDRESS | 8798  |
    Then check that port 8798 is open

  # https://issues.jboss.org/browse/CLOUD-1913
  Scenario: Check if TOMCAT_VERSION env var is present
    When container is started with env
     | variable          | value  |
     | TOMCAT_VERSION    | 7.0.59 |
    Then check that port 8080 is open