#/bin/bash
git config --global user.name "Doddi Priyambodo"
git config --global user.email "doddi@bicarait.com"
git add .
git commit -a -m "Doddi Priyambodo is committing at $(date +"%Y-%m-%d %H:%M:%S")"
git push

export GCP_REGION='us-central1'
export GCP_PROJECT='iam-penguin'
export AR_REPO='penguinmyid-artifactregistry'
export SERVICE_NAME='apipenguinmyid'

pip install --upgrade pip
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
pip install --upgrade pip

#/bin/bash
#gcloud init
#gcloud auth login
#gcloud config set project iam-penguin
#gcloud components update

gcloud auth configure-docker "$GCP_REGION-docker.pkg.dev"
gcloud artifacts repositories create "$AR_REPO" --location="$GCP_REGION" --repository-format=Docker
gcloud builds submit --tag "$GCP_REGION-docker.pkg.dev/$GCP_PROJECT/$AR_REPO/$SERVICE_NAME"

gcloud run deploy "$SERVICE_NAME" \
   --image="$GCP_REGION-docker.pkg.dev/$GCP_PROJECT/$AR_REPO/$SERVICE_NAME" \
   --port=8080 \
   --allow-unauthenticated \
   --region=$GCP_REGION \
   --platform=managed  \
   --project=$GCP_PROJECT \
   --set-env-vars=GCP_PROJECT=$GCP_PROJECT,GCP_REGION=$GCP_REGION

#Result: 
#https://iamgemini-priyambodo-com-rzmyhdhywa-uc.a.run.app