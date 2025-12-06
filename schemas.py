from pydantic import BaseModel,Field

class UserCreate(BaseModel):
    name: str
    displayName: str

class UserOut(BaseModel):
    id: int
    name: str
    displayName: str = Field(..., alias="display_name")

    class Config:
        from_attributes = True

