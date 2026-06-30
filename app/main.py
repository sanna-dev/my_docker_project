from fastapi import FastAPI
import redis
import psycopg2
import os

app = FastAPI()

# Подключение к Redis
cache = redis.Redis(host='redis', port=6379)

# Подключение к PostgreSQL
def get_db_connection():
    conn = psycopg2.connect(
        host="db",
        database="app_db",
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD")
    )
    return conn

@app.get("/")
def read_root():
    # Инкремент счетчика в Redis
    hits = cache.incr('hits')
    
    # Проверка соединения с Postgres
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute('SELECT version();')
    db_version = cur.fetchone()
    cur.close()
    conn.close()
    
    return {
        "message": "Привет! Это FastAPI в Docker",
        "visits": hits,
        "db_version": db_version
    }

@app.get("/health")
def health_check():
    return {"status": "ok"}
