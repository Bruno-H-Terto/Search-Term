# Search Terms

This project was developed as part of the HelpJuice technical assessment.

Link de deploy => [Search Term](https://search-term.onrender.com/)

## Features
- Real-time search

- Persistent search term logging

- Basic search analytics (e.g., most recent queries)

- Background Jobs


## Tech Stack
- Ruby on Rails 7

- PostgreSQL – for storing search terms

- Redis – optional, for caching or real-time broadcasting

- Hotwire (Turbo + Stimulus) – for reactive UI without JS frameworks

- Docker – containerized setup

- Render – for deployment

- RSpec and Capybara – for tests

- Rubocop – for lint

- SimpleCov – for coverage

- SolidQueue – for async Jobs

## Setup

```sh
$ git clone https://github.com/Bruno-H-Terto/Search-Term.git
$ cd Search-Term
$ source alias.sh
$ dcub
```
Once the server starts, it will be available at http://0.0.0.0:3000 

## Tests

```sh
$ dce rspec
```

## Lint

```sh
$ dce rubocop
```

## Usage
Visit the homepage and enter a term into the search field.
After 1 second each query is saved to the database.
Recent searches can be displayed dynamically using Turbo and Background Jobs.

### Analytics
This app stores every search term and allows you to:

- List the most recent queries

- Potentially aggregate data (e.g., most frequent searches)

## Routes

### / root_path

![alt text](app/images/image.png)

## Author

Github: [Bruno Herculano](https://github.com/Bruno-H-Terto)