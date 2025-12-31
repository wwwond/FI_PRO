from pydantic import BaseModel, EmailStr, Field

class SignUpReq(BaseModel):
    email: EmailStr
    password: str = Field(min_length=6, max_length=128)

class LoginReq(BaseModel):
    email: EmailStr
    password: str

class TokenRes(BaseModel):
    access_token: str
    token_type: str = "bearer"

class MeRes(BaseModel):
    user_id: int
    email: EmailStr
    role: str
