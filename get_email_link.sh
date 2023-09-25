#!/bin/bash

email="$1"

docker compose exec -it postgres \
psql -U postgres \
    -d postgres \
    -P pager=off \
    --tuples-only \
    --command "SELECT (args ->> 'url') FROM oban_jobs WHERE worker='Asciinema.Emails.Job' AND (args ->> 'to') = '$email' ORDER BY inserted_at DESC LIMIT 1;"
