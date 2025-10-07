# 🛍️ E-Commerce Data Pipeline (Sprint Project 01)

### 📚 Proyecto del Programa Anyone AI — Data Science & Machine Learning Track

Este proyecto tiene como objetivo construir un **pipeline de datos (ELT)** para analizar métricas clave de un **E-commerce** real (Olist Store, Brasil) durante los años **2016–2018**, enfocado principalmente en **Revenue** y **Delivery**.

---

## 🧠 Descripción del problema

La empresa de E-commerce desea comprender mejor su rendimiento histórico en dos áreas principales:

1. **Revenue (Ingresos)**
   - Cuánto facturó por año.
   - Cuáles fueron las categorías más y menos populares.
   - Cómo se distribuyó el ingreso por estado.

2. **Delivery (Entregas)**
   - Cuánto tiempo tarda en entregar un pedido según el mes.
   - Cuál es la diferencia entre la fecha estimada y la real de entrega.
   - Cómo afectan los feriados nacionales al cumplimiento de entregas.

El objetivo es crear una **tubería de datos automatizada** que permita obtener y actualizar estos reportes fácilmente, integrando datos de múltiples fuentes.

---

## 🗂️ Fuentes de datos

### 1️⃣ Dataset Olist (CSV)
Dataset público de **Olist Store**, con más de **100.000 pedidos** realizados en Brasil (2016–2018).  
Incluye información sobre clientes, pedidos, productos, precios, pagos, envíos y reseñas.

📦 **Estructura del dataset**  
- `olist_customers_dataset.csv`  
- `olist_orders_dataset.csv`  
- `olist_order_items_dataset.csv`  
- `olist_order_payments_dataset.csv`  
- `olist_order_reviews_dataset.csv`  
- `olist_products_dataset.csv`  
- `olist_sellers_dataset.csv`  
- `product_category_name_translation.csv`

🗺️ Esquema de la base de datos disponible en:


### 2️⃣ API de feriados públicos
Se utiliza la API [Nager.Date](https://date.nager.at) para obtener los **feriados nacionales de Brasil** y correlacionarlos con las demoras en las entregas.

---

## ⚙️ Tecnologías utilizadas

| Herramienta | Propósito |
|--------------|-----------|
| 🐍 **Python** | Lenguaje principal |
| 🧮 **Pandas** | Limpieza y transformación de datos (Extract & Load) |
| 🌐 **Requests** | Consumo de la API pública de feriados |
| 🗃️ **SQLite** | Almacenamiento y consultas en Data Warehouse |
| 💾 **SQL** | Transformación y análisis de datos |
| 📊 **Matplotlib / Seaborn** | Visualización de resultados |
| 📓 **Jupyter Notebook** | Reporte interactivo |
| ⚡ **Black** | Formato de código automático |
| ✅ **Pytest** | Pruebas unitarias |

---

## 🏗️ Estructura del proyecto

E-commerce-ELT-Pipeline/
│
├── data/ # CSVs del dataset Olist
├── images/ # Diagramas y visualizaciones
├── sql/ # Consultas SQL de transformación
│ ├── revenue_by_month_year.sql
│ ├── revenue_per_state.sql
│ ├── delivery_date_difference.sql
│ └── ...
├── src/
│ ├── extract.py # Extracción de datos CSV
│ ├── load.py # Carga a SQLite
│ └── transform.py # Consultas SQL + cálculos
│
├── notebooks/
│ ├── report.ipynb # Visualizaciones e insights
│
├── tests/
│ └── test_transform.py # Validación de queries
│
├── requirements.txt
├── ASSIGNMENT.md
├── README.md
└── main.py # Script principal del pipeline


---

## 🚀 Instalación y ejecución

1. **Clonar el repositorio**
   ```bash
   git clone https://github.com/NicoGigenaVaras/E-commerce-ELT-Pipeline.git
   cd E-commerce-ELT-Pipeline

python -m venv venv
source venv/bin/activate       # macOS/Linux
venv\Scripts\activate          # Windows

pip install -r requirements.txt

python main.py

black --line-length=88 .

pytest tests/

📈 Resultados esperados

Reportes anuales y mensuales de revenue.

Top 10 categorías más y menos rentables.

Distribución de ingresos por estado.

Análisis de tiempos de entrega vs fechas estimadas.

Impacto de feriados en demoras logísticas.

Las visualizaciones se generan en notebooks/report.ipynb e incluyen gráficos de barras, series temporales y mapas de calor.

🧪 Testing

El proyecto incluye pruebas unitarias con Pytest para validar la consistencia de los datos y los resultados de las consultas SQL.

Ejemplo:

pytest tests/test_transform.py -v

Para más información:

Effective Python Testing with Pytest

Hitchhiker’s Guide to Python — Testing Your Code

👨‍💻 Autor

Nicolás Eduardo Gigena Varas
💼 Software Developer @ Banco de Córdoba
🎓 Data Science & Machine Learning Student @ Anyone AI
🌐 GitHub
 | LinkedIn
 | 📧 nicogigenavaras@gmail.com

📄 Licencia

Este proyecto fue desarrollado con fines educativos como parte del programa Anyone AI Bootcamp.
Puedes usarlo y modificarlo libremente citando la fuente original.
