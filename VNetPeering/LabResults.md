[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fglaisne%2FAZLabARMTemplates%2Fmain%2FVNetPeering%2FDeploy.Template.json)

Current status: 
 * Deployable and working.
 * Lab outlines and tests working

Needed:
 * Instructions for Gateway testing
 * instructions for forwarding testing

Image built with PowerShell module [AzViz](https://github.com/PrateekKumarSingh/AzViz)
![output](https://user-images.githubusercontent.com/3585145/134034045-51930d6d-3b02-412d-9a00-2cabe8dfb6ff.png)


# Labs
## LAB 1a Peer A to B
### This virtual network (A)
Traffic to remote virtual network: `Allow (default)
Traffic forwarded from remote virtual network: Block traffic that originates from outside this virtual network
Virtual network gateway or Route Server: None (default)
### Remote virtual network (B)
Traffic to remote virtual network: Allow (default)
Traffic forwarded from remote virtual network: Block traffic that originates from outside this virtual network
Virtual network gateway or Route Server: None (default)

test:
A to B: Good
B to A: Good
B to C: X
C to B: X
A to C: X
C to A: X

### Lab 1b Break traffic from B to A
### A--B: This virtual network (A)
Traffic to remote virtual network: `Allow (default)
Traffic forwarded from remote virtual network: Block traffic that originates from outside this virtual network
Virtual network gateway or Route Server: None (default)
### B--A: Remote virtual network (B)
Traffic to remote virtual network: Block all traffic to the remote virtual network
Traffic forwarded from remote virtual network: Block traffic that originates from outside this virtual network
Virtual network gateway or Route Server: None (default)

test:
A to B: Good
B to A: X
B to C: X
C to B: X
A to C: X
C to A: X

## LAB 2a Peer B to C
### B--A: Enable B to A traffic
Traffic to remote virtual network: `Allow (default)
Traffic forwarded from remote virtual network: Block traffic that originates from outside this virtual network
Virtual network gateway or Route Server: None (default)
### B--C: This virtual network (B)
Traffic to remote virtual network: `Allow (default)
Traffic forwarded from remote virtual network: Block traffic that originates from outside this virtual network
Virtual network gateway or Route Server: None (default)
### C--B: Remote virtual network (C)
Traffic to remote virtual network: Allow (default)
Traffic forwarded from remote virtual network: Block traffic that originates from outside this virtual network
Virtual network gateway or Route Server: None (default)

test:
A to B: Good
B to A: Good
B to C: Good
C to B: Good
A to C: X
C to A: X

### Lab 2b Break traffic from B to C
### B--C: Break traffic from B to C
Traffic to remote virtual network: Block all traffic to the remote virtual network
Traffic forwarded from remote virtual network: Block traffic that originates from outside this virtual network
Virtual network gateway or Route Server: None (default)

test:
A to B: Good
B to A: Good
B to C: X
C to B: Good
A to C: X
C to A: X

### Lab 3a Turn on forwarding from B to C
### B--C: Turn on traffic from B to C
### B--C: Turn on forwarding from B to C
Traffic to remote virtual network: Allow (default)
Traffic forwarded from remote virtual network: Allow (default)
Virtual network gateway or Route Server: None (default)

test:
A to B: Good
B to A: Good
B to C: Good
C to B: Good
A to C: X
C to A: X

## Lab 3a Use gateway from B to D
### remove peer from B to C and C to B
### Create Gateway from B to D and D to B

test:
A to B: Good
B to A: Good
A to C: X
C to A: X
A to D: X
D to A: X
B to C: X
C to B: X
B to D: Good
D to B: Good
C to D: X
D to C: X

## Lab 3b VNet-B's peering with A (VNet-B--VNet-A), turn on 'Use this virtual networks's gateway or Route Server'
### VNet-A's peering with B (VNet-A--VNet-B), turn on 'Use this virtual networks's gateway or Route Server'
(give this change a few minutes)

test:
A to B: Good
B to A: Good
A to C: X
C to A: X
A to D: Good   <----
D to A: Good   <----
B to C: X
C to B: X
B to D: Good
D to B: Good
C to D: X
D to C: X

## Lab 3b Break VNet-A-to-VNet-D and VNet-D-to-VNet-A with only change in VNet-B's peering configuration.
### VNet-B's peering with A (VNet-B--VNet-A), turn OFF 'Use this virtual networks's gateway or Route Server'
(give this change a few minutes)

test:
A to B: Good
B to A: Good
A to C: X
C to A: X
A to D: X
D to A: X
B to C: X
C to B: X
B to D: Good
D to B: Good
C to D: X
D to C: X

## Lab 4 add peering from C to D
### Add a peering from C to D with no use of the gateway.

test:
A to B: Good
B to A: Good
A to C: X
C to A: X
A to D: Good
D to A: Good
B to C: X
C to B: X
B to D: Good
D to B: Good
C to D: Good
D to C: Good

## Lab 4 add Gateway connection from C to D
### In the Peering from VNet-D to VNet-C turn on "Use this virtual network's gateway or Route Server"
### In the Peering from VNet-C to VNet-D turn on "Use the remote virtual network's gateway or Route Server"

test:
A to B: Good
B to A: Good
A to C: Good
C to A: Good
A to D: Good
D to A: Good
B to C: Good
C to B: Good
B to D: Good
D to B: Good
C to D: Good
D to C: Good


# NSG Labs
## prove that D->B-A traffic where, d->B is VPN, and B-A is peering, that the NSG's VirtualNetwork tag allows that traffic