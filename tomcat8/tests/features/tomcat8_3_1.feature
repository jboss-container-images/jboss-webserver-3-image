@webserver_tomcat8_3_1
Feature: Standalone Tomcat 8 3.1 tests

  Scenario: Check labels in Tomcat 8 image
    Given image is built
    Then the image should contain label name with value jboss-webserver-3/webserver31-tomcat8
     And the image should contain label com.redhat.component with value jboss-webserver-3-webserver31-tomcat8-docker
     And the image should contain label org.jboss.deployments-dir with value /opt/webserver/webapps
     And the image should contain label com.redhat.deployments-dir with value /opt/webserver/webapps
     And the image should contain label com.redhat.dev-mode with value DEBUG:true
     And the image should contain label com.redhat.dev-mode.port with value JPDA_ADDRESS:8000

  Scenario: Check that the patched commons-collections jar is installed
    When container is ready
    Then run md5sum /opt/webserver/lib/commons-collections-eap6.jar in container and immediately check its output for 2afb1e6e792d9ff8c6166bee4c2f00e6
