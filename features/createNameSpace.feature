Feature: Create a Namespace
    R1
    We need to isolate tenants to do that we must have a Namespace(s). 

    Background:
        We want to create a namespace.
        The user must meet some pre-conditions like cluster setup and login credentials.
        Given a working cluster already exists
        And the user has login credentials
        And the user is allowed to create a Namespace
    
    Scenario: John Doe create a Namespace
    Given John Doe is already logged in
    And has the right to perform a Namespace creation
    When tries to create a Namespace panda
    Then sees a success 'namespace/Panda created' (e.g. from Kubectl)
    But should not see a creation error (e.g. from Kubectl)
