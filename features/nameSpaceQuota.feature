Feature: Resource Quotas for Namespace
    R3 and R4
    We must prevent tenants from overusing the resources. This is accomplished by applying resource quotas to a namespace.

    Background:
        If a resource is being launched, it must respect the namespace Quota.
        The user must meet some pre-conditions like cluster setup and login credentials.
        Given a working cluster already exists
        And the user has login credentials
        And the user is allowed to create a resource Quotas
        And the user has defined and applied a resource Quota to a namespace

    Scenario: John Doe creates a Pod (pod is example resources here)
    Given John Doe is already logged in
    And does have the right to perform a pod creation
    And has defined resource 'Limit and Request' for the pod being created
    When tries to create a pod named 'Panda' in a namespace 'XYZ' which has a resource Quotas attached to it
    Then "does see a success" message for pod creation (e.g. from Kubectl)

    Scenario: John Doe creates a Pod (pod is example resources here)
    Given John Doe is already logged in
    And does have the right to perform a pod creation
    And has "not" defined resource 'Limit and Request' for the pod
    When tries to create a Pod named 'shark' in a namespace 'XYZ' which has a resource Quotas attached to it
    Then "does not see a success" message for pod creation (e.g. from Kubectl)

    Scenario: John Doe creates a Pod (pod is example resources here)
    Given John Doe is already logged in
    And does have the right to perform a pod creation
    And has "not" defined resource 'Limit' for the pod
    When tries to create a pod named 'goldFish' in a namespace 'XYZ' which has a resource Quotas attached to it
    Then "does not see a success" message for pod creation (e.g. from Kubectl)

    Scenario: John Doe creates a Pod (pod is example resources here)
    Given John Doe is already logged in
    And does have the right to perform a pod creation
    And has "not" defined resource 'Request' for the pod
    When tries to create a pod named 'elephant' in a namespace 'XYZ' which has a resource Quotas attached to it
    Then "does see a success" message a pod creation (e.g. from Kubectl)
