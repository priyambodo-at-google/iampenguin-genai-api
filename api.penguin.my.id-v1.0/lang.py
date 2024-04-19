from langchain.chat_models import ChatVertexAI
from langchain.prompts import ChatPromptTemplate

_prompt = ChatPromptTemplate.from_template(
    "Tell me a joke about Chuck Norris and {text}")
_model = ChatVertexAI()

chain = _prompt | _model

chain.invoke({"text": "Cannelloni"})
# Here's a joke about Chuck Norris and Cannelloni:
# Chuck Norris doesn't eat cannelloni. He eats the can."