

export HUB_ORG_DH=dex450a@win20.jason1.com
export SFDC_HOST_DH=https://login.salesforce.com
export CON_APP_KEY_DH=3MVG9_XwsqeYoueKPaJZFY4btObNv1ZU1eOaIpPs1DnMap_HA6YuuhCHd6J3kuTVvX1A8bt9.7VRJ4HBXJEPR
export JWT_CRED_ID_DH="C:\Workspace\02.Architect\01.DX\Automate_script\certs\server.key"
export ALIAS_DH=DevHub
export UNIQUE_VAR=$(date +'%Y_%m_%d_%H_%M_%S')
export ALIAS_SO=scratch_$UNIQUE_VAR

mkdir $UNIQUE_VAR
cd $UNIQUE_VAR

printf "Step 1 : Clone \n"
git clone "git@github.com:nolbuDev/SFDXDemo1.git"

printf "Step 2 : Login using Certificate in Dev Hub \n"
sfdx force:auth:jwt:grant -f $JWT_CRED_ID_DH -u $HUB_ORG_DH -d -i $CON_APP_KEY_DH

printf "Step 3 : Create a scratch Org \n"
sfdx force:org:create -s -d 10 -a $ALIAS_SO -f SFDXDemo1/config/project-scratch-def.json -w 4

printf "Step 4 : Push source code to Scratch Org \n"
cd SFDXDemo1
sfdx force:source:push 

printf "Step 5 : Import initial Data \n"
sfdx force:data:tree:import -p data/Account-Contact-plan.json -u $ALIAS_SO

printf "Step 6 : Open Org \n"
sfdx force:org:open -u $ALIAS_SO
