Feature: Selecting a right node for a resource to be created/schedueld
    R9 and R14
    K8s's scheduler is pretty good at automatically placing the application pods over the available node, however, in some circumstances, 
    we want to be in charge to decide which "Node" is going to "host a particular pod". For this controlling desire, we should label our Node 
    and then use "nodeSelector" in the pod's spec to ensure the placement as we please.

    Background:
        We want a specific node for a resource to be hosted.
        The user must meet some pre-conditions like cluster setup and login credentials.
        Given a working cluster already exists
        And the user has login credentials
        And the user is allowed to create a resource like a Pod
    
    Scenario: Remco wants to run a pod named 'real-good' on the Node Pivot-europe-node
    Given Remco is already logged in
    And has the right to deploy a pod
    And has access to the Node 'Pivot-europe-node' and the node also has key-value pair for instance, 'my-handsome-node-key='my-handsome-value'
    And in pod's spec Remco uses nodeSelector like: 'nodeSelector': 'my-handsome-node-key='my-handsome-value'
    When deploys the pod (example: 'kubectl apply -f <path to the definition file>')
    Then sees "a success" message for pod creation (e.g. from Kubectl)
    But should not see a pod creation error (e.g. from Kubectl)

    Scenario: Remco wants to see if his pod named 'real-good' is scheduled on the 'Pivot-europe-node' node
    Given Remco is already logged in
    And has the right to list pods 
    And has access to the Node 'Pivot-europe-node'
    When views the pod (example: 'kubectl get pods -n <the-namespace-name> -o wide')
    Then in the command's output under columns "NAME | NODE" Remco sees "real-good | Pivot-europe-node"
    But under columns "NAME | NODE", Remco, should not see "real-good | some-other-node-name"