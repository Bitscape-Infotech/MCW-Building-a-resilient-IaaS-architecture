# Building a resilient IaaS architecture 

Contoso Insurance (CI), headquartered in Miami, provides insurance solutions across North America. Its products include accident and health insurance, life insurance, travel, home, and auto coverage. CI manages data collection services by sending mobile agents directly to the insured to gather information as part of the data collection process for claims from an insured individual. These mobile agents are based all over the US and are residents of the region in which they work. Mobile agents are managed remotely, and each regional corporate office has a support staff responsible for scheduling their time based on requests that arrive to the system. The company's headquarters in in Miami, Florida with a second large location in Seattle, Washington along with three smaller branch offices scatted around the United States.

Several years ago, under the leadership of Lewis Franklin, head of infrastructure and operations, individual departments started migrating their servers into Azure. The Active Directory Domain Services (ADDS) team has deployed several Domain Controller (DC) Virtual Machines (VM) to a virtual network in the West Central US region. This region was chosen due to its proximity to the Cheyenne Headquarters. While the Azure deployments have served Contoso well so far, they are concerned about their reliability.

September 2021


## Target audience

- Enterprise Architects
- Infrastructure Engineers

## Abstracts

### Workshop

In this workshop, you will look at how to design for converting/extending an existing IaaS deployment to account for resiliency and in general high availability. Throughout the whiteboard design session, you will look at the various configuration options and services to help build resilient architectures.

At the end of the workshop, you will be better able to design and use resiliency concepts including High Availability with protection from hardware/rack and datacenter failures with Availability Zones, High Availability and Disaster Recovery for database tiers using SQL Always ON, Disaster Recovery for virtual machines to another region using Azure Site Recovery, and data protection using Azure Backup.

### Whiteboard Design Session

In this whiteboard design session, you will look at how to design for converting/extending an existing IaaS deployment for resiliency. Throughout the whiteboard design session, you will look at the various configuration options and services to help build resilient architectures.

At the end of the workshop, you will be better able to design and use resiliency concepts including high availability with Availability Zones, disaster recovery for virtual machines to another region using Azure Site Recovery, and SQL Server high availability and disaster recovery using AlwaysOn Availability Groups. You will also learn how to assess the availability SLA, RPO and RTO of your design, and how to use Azure Backup to protect and secure your SQL data and VMs against corruption and loss.

You will also discuss how to achieve a similar level of resiliency for a PaaS-based implementation the same application, based on Azure App Service and Azure SQL Database. Finally, you will consider the costs associated with both approaches.

### Hands-on Lab

In this hands-on lab, you will deploy a pre-configured IaaS environment and then redesign and update it to account for resiliency and in general high availability. Throughout the hands-on lab you will use various configuration options and services to help build a resilient architecture.

At the end of the lab, you will be better able to design and use availability zones, SQL Server Always on Availability Groups, Azure Site Recovery, Azure Backup, and Azure Front Door to implement a fully resilient IaaS application, including high availability, disaster recovery, as well as backup of both databases and virtual machines.

## Azure services and related products
- Azure VMs
- Availability Sets
- Availability Zones
- Azure Portal
- Azure PowerShell
- Azure Backup
- Azure Site Recovery
- Azure Automation
- Azure Front Door
- Active Directory
- SQL Server Always On Availability Groups

## Azure solutions
DC Migration

## Related references
- [MCW](https://github.com/Microsoft/MCW)
- [Identity management](https://microsoft.sharepoint.com/sites/infopedia/pages/layouts/kcdoc.aspx?k=g01kc-1-30334)
- [Hybrid networking](https://microsoft.sharepoint.com/sites/infopedia/pages/layouts/kcdoc.aspx?k=g01kc-1-30331)
- [Design for resiliency](https://microsoft.sharepoint.com/sites/infopedia/pages/layouts/kcdoc.aspx?k=g01kc-1-30327)
- [Linux VMs](https://microsoft.sharepoint.com/sites/infopedia/pages/layouts/kcdoc.aspx?k=g01kc-1-30330)
- [Windows VMs](https://microsoft.sharepoint.com/sites/infopedia/pages/layouts/kcdoc.aspx?k=g01kc-1-30329)
- [Resiliency checklist](https://microsoft.sharepoint.com/sites/infopedia/pages/layouts/kcdoc.aspx?k=g01kc-1-30328)

## Help & Support

We welcome feedback and comments from Microsoft SMEs & learning partners who deliver MCWs.  

***Having trouble?***
- First, verify you have followed all written lab instructions (including the Before the Hands-on lab document).
- Next, submit an issue with a detailed description of the problem.
- Do not submit pull requests. Our content authors will make all changes and submit pull requests for approval.   

If you are planning to present a workshop, *review and test the materials early*! We recommend at least two weeks prior.

### Please allow 5 - 10 business days for review and resolution of issues.
