@jboss-webserver-3/webserver31-tomcat7
Feature: Standalone Tomcat7 tests
  Scenario: Check that Tomcat stats in container in a expected way
    When container is ready
    Then check that page is served
         | property | value |
         | port     | 8080  |
         | expected_phrase | If you're seeing this, you've successfully installed Tomcat. Congratulations! |
      And container log should contain INFO: Server startup in
      And container log should contain INFO: Starting ProtocolHandler ["http-apr-8080"]

  Scenario: Check that AJP port is diisabled
     When container is ready
     Then container log should contain INFO: Server startup in
      And available container log should not contain INFO: Starting ProtocolHandler ["ajp-apr-8009"]

  @ci
  Scenario: Check that the jboss-webserver-3/tomcat7 images contains 5 layers
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
