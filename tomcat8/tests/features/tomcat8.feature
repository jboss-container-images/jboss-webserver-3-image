@jboss-webserver-3/webserver31-tomcat8
Feature: Standalone Tomcat8 tests

  Scenario: Check that Tomcat stats in container in a expected way
    When container is ready
    Then check that page is served
         | property | value |
         | port     | 8080  |
         | expected_phrase | If you're seeing this, you've successfully installed Tomcat. Congratulations! |
      And container log should contain INFO [main] org.apache.catalina.startup.Catalina.start Server startup in
      And container log should contain INFO [main] org.apache.coyote.AbstractProtocol.start Starting ProtocolHandler ["http-apr-8080"]

  Scenario: Check that AJP port is disabled
     When container is ready
     Then container log should contain Server startup in
      And available container log should not contain INFO [main] org.apache.coyote.AbstractProtocol.start Starting ProtocolHandler ["ajp-apr-8009"]

  @ci
  Scenario: Check that the Tomcat 8 image contains 5 layers
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
      | variable       | value  |
      | TOMCAT_VERSION | 8.0.36 |
    Then check that port 8080 is open