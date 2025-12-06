from sqlalchemy.orm import Session
from models import User
from schemas import UserCreate

def create_user(db: Session, user: UserCreate):
    db_user = User(
        name=user.name,
        display_name=user.displayName
    )
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user


def get_users(db: Session, skip: int, limit: int):
    return db.query(User).offset(skip).limit(limit).all()

