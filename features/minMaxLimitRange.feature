Feature: Default resource Min and MAx using 'LimitRange' object
    SR-13
    The use cases found in the file "defaultRequestAndLimit.feature" show how we can define Limit and Request for each pod using LimitRange. LimitRange object
    can also be used to set minimum and maximum resource usage per pod or container in a namespace.

    Background:
        We want a pod called Rain to not exceed minimum and maximum CPU and RAM.
        The user must meet some pre-conditions like cluster setup and login credentials.
        Given a working cluster already exists
        And the user has login credentials
        And the user is allowed to create a LimitRange
    
    Scenario: Lune creates a LimitRange for a Namespace weather
    Given Lune is already logged in
    And creates a Namespace 'weather'
    And creates a limitRange 'hondenweer' with Limits: '- max:' RAM = 1Gb and CPU = 1 and  '- min:' RAM = 0.5Gb and CPU = 0.5
    And applies the LimitRange to namespace 'weather'
    And defines a manifest for the pod 'Rain' WITHOUT breaking the MIN and MAX constraint 
    And deploys the pod (example: "kubectl apply -f <path to the definition file> --namespace=weather")
    When views the namespace LimitRange resource  (example: "kubectl describe namespace weather")
    Then in the command's output under columns "Min  |  Max" Lune sees values as defined during the creation of 'hondenweer' LimitRange
    But Lune should not see different values or 'No LimitRange resource.'

    Scenario: Lune loves to break roles and she tries to break the boundaries of min and/or max field
    Given Lune is already logged in
    And was successful with the scenario above
    And defines a manifest for the pod 'Rain' that BREAKS the MIN and MAX constraint 
    When deploys the pod (example: "kubectl apply -f <path to the definition file> --namespace=weather")
    Then in the command's output within the pod's spec section,  she sees the following: 
         Error from server (Forbidden): error when creating "some text here"
    But Lune should not see 'pod/Rain' created
