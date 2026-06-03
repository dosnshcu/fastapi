import uvicorn
from fastapi import FastAPI

app = FastAPI()


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.get("/hello/{name}")
async def say_hello(name: str):
    return {"message": f"Hello {name}"}

@app.get("/world/{name}")
async def say_world(name: str):
    return {"message": f"World {name}"}


@app.get("/helloworld/{name}")
async def say_helloworld(name: str):
    return {"message": f"helloworld {name}"}

@app.get("/a/{name}")
async def say_a(name: str):
    return {"message": f"a {name}"}

@app.get("/b/{name}")
async def say_b(name: str):
    return {"message": f"b {name}"}

if __name__ == "__main__":
    print("111111111111111111111111111111111")
    uvicorn.run(app, host="127.0.0.1", port=8000)