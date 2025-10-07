from pandas import DataFrame, read_sql
from sqlalchemy import create_engine
from sqlalchemy import Engine

from src.load import load
from typing import Dict 

def test_load_to_sqlite():
    df_test = DataFrame({
        "id": [1,2,3],
        "nombre": ["Nico", "Flor", "Luis"]
    })

    data_frame = {
        "personas": df_test
    }

    engine = create_engine("sqlite:///:memory:")

    load(data_frame, engine)

    query_result = read_sql("SELECT * FROM personas", con=engine)

    assert query_result.shape == (3, 2)
    assert query_result.iloc[0]["nombre"] == "Nico"
    assert list(query_result["id"]) == [1,2,3]
