# Chat App

Real-time chat application built with Node.js, Express.js and Socket.io.

## Features

- Users can enter the chat.
- Users receive a random generated name on join.
- Users can change their name.
- Users can send and receive messages in real-time.
- Chats are not persisted to a database.

## Prerequisites

- Node.js 18.x (see .nvmrc)
- npm (bundled with Node.js)
- Git Bash or WSL on Windows for running setup.sh

## Golden Path Setup

1. Clone and enter the repository.

```sh
git clone <your-fork-url>
cd lesson-6-node-express-chatbox
```

2. Run bootstrap setup.

```sh
sh setup.sh
```

What setup.sh does:
- Validates Node major version.
- Validates npm is available.
- Creates .env from .env.example if missing.
- Installs dependencies.
- Runs npm audit check and prints remediation guidance if issues exist.

3. Start the development server.

```sh
npm run dev
```

4. Verify the app is running.

- Expected terminal message: `Listening to requests on http://0.0.0.0:3001`
- Open: http://localhost:3001
- Expected behavior: chat UI loads and a session id appears in User details.

## Configuration

Runtime configuration is managed through .env.

- PORT: server port (default 3001)
- HOST: bind host (default 0.0.0.0)
- NODE_ENV: runtime mode (development, test, production)

Use .env.example as the template for local setup.

## Scripts

- npm run setup: run onboarding bootstrap script
- npm run dev: run server with nodemon
- npm start: run server with node
- npm test: smoke check placeholder (prints status and exits 0)

## Screenshots

![](https://github.com/danielc92/node-express-chatbox/blob/master/screenshots/Screen%20Shot%202019-07-11%20at%2011.29.03%20am.jpg)

![](https://github.com/danielc92/node-express-chatbox/blob/master/screenshots/Screen%20Shot%202019-07-11%20at%2011.29.30%20am.jpg)

![](https://github.com/danielc92/node-express-chatbox/blob/master/screenshots/Screen%20Shot%202019-07-11%20at%2011.29.35%20am.jpg)

![](https://github.com/danielc92/node-express-chatbox/blob/master/screenshots/Screen%20Shot%202019-07-11%20at%2011.30.17%20am.jpg)

## Sources

- https://expressjs.com/
