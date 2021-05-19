Feature: Access control with Namespaces
    R2
    We need to prevent tenants from sneaking into a restricted environment, resources, and their actions in an environment.

    Background:
        The user must only have access to a cluster area for which he has permissions and the same applies to his action in the cluster.
        The user must meet some pre-conditions like cluster setup and login credentials.
        Given a working cluster already exists
        And the user has login credentials
        And the user does or does not have the right to create the desired resources
    
    Scenario: John Doe creates a Pod (pod is example resources here)
    Given John Doe is already logged in
    And does not have the right to perform a Pod creation
    When tries to create a Pod 'Panda'
    Then John Doe 'does not' see a success message for a pod creation (e.g. from Kubectl)
    
    Scenario: John Doe delete a Pod (pod is example resources here)
    Given John Doe is already logged in
    And does not have the right to perform a Pod deletion
    When tries to delete a Pod 'Panda'
    Then John Doe 'does not' see a success message for pod deletion (e.g. from Kubectl) 
    
    Scenario: John Doe create a service (service is example resources here)
    Given John Doe is already logged in
    And has the right to create a service
    When tries to create a service 'Panda'
    Then John Doe 'does see' a success message for service creation (e.g. from Kubectl) 
    But 'does not' see a error message for service creation (e.g. from Kubectl)