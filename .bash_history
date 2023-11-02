az network public-ip create --resource-group azuremolchapter7az --name azpublicip --sku standard
az network lb create --resource-group azuremolchapter7az --name azloadbalancer --public-ip-address azpublicip --sku standard
az vm create --resource-group azuremolchapter7az --name zonedvm --image ubuntults --size Standard_B1ms --admin-username azuremol --generate-ssh-keys --zone 3
az vm create --resource-group azuremolchapter7az --name zonedvm --image Ubuntu2204 --size Standard_B1ms --admin-username azuremol --generate-ssh-keys --zone 3
az group create --name azuremolchapter8 --location westeurope
az network public-ip create --resource-group azuremolchapter8 --name publicip --sku standard
az network lb create --resource-group azuremolchapter8 --name loadbalancer --public-ip-address publicip --frontend-ip-name frontendpool --backend-pool-name backendpool --sku standard
az network lb probe create --resource-group azuremolchapter8 --lb-name loadbalancer --name healthprobe --protocol http --port 80 --path health.html --interval 10 --threshold 3
az network lb rule create --resource-group azuremolchapter8 --lb-name loadbalancer --name httprule --protocol tcp --frontend-port 80 --backend-port 80 --frontend-ip-name frontendpool --backend-pool-name backendpool --probe-name healthprobe
az network lb inbound-nat-rule create --resource-group azuremolchapter8 --lb-name loadbalancer --name natrulessh --protocol tcp --frontend-port 50001 --backend-port 22 --frontend-ip-name frontendpool
az network lb show --resource-group azuremolchapter8 --name loadbalancer
az network vnet create --resource-group azuremolchapter8 \--name vnetmol --name vnetmol \--address-prefixes 10.0.0.0/16 --subnet-name subnetmol --subnet-prefix 10.0.1.0/24
az network nsg create --resource-group azuremolchapter8 --name webnsg
az network nsg rule create --resource-group azuremolchapter8 --nsg-name webnsg --name allowhttp --priority 100 --protocol tcp --destination-port-range 80 --access allow
az network nsg rule create --resource-group azuremolchapter8 --nsg-name webnsg --name allowssh --priority 101 --protocol tcp --destination-port-range 22 --access allow
az network vnet subnet update --resource-group azuremolchapter8 --vnet-name vnetmol --name subnetmol --network-security-group webnsg
az network nic create --resource-group azuremolchapter8 --name webnic1 --vnet-name vnetmol --subnet subnetmol --lb-name loadbalancer --lb-address-pools backendpool --lb-inbound-nat-rules natrulessh
az network nic create --resource-group azuremolchapter8 --name webnic2 --vnet-name vnetmol --subnet subnetmol --lb-name loadbalancer --lb-address-pools backendpool
az vm create --resource-group azuremolchapter8 --name webvm1 --image ubuntults --size Standard_B1ms --admin-username azuremol --generate-ssh-keys --zone 1 --nics webnic1
az vm create --resource-group azuremolchapter8 --name webvm2 --image ubuntults --size Standard_B1ms --admin-username azuremol --generate-ssh-keys --zone 2 --nics webnic2
az vm list-sizes --location eastus --output table
[200~az group create --name azuremolchapter9 --location westeurope~
az group create --name azuremolchapter9 --location westeurope
az vmss create --resource-group azuremolchapter9 --name scalesetmol --image UbuntuLTS --admin-username azuremol --generate-ssh-keys --instance-count 2 --vm-sku Standard_B1ms --upgrade-policy-mode automatic --lb-sku standard --zones 1 2 3
az vmss create --resource-group azuremolchapter9 --name scalesetmol --image Ubuntu2204 --admin-username azuremol --generate-ssh-keys --instance-count 2 --vm-sku Standard_B1ms --upgrade-policy-mode automatic --lb-sku standard --zones 1 2 3
az vmss create \                                                                                                                                                                                                               az group create --name azuremolchapter9 --location easteurope --resource-group azuremolchapter9 --name scalesetmol --image Ubuntu2204 --admin-username azuremol --generate-ssh-keys --instance-count 2 --vm-sku Standard_B1ms --upgrade-policy-mode automatic --lb-sku standard --zones 1 2 3
az group create --name azuremolchapter9 --location easteurope
az group create --name azuremolchapter9 --location germanywestcentral
az vmss create --resource-group azuremolchapter9 --name scalesetmol --image UbuntuLTS --admin-username azuremol --generate-ssh-keys --instance-count 2 --vm-sku Standard_B1ms --upgrade-policy-mode automatic --lb-sku standard --zones 1 2 3
az vmss create --resource-group azuremolchapter9 --name scalesetmol --image Ubuntu2204 --admin-username azuremol --generate-ssh-keys --instance-count 2 --vm-sku Standard_B1ms --upgrade-policy-mode automatic --lb-sku standard --zones 1 2 3
[200~az vm list-usage --location westeurope
[200~az vm list-usage --location germanywestcentral
az vm list-usage --location westeurope germanywestcentral
az resource list --resource-group azuremolchapter9 --output table
az vmss scale --resource-group azuremolchapter9 --name scalesetmol --new-capacity 4
[200~az appservice plan create --name appservicemol --resource-group azuremolchapter9 --sku s1~
az appservice plan create --name appservicemol --resource-group azuremolchapter9 --sku s1
az webapp create --name webappmol --resource-group azuremolchapter9 --plan appservicemol --deployment-local-git
az webapp create --name webappmol2 --resource-group azuremolchapter9 --plan appservicemol --deployment-local-git
az vmss list-instance-connection-info --resource-group azuremolchapter9 --name scalesetmol
ssh azuremol@40.114.3.147 -p 50003
cd azure-mol-samples-2nd-ed/09
git init && git add . && git commit -m “Pizza”
