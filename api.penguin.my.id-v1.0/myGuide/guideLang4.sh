gcloud config set project iam-penguin
gcloud services enable aiplatform.googleapis.com
gcloud auth application-default login

pip install langchain-cli
langchain app new iam-chucknorris --package vertexai-chuck-norris
langchain serve

gcloud run deploy