## GitHub Action to Retrieve ENV from Infisical
This action fetches secrets from an Infisical instance for use in a GitHub Actions workflow.

#### Input Variables
|Input|Details|Default|Required|
|------|-----|-----|-----|
|project|Project ID from which to fetch the environment variables|None|Yes|
|token|Token used to authenticate with Infisical|None|No|
|client|Client ID for authentication if the token is not provided|None|No|
|secret|Secret key for authentication if the token is not provided|None|No|
|path|Path within the Infisical project to fetch the environment variables|None|No|
|output|File path to save the fetched environment variables|.env|No|

#### Usage
- Add INFISICAL_CLIENT_ID and INFISICAL_CLIENT_SECRET to your repository's secrets.

Using a Token for authentication and creating the `.env` in the root:

```
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Infisical Secret Fetcher
        uses: julioE3274/infisical-fetcher@v0.0.1
        with:
          token: ${{ secrets.INFISICAL_TOKEN }}
          project: 'xxx-project-id-xxx'
```

Using clientId and secret for authentication and creating the `.env.staging` in the root:

```
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Infisical Secret Fetcher
        uses: julioE3274/infisical-fetcher@v0.0.1
        with:
          client: ${{ secrets.INFISICAL_CLIENT_ID }}
          secret: ${{ secrets.INFISICAL_CLIENT_SECRET }}
          project: 'xxx-project-id-xxx'
          output: '.env.staging'
```