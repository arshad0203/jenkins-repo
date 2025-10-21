# my-ci-app
Tiny Node.js app for Jenkins CI/CD demo.

## How to Run Locally
```bash
npm ci
npm test
docker build -t my-ci-app .
docker run -p 8080:8080 my-ci-app
