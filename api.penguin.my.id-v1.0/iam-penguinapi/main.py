import os
import uvicorn

from fastapi import FastAPI
from langchain.prompts import ChatPromptTemplate
from langchain_google_vertexai import ChatVertexAI
from langserve import add_routes

PROJECT_ID = os.environ["PROJECT_ID"]
PORT = int(os.environ.get("PORT", 8080))
REGION = os.environ.get("REGION", "us-central1")

app = FastAPI(
    title="REST API for Vertex AI",
    description="REST API for Vertex AI"
)

model = ChatVertexAI(
    project_id=PROJECT_ID,
    location=REGION
)

prompt = ChatPromptTemplate.from_template("Tell me a joke about {topic}")

add_routes(
    app, 
    prompt | model, 
    path="/joke"
)

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=PORT)