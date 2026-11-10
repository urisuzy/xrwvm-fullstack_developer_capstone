# Best Cars Dealership - Full Stack Capstone Project

**Project name: Best Cars Dealership** - a full-stack web application for a national car retailer
in the U.S. that lists dealership branches across the country and lets customers read and post reviews.

## Features
- Static **About Us** and **Contact Us** pages (Django templates)
- User management: register, login and logout (Django + React)
- Dealers list with filter by state, dealer details page and reviews
- Post a review for a dealer (logged-in users only)
- Sentiment analysis of every review (Flask + NLTK VADER microservice on IBM Cloud Code Engine)
- Car makes and models stored in SQLite and managed through the Django admin

## Architecture
| Component | Technology |
|---|---|
| Frontend | React (built into Django templates) |
| Web app | Django (SQLite for users, car makes and models) |
| Dealers and reviews API | Node.js / Express + MongoDB (Docker) |
| Sentiment analyzer | Flask + NLTK (IBM Cloud Code Engine) |
| CI | GitHub Actions (flake8 + JSHint) |
| Deployment | Docker + Kubernetes |

## Run locally
```bash
# Dealers and reviews API (Node + MongoDB)
cd server/database && docker build . -t nodeapp && docker compose up -d

# Sentiment analyzer
cd server/djangoapp/microservices && docker build . -t sentianalyzer && docker run -d -p 5050:5000 sentianalyzer

# React frontend
cd server/frontend && npm install && npm run build

# Django
cd server && pip install -r requirements.txt
python3 manage.py makemigrations && python3 manage.py migrate
python3 manage.py runserver
```
