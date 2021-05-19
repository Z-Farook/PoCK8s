Feature: Consistent Pod availability using ReplicaSet  
    R10 and R11
    As we will be dealing with dynamic resource management, it is important that there is always a stable number
    of pods (identical replicas) are running to ensure a certain (least) availability at any given time. A ReplicaSet is 
    configured with 'fields' along with a 'selector or matchExpressions' that describe how the pod to be replicated will be determined. K8s stresses 
    that we should use a Deployment instead of directly using ReplicaSet because it allows updating Pods and ReplicaSets declaratively.

    Background:
        We want to have X number of pods running at any given time.
        The user must meet some pre-conditions like cluster setup and login credentials.
        Given a working cluster already exists
        And the user has login credentials
        And the user is allowed to create a Deployment
    
    Scenario: Marian creates a deployment with pod's replicas set to 3
    Given Marian is already logged in
    And has the right to create a deployment 
    And defines her desired number of "replicas" (3 in this case) under Deployment's "spec" along with "selector or matchExpressions" for pod selection
    And defines "container spec" and saves the file
    When deploys the deployment (example: "kubectl apply -f <path to the definition file>")
    Then sees "a success" message for deployment creation (e.g. from Kubectl)
    But should not see a creation error (e.g. from Kubectl)

    Scenario: Marian views the created deployment above
    Given Marian is already logged in
    And has the right to list deployments
    When views the deployment (example: "kubectl describe deployment <my-cool-deployment-name>")
    Then in the command's output under columns "NAME |  READY" Marian sees "the-deployment-name | 3"
    But under columns "READY", Marian, should not see a number '<' or '>' 3