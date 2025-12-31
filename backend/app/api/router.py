# v1 라우터 묶을 예정 v1안에 모든 엔드포인트 담을 예정
from fastapi import APIRouter
from app.api.v1 import auth

api_router = APIRouter()
api_router.include_router(auth.router)
