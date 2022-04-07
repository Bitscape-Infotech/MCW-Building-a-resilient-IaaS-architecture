![Microsoft Cloud Workshops](https://github.com/Microsoft/MCW-Template-Cloud-Workshop/raw/main/Media/ms-cloud-workshop.png "Microsoft Cloud Workshops")

<div class="MCWHeader1">
Building a resilient IaaS architecture
</div>

<div class="MCWHeader2">
Before the hands-on lab setup guide
</div>

<div class="MCWHeader3">
September 2021

</div>


Information in this document, including URL and other Internet Web site references, is subject to change without notice. Unless otherwise noted, the example companies, organizations, products, domain names, e-mail addresses, logos, people, places, and events depicted herein are fictitious, and no association with any real company, organization, product, domain name, e-mail address, logo, person, place or event is intended or should be inferred. Complying with all applicable copyright laws is the responsibility of the user. Without limiting the rights under copyright, no part of this document may be reproduced, stored in or introduced into a retrieval system, or transmitted in any form or by any means (electronic, mechanical, photocopying, recording, or otherwise), or for any purpose, without the express written permission of Microsoft Corporation.

Microsoft may have patents, patent applications, trademarks, copyrights, or other intellectual property rights covering subject matter in this document. Except as expressly provided in any written license agreement from Microsoft, the furnishing of this document does not give you any license to these patents, trademarks, copyrights, or other intellectual property.

The names of manufacturers, products, or URLs are provided for informational purposes only and Microsoft makes no representations and warranties, either expressed, implied, or statutory, regarding these manufacturers or the use of the products with any Microsoft technologies. The inclusion of a manufacturer or product does not imply endorsement of Microsoft of the manufacturer or product. Links may be provided to third party sites. Such sites are not under the control of Microsoft and Microsoft is not responsible for the contents of any linked site or any link contained in a linked site, or any changes or updates to such sites. Microsoft is not responsible for webcasting or any other form of transmission received from any linked site. Microsoft is providing these links to you only as a convenience, and the inclusion of any link does not imply endorsement of Microsoft of the site or the products contained therein.

© 2021 Microsoft Corporation. All rights reserved.

Microsoft and the trademarks listed at <https://www.microsoft.com/en-us/legal/intellectualproperty/Trademarks/Usage/General.aspx> are trademarks of the Microsoft group of companies. All other trademarks are property of their respective owners.

**Contents**

- [Building a resilient IaaS architecture before the hands-on lab setup guide](#building-a-resilient-iaas-architecture-before-the-hands-on-lab-setup-guide)
  - [Requirements](#requirements)
  - [Before the hands-on lab](#before-the-hands-on-lab)
    - [Task 1: Create the LabVM Virtual Machine](#task-1-create-the-labvm-virtual-machine)
    - [Task 2: Deploy the Contoso sample application](#task-2-deploy-the-contoso-sample-application)
    - [Task 3: Wait for deployments to complete, and validate](#task-3-wait-for-deployments-to-complete-and-validate)
  - [Summary](#summary)

# Building a resilient IaaS architecture before the hands-on lab setup guide 

## Requirements

- Microsoft Azure Subscription

- LabVM virtual machine deployed using the instructions below. This is pre-installed with various tools and files you will use during this lab.

- Contoso sample application, also deployed using the instructions below.

## Before the hands-on lab

Duration: 25 minutes

In this exercise, you deploy a Lab VM needed to complete the rest of your lab.

### Task 1: Create the LabVM Virtual Machine

In this task, you will use an Azure Resource Manager template to deploy the LabVM virtual machine. This machine will be pre-configured with Visual Studio 2019 Community Edition, has Azure PowerShell pre-installed, and is pre-loaded with any additional files which you will use during the lab.

1.  Select the **Deploy to Azure** button below to open the Azure portal and launch the template deployment for the LabVM. Log in to the Azure portal using your subscription credentials if you are prompted to do so.
   
    [![Button to deploy the LabVM template to Azure.](https://aka.ms/deploytoazurebutton "Deploy the LabVM template to Azure")](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmicrosoft%2FMCW-Building-a-resilient-IaaS-architecture%2Fmaster%2FHands-on%20lab%2FResources%2Ftemplates%2Flab-vm.json)

    > **Note**: If you attempt to deploy the template above and it fails stating "requested size for resource *\<resourceID\>* is currently not available in location", you can choose a different VM size from the first screen of the deployment. 

2.  Complete the Custom deployment blade as follows:

    - Resource Group: **(Create new) LabRG**
  
    - Location: **Choose a location close to you**.

    Select **Review + Create** and then **Create** to deploy the resources.

    ![Screenshot of the Azure portal showing the custom template deployment settings for the LabVM.](images/BeforeTheHOL/labvm-deploy1.png "Screenshot of the Azure portal showing the custom template deployment settings for the LabVM")

    You should proceed to the next task **without** waiting for the deployment to complete. This saves time.

### Task 2: Deploy the Contoso sample application

In this task, you will use an Azure Resource Manager template to deploy the Contoso sample application, which you will use in this lab.

1.  Select the **Deploy to Azure** button below to open the Azure portal and launch the template deployment for the Contoso sample application. Log in to the Azure portal using your subscription credentials if you are prompted to do so.

    [![Button to deploy the Contoso sample application template to Azure.](https://aka.ms/deploytoazurebutton "Deploy the Contoso sample application template to Azure")](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fmicrosoft%2FMCW-Building-a-resilient-IaaS-architecture%2Fmaster%2FHands-on%20lab%2FResources%2Ftemplates%2Fcontoso-iaas.json)
    
    > **Note**: If you attempt to deploy the template above and it fails stating "requested size for resource *\<resourceID\>* is currently not available in location", you can choose a different VM size from the first screen of the deployment. 


2.  Complete the Custom deployment blade as follows:

    - Resource Group: **(Create new) ContosoRG1**
    - Location: **Central US**

    Select **Review + Create** and then **Create** to deploy the resources.

    ![The custom deployment screen with ContosoRG1 as the resource group and Central US as the region.](images/BeforeTheHOL/contoso-deploy1.png "Custom deployment")
    

### Task 3: Wait for deployments to complete, and validate

In this task, you will verify that the LabVM and Contoso sample application have been deployed successfully.

1.  You can check the LabVM deployment status by navigating to the **LabRG** resource group, selecting **Deployments** in the resource group left-nav, and checking the status of the 'Microsoft.Template' deployment. Make sure the template deployment status is **Succeeded** before proceeding to the hands-on lab guide.

    ![Screenshot of the Azure portal showing the template deployment status 'Succeeded'.](images/BeforeTheHOL/deployment-succeeded.png "Screenshot of the Azure portal showing the template deployment status Succeeded")

2.  You can check the Contoso application deployment status by navigating to the **ContosoRG1** resource group, selecting **Deployments** in the resource group left-nav, and checking the status of the deployments. Make sure the deployment status is **Succeeded** for all templates before proceeding to the hands-on lab guide.

    ![Screenshot of the Azure portal showing the template deployment status 'Succeeded' for each template.](images/BeforeTheHOL/contoso-success1.png "Screenshot of the Azure portal showing the template deployment status Succeeded for each template")

3.  Once the Contoso application deployment is successful, validate the application by opening the **WebVM1** virtual machine, copying the public IP address, and navigating to the public IP address in your browser.

    ![Go to WebVM1 in the resource group, locate the public IP address, and copy it into your web browser](images/BeforeTheHOL/contoso-webvmpubip.png "Copy WebVM1 public IP address")

    ![The Contoso application window displays, showing a button for 'Current Policy Offerings](images/BeforeTheHOL/contoso-app.png "Contoso application")

4.  Select the **Current Policy Offerings** button to review the policy list. This verifies that the web tier is able to connect to the database.

    ![The Contoso application policy list.](images/BeforeTheHOL/contoso-policy.png "Contoso policies")

## Summary

In these lab preparation steps, you set up a lab virtual machine, which includes Visual Studio 2019 Community Edition, Azure PowerShell, and other files used during this lab. You also deployed and verified the Contoso sample application which you will use in this lab.

You should follow all steps provided *before* attending the hands-on lab.


