# 회원가입/로그인/로그아웃/토큰 갱신/비밀번호 재설정
from fastapi import APIRouter, HTTPException, Depends
from fastapi.security import HTTPAuthorizationCredentials, HTTPBearer
from sqlalchemy import text

from app.db.session import SessionLocal
from app.schemas.auth import SignUpReq, LoginReq, TokenRes, MeRes
from app.core.security import hash_password, verify_password, create_access_token, decode_access_token

router = APIRouter(prefix="/auth", tags=["auth"])
bearer = HTTPBearer(auto_error=False)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.post("/signup")
def signup(req: SignUpReq, db=Depends(get_db)):
    # 중복 체크
    exists = db.execute(text("select 1 from users where email=:email"), {"email": req.email}).fetchone()
    if exists:
        raise HTTPException(status_code=409, detail="email already exists")

    pw_hash = hash_password(req.password)
    row = db.execute(
        text("insert into users(email, password_hash) values(:email, :pw) returning id"),
        {"email": req.email, "pw": pw_hash},
    ).fetchone()
    db.commit()

    return {"user_id": int(row[0])}

@router.post("/login", response_model=TokenRes)
def login(req: LoginReq, db=Depends(get_db)):
    row = db.execute(
        text("select id, email, password_hash from users where email=:email"),
        {"email": req.email},
    ).fetchone()

    if not row:
        raise HTTPException(status_code=401, detail="invalid credentials")

    user_id, email, pw_hash = int(row[0]), row[1], row[2]
    if not verify_password(req.password, pw_hash):
        raise HTTPException(status_code=401, detail="invalid credentials")

    access = create_access_token(str(user_id))
    return TokenRes(access_token=access)

@router.get("/me", response_model=MeRes)
def me(creds: HTTPAuthorizationCredentials | None = Depends(bearer), db=Depends(get_db)):
    if not creds or not creds.credentials:
        raise HTTPException(status_code=401, detail="missing token")

    try:
        payload = decode_access_token(creds.credentials)
    except ValueError:
        raise HTTPException(status_code=401, detail="invalid token")

    user_id = int(payload["sub"])
    row = db.execute(
        text("select id, email, role from users where id=:id"),
        {"id": user_id},
    ).fetchone()
    if not row:
        raise HTTPException(status_code=401, detail="user not found")

    return MeRes(user_id=int(row[0]), email=row[1], role=row[2])
