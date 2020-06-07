
https://cloud.google.com/appengine/docs/standard/go112/quickstart

gcloud app deploy

gcloud app browse

Frontend :
    ( cd frontend && npm run serve ) &

Backend:
    ( cd backend &&  reflex -d none -s -R vendor. -r \.go$ -- go run cmd/server/main.go ) &
    #     use reflex as : reflex -d none -s -R vendor. -r \.go$ -- go run cmd/server/main.go

