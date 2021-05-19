Feature: Virtual cluster creation
    R8
    There should be one large cluster instead of many small for each tenant. For the PoC, 
    we buy a cluster with +- 4 CPU and 4Gb of RAM that has an imaginary cost, 100 dollars.
    
    Background: 
       Having one large cluster is operational and more cost-effective as we can distribute/create small 
       virtual chunks of a large one through namespaces as needed.
       The user must meet some pre-conditions like cluster setup and login credentials.
        Given CGI has 4CPU and 4Gb of RAM resources
        And the user has access to the cluster
        And the user is logged in 
        And the user has created a Namespaces 'dolphin' 
        And the user is allowed to divide the cluster (creat a namespace/virtual cluster)

    Scenario: Peter creates a virtual cluster with 2 CPUs and 2Gb RAM
        Given the 'Background' above is met
        And Peter has created a resource Quota named 'the-medium-quota'
        When he applies the quota to the namespace 'dolphin'
        Then he gets a virtual cluster, 'dolphin' namespace, that is 2 CPUs and 2Gb RAM big

    Scenario: Ramon found a new customer for Pivot and so he needs a new cluster
        Given the 'Background' above is met
        And Ramon asks Zahid and Ernesto to create a resource Quota that pleases the new customer
        And they create a new namespace 'shall-gas'
        And they create Quota named 'the-shell-quota' for Shell with 1 CPUs and 1Gb RAM
        When they apply the 'the-shell-quota' quota to the namespace 'shall-gas'
        Then he gets a new virtual cluster 'shall-gas' that is 1 CPUs and 1Gb RAM big

//Note: We still have 1 CPUs and 1Gb RAM that can be used for a new tenant.