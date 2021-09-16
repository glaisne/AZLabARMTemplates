Using this deployment will get you to the "meat" of this tutorial:
https://docs.microsoft.com/en-us/azure/virtual-network/tutorial-restrict-network-access-to-resources


[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fglaisne%2FAZLabARMTemplates%2Fmain%2FStorageAccountEndpoint%2FDeploy.Template.json)

Image built with PowerShell module [AzViz](https://github.com/PrateekKumarSingh/AzViz)
![TemplateResult](https://user-images.githubusercontent.com/3585145/117006239-2f265a00-acb6-11eb-9de6-256a065e8bab.png)

Create your own 'Deploy to Azure' button: https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/deploy-to-azure-button


#Labs for this deployment
##Create a Service Endpoint for an Azure Storage Account
Process:
1. confirm the following:
    a. There is One Virtual Network ('myVirtualNetwork')
    b. The VNet has two subnets. ('public' & 'private')
    c. There are two VMs ('myVmPublic' & 'myVmPrivate')
    d. myVmPublic's Nic is connected to the 'public' subnet.
    e. myVmPrivate's Nic is connected to the 'private' subnet.
    f. myVMPublic's Nic has an NSG attached to it ('myVMPublic-nsg')
    g. myVMPublic-nsg has the following rule:
        1. Allow-RDP:  Source: Any, Destination: Any, Port: 3389, Protocol: Tcp, Action: Allow
    f. myVMPrivate's Nic has an NSG attached to it ('myVMPrivate-nsg')
    g. myVMPrivate-nsg has the following rule:
        1. Deny-All-Inbound:  Source: Any, Destination: Any, Port: Any, Protocol: Any, Action: Deny
    h. Both the 'public' and 'private' VMs are running.
    i. There is a storage account.
2. Open the VNet properties ('myVirtualNetwork') and go to Settings->Subnets
3. click on the 'private' subnet, under the subnet **SERVICE ENDPOINTS**, click the drop-down for Services and add **Microsoft.Storage**.
4. Click **Save**.
5. Open the properties for the subnet NSG (myNSGPrivate), Under Settings, using the 'Inbound security rules' and 'Outbound security rule' links, add these rules:
    a. Name: 'Allow-Storage-All', Direction: outbound, Port: 8080, Protocol: Any, Source: Virtual Network, Destination: Storage, Action: Allow, Priority: 100
    b. Name: 'Deny-Internet-All', Direction: outbound, Port: Any, Protocol: Any, Source: Virtual Network, Destination: Internet, Action: Deny, Priority: 110
    c. Name: 'Allow-RDP-Me', Direction: inbound, Port: 3389, Protocol: Any, Source: (You'r IP as a CIDR), Destination: VirtualNetwork, Action: Allow, Priority: 120
6. Under Settings, select Subnets and attach the NSG to the 'private' subnet.
