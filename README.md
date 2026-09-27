# Travel AI & MLOps Capstone

An end-to-end travel machine-learning and MLOps project covering **flight price regression, gender classification as a benchmark, hotel recommendation, REST API serving, Streamlit UI, Docker, Kubernetes, Airflow, Jenkins and MLflow**.

## GitHub repository

**Repository:** https://github.com/St-virus1210/travel-mlops-capstone-2

The GitHub URL above is intentionally included in all three submission notebooks. For the AlmaBetter submission, submit the **Colab links to the notebooks**, not only the GitHub URL.

## Submission notebooks

| Notebook | Purpose |
|---|---|
| `notebooks/01_Regression_Modeling.ipynb` | Flight price regression |
| `notebooks/02_Classification_Modeling.ipynb` | Gender classification benchmark |
| `notebooks/03_Recommender_Modeling.ipynb` | Hotel recommendation baseline |

Each notebook is designed for Google Colab and loads the public dataset from GitHub, with a local-data fallback for repository testing.

## Dataset

The project uses three CSV datasets:

- `data/flights.csv` — 271,888 rows, 10 columns
- `data/users.csv` — 1,340 rows, 5 columns
- `data/hotels.csv` — 40,552 rows, 8 columns

## Models

### Flight price regression

A preprocessing pipeline converts the date into month/day-of-week and encodes categorical variables. A Random Forest regressor is trained and saved to `models/flight_price_model.joblib`.

The benchmark metrics currently stored in `models/metrics.json` are:

- MAE: 0.006952
- RMSE: 0.099150
- R²: 0.99999993

**Important:** this extremely high score is a benchmark result and should not be interpreted as real-world performance. The notebook explicitly discusses possible deterministic relationships/leakage and recommends validation on an independently collected dataset.

### Gender classification

A Logistic Regression pipeline combines character-level TF-IDF features from names with company and age features. This is included as a **technical benchmark only**. Inferring gender from names is not appropriate as a production decision system and should be treated cautiously.

Stored benchmark metrics:

- Accuracy: 0.8333
- Precision: 0.8394
- Recall: 0.8333
- F1: 0.8326

### Hotel recommendation

A transparent popularity/price baseline first identifies the user's most frequent historical destination and then ranks hotels in that destination using booking frequency and relative average price.

## Run locally

```bash
python -m pip install -r requirements.txt
python src/train_regression.py
python src/train_classification.py
python -m pytest -q
python api/app.py
```

In another terminal:

```bash
streamlit run streamlit/app.py
```

## API

### Health

`GET /health`

### Model information

`GET /model-info`

### Flight price prediction

`POST /predict`

Example JSON:

```json
{
  "from": "Recife (PE)",
  "to": "Florianopolis (SC)",
  "flightType": "firstClass",
  "time": 1.76,
  "distance": 676.53,
  "agency": "FlyingDrops",
  "date": "09/26/2019"
}
```

## Docker

```bash
docker compose up --build
```

- API: `http://localhost:5000`
- Streamlit: `http://localhost:8501`

## Kubernetes

Build/tag the API image as `travel-flight-api:latest`, make it available to the cluster, then run:

```bash
kubectl apply -f kubernetes/deployment.yml
kubectl apply -f kubernetes/service.yml
```

The API is exposed internally through a ClusterIP service on port 80.

## Airflow

The DAG `airflow/dags/travel_regression_dag.py` validates the flight data and runs the regression training task. The DAG assumes the repository is mounted at `/opt/airflow/project`.

## Jenkins

`jenkins/Jenkinsfile` runs tests, builds the Docker image and applies the Kubernetes manifests. A Jenkins agent must have Python, Docker and kubectl configured.

## MLflow

Regression training logs parameters and metrics to MLflow. Start a local tracking server if desired, then configure `MLFLOW_TRACKING_URI` before training.

## Project structure

```text
travel-mlops-capstone-2/
├── api/
├── airflow/dags/
├── data/
├── docker/
├── docs/
├── jenkins/
├── kubernetes/
├── mlflow/
├── models/
├── notebooks/
├── src/
├── streamlit/
├── tests/
├── Dockerfile
├── docker-compose.yml
├── requirements.txt
└── README.md
```

## AlmaBetter submission checklist

Before resubmitting:

1. Open each notebook in Google Colab.
2. Run **Runtime → Run all**.
3. Save the executed notebook.
4. Share the notebook so the evaluator can open it.
5. Submit the Colab notebook link(s) in AlmaBetter.
6. Confirm the GitHub repository link is visible inside each notebook:
   `https://github.com/St-virus1210/travel-mlops-capstone-2`
7. Submit the GitHub repository link as the project repository as well.
