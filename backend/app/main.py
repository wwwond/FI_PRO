#  FastAPI 앱 라우터 미들웨어 설정 등 시작점
from fastapi import FastAPI
from fastapi.responses import JSONResponse

def create_app() -> FastAPI:
    app = FastAPI(title="FI_PRO API", version="0.1.0")

    @app.get("/health", tags=["health"])
    async def health():
        # MVP: 일단 서버 살아있는지만 체크
        return JSONResponse({"status": "ok"})

    return app

app = create_app()
