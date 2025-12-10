from fastapi import FastAPI,Depends
import asyncio
import uvicorn
from sqlalchemy.orm import Session

from database import Base, engine, SessionLocal
from schemas import UserCreate, UserOut
from crud import create_user, get_users
import models
import socket

Base.metadata.create_all(bind=engine)
app = FastAPI()

@app.get("/")
async def index():
    await asyncio.sleep(0.01)   # 模拟 I/O 耗时
    return socket.gethostname() + ": ok"

@app.get("/health")
def health():
    return {"status": "ok"}

# 依赖：获取 DB 会话
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


# 创建用户
@app.post("/users", response_model=UserOut)
def api_create_user(user: UserCreate, db: Session = Depends(get_db)):
    return create_user(db, user)


# 分页获取用户列表
@app.get("/users", response_model=list[UserOut])
def api_get_users(page: int = 1, page_size: int = 10, db: Session = Depends(get_db)):
    skip = (page - 1) * page_size
    users = get_users(db, skip=skip, limit=page_size)
    return users

if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8000, workers=1, reload=True)
