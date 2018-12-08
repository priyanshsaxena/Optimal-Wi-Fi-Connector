# Optimal Wi-Fi Connector

### Problem Statement

In the Computer-Lab or hostels, if every computer connects to the same
wireless access point, then it becomes a bottleneck and the users do not
get high-speed connectivity. The requirement is to develop an automated
solution that can help users in selecting the optimal wireless access
point so as to achieve higher connectivity speeds for all users.

### Solution Overview

This software/app helps to monitor the network state and provide useful
suggestions that can be used to achieve a balanced load on all routers and
LAN-cable hotspots and provide better connectivity to the users, in terms
of network-speed.

The solution consists of two entities that work in co-ordination with one
another, over a network, following a client-server architecture.

### Credits

1. The client-side of this service can be found on [CS307 by Rajat Mehra](https://github.com/rajatmehra2307/CS307).
2. **Sweet Alert** - A beautiful replacement for JavaScript's "Alert" by [Tristan Edwards](tristanedwards.me). 

### Available End-Points

The clients of this software can exploit the following endpoints:

1. **To request suggestion:**

    `/cmac=<currentMAC>&cstr=<currentStrength>&cname=<currentSSID>&addr
ess=<ip>&opts=<allAvailableTripletsOfMacStrengthSSIDNames>`

    This endpoint provides server with all the information needed to provide a
suggestion to client.

2. **To retrieve suggestion:**

    `/success`

    This endpoint contains the name of the ESSID and BSSID that is suggested by
the server, based on information sent by the previous endpoint.

3. **To receive information about whether the suggestion was accepted:**

    `/address=<ip>&accepted=<action>`
    
    This endpoint gives the IP address of a machine and ‘true’ if the connection was
accepted and ‘false’ otherwise.

4. **To receive information about a Hotspot:**

    `/hotspot=<mac>`
    
    This endpoint lists a new hotspot.
    
5. **To receive feedback:**

    `/address=<address>&feedback=<value>`
    
    This endpoint receives feedback from `address` IP address as _true_ or _false_.
    
6. **To download files for speed-test:**

    `/downloads/<size>`
    
    This endpoint allows downloading of files of size <size> MB in zip format. The available sizes are 5, 10, 20, 50, 100 MB.