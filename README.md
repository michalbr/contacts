# Contacts

A simple contact management app built with Ruby on Rails. Contacts can be organized with labels for easy filtering. Each contact stores an email and notes, and can be assigned one or more labels.

## Tech Stack

- Ruby 3.4.8
- Rails 8.1.2
- PostgreSQL
- Hotwire (Turbo Frames, Turbo Streams)
- Stimulus
- Tailwind CSS

## Prerequisites

- Ruby 3.4.8
- PostgreSQL

## Setup

1. Clone the repository
```bash
   git clone https://github.com/michalbr/contacts.git
   cd contacts
```

2. Install dependencies
```bash
   bundle install
```

3. Configure environment variables
```bash
   cp .env.example .env
```
   Fill in `DB_USERNAME` and `DB_PASSWORD` in `.env` with your PostgreSQL credentials. Make sure the PostgreSQL user exists and has permission to create databases, before moving to the next step.

4. Setup database
```bash
   rails db:create db:migrate
```

5. Start the server
```bash
   bin/dev
```

6. Visit `http://localhost:3000`

## Running Tests

Run unit and controller tests:
```bash
rails test
```

Run system tests:
```bash
rails test:system
```

Run all tests:
```bash
rails test:all
```

## Features

- Create, edit, and delete contacts
- Create, edit, and delete labels
- Assign labels to contacts (via the contact edit page)
- Filter contacts by label
