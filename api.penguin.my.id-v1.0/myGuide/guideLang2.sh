# Use admin@priyambodo.altostrat.com (bukan pakai doddi)

# Define project & billling accounts:
export PROJECT_ID=iam-penguin
export ACCOUNT_ID=01D920-A90EFC-E7459C
export MEMBER_USER=doddi@priyambodo.altostrat.com

# If you haven’t created the Project, then start from here…. 
gcloud projects create $PROJECT_ID
gcloud beta billing projects link $PROJECT_ID --billing-account=$ACCOUNT_ID
gcloud config set project $PROJECT_ID

gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member=user:$MEMBER_USER \
    --role="roles/owner"

gcloud services enable "orgpolicy.googleapis.com"

ORGANIZATION_ID=`gcloud organizations list --format="value(ID)"`

# If you already created the Project, then start from here…. 
# Start Inner Loop - Loop Through Policies with Constraints
rm -rf new_policy.yaml
declare -a policies=("constraints/compute.trustedImageProjects"
                "constraints/compute.vmExternalIpAccess"
                "constraints/compute.restrictSharedVpcSubnetworks"
                "constraints/compute.restrictSharedVpcHostProjects"
                "constraints/compute.restrictVpcPeering"
                "constraints/compute.vmCanIpForward"
                "constraints/run.allowedIngress"
                "constraints/iam.allowedPolicyMemberDomains"
                )
for policy in "${policies[@]}"
do
cat <<EOF > new_policy.yaml
constraint: $policy
listPolicy:
 allValues: ALLOW
EOF
gcloud resource-manager org-policies set-policy new_policy.yaml --project=$PROJECT_ID
done
# End Inner Loop

# Disable Policies without Constraints
gcloud beta resource-manager org-policies disable-enforce compute.requireShieldedVm --project=$PROJECT_ID
gcloud beta resource-manager org-policies disable-enforce compute.requireOsLogin --project=$PROJECT_ID
gcloud beta resource-manager org-policies disable-enforce iam.disableServiceAccountKeyCreation --project=$PROJECT_ID
gcloud beta resource-manager org-policies disable-enforce iam.disableServiceAccountCreation --project=$PROJECT_ID

rm -rf new_policy.yaml