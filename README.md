# Chat App

Real-time chat application built with Node.js, Express.js and Socket.io.

## Features

- Users enter the chat and receive a randomly generated name.
- Users can change their name.
- Users can send and receive messages in real-time.
- Chats are not persisted to a database.

## Prerequisites

- Node.js >=18 (see `.nvmrc` — run `nvm use` if you have nvm)
- GNU Make — Windows: use Git Bash, WSL, or `choco install make`

## Setup

```sh
git clone <repo-url>
cd lesson-6-node-express-chatbox
make setup
make dev
```

Open `http://localhost:3001` in your browser.

## Configuration

Copy `.env.example` to `.env` (done automatically by `make setup`) and edit as needed.

| Variable | Default | Description |
|---|---|---|
| `PORT` | `3001` | TCP port the server listens on |

## Available Commands

| Command | Description |
|---|---|
| `make setup` | Install dependencies and create `.env` from `.env.example` |
| `make dev` | Start development server with auto-reload (nodemon) |
| `make start` | Start production server (no auto-reload) |
| `make test` | Run smoke test — verifies server loads and exits with code 0 |
| `make audit` | Print npm vulnerability report with remediation guidance |
| `make clean` | Remove `node_modules` and `.env` to reset to a clean state |

## Screenshots

![](https://github.com/danielc92/node-express-chatbox/blob/master/screenshots/Screen%20Shot%202019-07-11%20at%2011.29.03%20am.jpg)

![](https://github.com/danielc92/node-express-chatbox/blob/master/screenshots/Screen%20Shot%202019-07-11%20at%2011.29.30%20am.jpg)

![](https://github.com/danielc92/node-express-chatbox/blob/master/screenshots/Screen%20Shot%202019-07-11%20at%2011.29.35%20am.jpg)

![](https://github.com/danielc92/node-express-chatbox/blob/master/screenshots/Screen%20Shot%202019-07-11%20at%2011.30.17%20am.jpg)

## Sources

- [Express Documentation](https://expressjs.com/)
- [Socket.io Documentation](https://socket.io/docs/)
