import sqlite3

try:
    con = sqlite3.connect("data/data.db")
    cursor = con.execute("SELECT name FROM sqlite_master WHERE type='table';")
    tables = cursor.fetchall()

    if tables:
        print("✅ Base de datos encontrada. Tablas:")
        for t in tables:
            print(f" - {t[0]}")
    else:
        print("⚠️ Base de datos existe pero no tiene tablas.")

except Exception as e:
    print(f"❌ Error al abrir la base de datos: {e}")

finally:
    con.close()