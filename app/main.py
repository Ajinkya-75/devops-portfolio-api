from fastapi import FastAPI
from mangum import Mangum

app = FastAPI()

@app.get("/")
def read_root():
    return {
        "Hello": "From GitHub Actions!",
        "Role": "DevOps Engineer",
        "Location": "India"
    }

@app.get("/health")
def health_check():
    return {"status": "healthy"}

# This is the entry point for AWS Lambda
handler = Mangum(app)