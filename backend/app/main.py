#  FastAPI 앱 라우터 미들웨어 설정 등 시작점
from fastapi import FastAPI
from sqlalchemy import text
from app.db.session import SessionLocal
from app.api.router import api_router

app = FastAPI(title="FI_PRO API", version="0.1.0")
app.include_router(api_router)

@app.get("/health")
def health():
    return {"status": "ok"}

@app.get("/health/db")
def health_db():
    db = SessionLocal()
    try:
        db.execute(text("select 1"))
        return {"db": "ok"}
    finally:
        db.close()
