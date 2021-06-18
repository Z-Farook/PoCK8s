Feature: Apply a HorizontalPodAutoscaler 
    SR-5 and SR-6
    To automatically scale resources, such as replication controller, deployment, replica set or 
    stateful set based on observed CPU utilization, we need to apply a HPA to the resource that we want to autoscale.

    Background:
        We want to autoscale a deployment.
        The user must meet some pre-conditions like cluster setup and login credentials.
        Given a working cluster already exists
        And the user has login credentials
        And the user is allowed to create a HorizontalPodAutoscaler
    
    Scenario: Jan creates a HorizontalPodAutoscaler for deployment
    Given Jan is already logged in
    And has already defined HorizontalPodAutoscaler named 'Stalin' 
    And has already defined deployment named 'Pivot-super-sonic' 
    And if the resource (deployment) for which he is trying to create the HPA "has defined" resource requests e.g. for CPU
    And deploys the deployment (example: "kubectl apply -f <path to the definition file>")
    And sends some traffic that hits the threshold value 
    When views the HPA (example "kubectl get hpa") 
    Then sees a change under columns: "TARGET    MINPODS   MAXPODS" in the output (e.g. from Kubectl)
    But should not see the same output as before sending the traffic to the pod