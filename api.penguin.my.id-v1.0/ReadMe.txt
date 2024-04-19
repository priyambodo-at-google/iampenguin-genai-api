

Flow:
User --> Apigee --> Cloud Function --> Cloud Run --> LangServe --> LangChain --> Google Gemini API --> RAG --> Database/Storage

Step by Step:
gcloud run deploy chat --source . --region=us-central1 \
--service-account=<PUT YOUR SERVICE ACCOUNT HERE>\
--set-env-vars "PROJECT_ID=$(gcloud config get-value project)"

Add the /docs behind the URL (e.g. https://chat-5sasdav1lcq-uc.a.run.app/docs/)
We can go the Playground by adding the API path and the /playground (e.g. https://chat-5sasdav1lcq-uc.a.run.app/joke/playground)

Reference:
https://medium.com/@larry_nguyen/how-to-deploy-langserve-on-cloud-run-92b680021341
https://cloud.google.com/blog/products/ai-machine-learning/deploy-langchain-on-cloud-run-with-langserve 

