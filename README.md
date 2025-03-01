## Drag and Drop Todo List in Rails with Stimulus and Shopify Draggable

This project demonstrates how to implement a drag-and-drop sortable list in a Ruby on Rails application using Stimulus.js and Shopify Draggable.

## Features

- Create, update, and delete todos

- Drag and drop to reorder todos

- Persistent sorting using Rails and PostgreSQL

- Optimized bulk updates using upsert_all

- Stimulus.js integration for handling drag events

## Technologies Used

- Ruby on Rails 7 (Backend framework)

- Stimulus.js (Frontend framework for handling drag-and-drop behavior)

- Shopify Draggable (JavaScript library for drag-and-drop functionality)

- PostgreSQL (Database)

- Tailwind CSS (Styling)

- Docker (Optional, for local development)

## Getting Started

## Prerequisites

- Ensure you have the following installed:

- Ruby (3.x recommended)

- Rails (7.x recommended)

- PostgreSQL

- Node.js and Yarn

- Docker (optional)

## Setup

1. Clone the repository and install dependencies:

- `git clone https://github.com/your-username/draggable-demo.git`
- `cd drag-drop-todo`
- `bundle install`

## Set up the database:

- `rails db:create db:migrate db:seed`

2. Running the App

## Start the Rails server:

- `rails server`

- Visit http://localhost:3000 in your browser.

3. Running with Docker

- If you prefer to use Docker, you can spin up the application using:

`docker-compose up --build`

## How Drag and Drop Works

- The frontend uses Stimulus.js to listen for drag events.

- Shopify Draggable handles the actual drag-and-drop interaction.

- When the user stops dragging, an AJAX request updates the order in the database.

- The sort action in TodosController uses upsert_all for efficient bulk updates.

## API Endpoints

1. GET /todos - List all todos

2. POST /todos - Create a new todo

3. PATCH /todos/:id - Update a todo

4. DELETE /todos/:id - Delete a todo

5. PATCH /todos/sort - Bulk update todo order

## Contributing

- Feel free to open issues and submit pull requests!

## License

- This project is open-source and available under the MIT License.
