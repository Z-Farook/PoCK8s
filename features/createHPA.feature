Feature: Create a HorizontalPodAutoscaler with scaleTargetRef, minReplicas and maxReplica
    R7
    To autoscale resources dynamically, HPA needs to have minReplicas and maxReplicas, such as for Pod, so that the K8s does not
    keep creating pods or kill all of them. In addition, a threshold value, scaleTargetRef, is necessary to ensure that K8s will trigger adding or removing new resources, like Pods, 
    between minReplicas and maxReplicas appropriately.

    Background:
        We want to create a HPA.
        The user must meet some pre-conditions like cluster setup and login credentials.
        Given a working cluster already exists
        And the user has login credentials
        And the user is allowed to create a HorizontalPodAutoscaler
    
    Scenario: Piet create a HorizontalPodAutoscaler 
    Given Piet is already logged in
    And has the right to perform a HorizontalPodAutoscaler creation
    And defines a HorizontalPodAutoscaler named Stalin (e.g. in yaml file under spec field: 'minReplicas: 1 maxReplicas: 10 targetCPUUtilizationPercentage: 50')
    When tries to create a HPA (example: "kubectl apply -f <path to the definition file>")
    Then sees "a success" message for a HPA creation (e.g. from Kubectl)
    But Piet should not see a creation error (e.g. from Kubectl)
