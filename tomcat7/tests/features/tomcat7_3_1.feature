@jboss-webserver-3
Feature: Standalone Tomcat7 3.1 tests
  Scenario: Check labels for Tomcat 7 3.1 image
    Given image is built
    Then the image should contain label name with value jboss-webserver-3/webserver31-tomcat7
     And the image should contain label com.redhat.component with value jboss-webserver-3-webserver31-tomcat7-docker
     And the image should contain label org.jboss.deployments-dir with value /opt/webserver/webapps
     And the image should contain label com.redhat.deployments-dir with value /opt/webserver/webapps
     And the image should contain label com.redhat.dev-mode with value DEBUG:true
     And the image should contain label com.redhat.dev-mode.port with value JPDA_ADDRESS:8000
