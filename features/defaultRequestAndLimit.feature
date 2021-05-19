Feature: Default resource Request and Limit using 'LimitRange' object
    R12
    Applying resource Quota to a namespace obliges us to define Requests and Limits for resources to be placed in it. This can get repetitive if more than a few 
    objects are to be created and require the same amount of resources. To avoid this mundane, K8s provides the "LimitRange" object to set the default amount of
    resourcess, such as CPU and RAM,  to be applied to objects placed in a namespace if nothing is specified in their manifest files.

    Background:
        We want a pod called Rain to get a default CPU and RAM amount.
        The user must meet some pre-conditions like cluster setup and login credentials.
        Given a working cluster already exists
        And the user has login credentials
        And the user is allowed to create a LimitRange
    
    Scenario: Iris creates a LimitRange for a Namespace weather
    Given Iris is already logged in
    And creates a Namespace 'weather'
    And creates a limitRange 'hondenweer' with resource 'Limit:' RAM = 1Gb and CPU = 1 and 'Request:' RAM = 0.5Gb and CPU = 0.5
    And applies the LimitRange to namespace 'weather'
    And Iris defines a manifest for the pod 'Rain' WITHOUT defining resource allocation for this pod
    And deploys the pod (example: "kubectl apply -f <path to the definition file> --namespace=weather")
    When views the namespace resource quota (example: "kubectl describe namespace weather")
    Then in the command's output under columns "Default Request | Default Limit" Iris sees "  0.5Gb   0.5 | 1Gb     1"
    But under columns "Default Request | Default Limit", Iris, should not see values different than " 0.5Gb   0.5 | 1Gb     1" or "No resource quota"

    Scenario: Iris views the manifest of the created pod to see if the defaults values were applied
    Given Iris is already logged in
    And was successful with the scenario above
    When Iris views the pod (e.g. "kubectl get pod Rain --output=yaml --namespace=hondenweer")
    Then in the command's output, she should see something like:
         limits:
             memory: 1Gb
             cpu: 1
           requests:
             memory: 0.5Gb
             cpu: 0.5
    But should not see different values
