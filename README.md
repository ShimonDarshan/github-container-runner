# GitHub Container Runner

A self-hosted GitHub Actions runner in a Docker container.

## Setup

1. In your GitHub repo, go to **Settings → Actions → Runners → New self-hosted runner**.
2. Copy the token from the **Configure** section (`--token X...`).
3. Create your env file and fill it in:

   ```sh
   cp .env.example .env
   ```

   - `REPO`: `username/repo`
   - `TOKEN`: the copied token
4. Start the runner:

   ```sh
   docker compose up -d --build
   ```

Use `runs-on: self-hosted` in your workflow to run jobs on it.

## Notes

- The token is single-use and expires after about an hour. Get a new one each time you recreate the container (`docker compose down` then `up`). A plain restart doesn't need one.
- `.env` is git-ignored. Don't commit your token.
- Stopping the runner doesn't remove it from GitHub. Delete stale ones under **Settings → Actions → Runners**.
