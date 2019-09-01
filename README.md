# Authentication API

An API for creating and authenticating users, using Redis as data storage.

## Setup

This app uses ruby 2.5.1 and rails 5.2.3.

1. Run `bin/setup` to set up the application.
2. If Redis is already installed in your system, start it with `redis-server` command.
3. Run `rails s` to start the server.

## Methodology

### Security Considerations

1. Sanitizing the params to prevent code injection including XSS. Fortunately, the Redis protocol has no concept of string escaping, so injection is impossible under normal circumstances.
2. Having strong params to prevent a malicious user from assigning any value to any attribute. I used the standard rails method for this.
3. Hashing the password so that if the data is compromised, users' passwords are not exposed. For this, I used bcrypt.

If given more time, I would add a session JWT Token to persist the state for authentication. Since redis is already installed, we could store the session in a cache.

### Problems with using redis as a primary database.

Having Redis as the primary database came with some interesting problems. I could not use the all powerful active record features, including validations. So I had to take care of them on my own.

Redis also does not synchonously persist data to disk as you write it. The two main problems are:
1. You have to be able to fit all your data in memory.
2. If the server fails between disk syncs you lose anything that was sitting in memory.

The work around the first problem is to use partitioning and split the data set into multiple Redis instances.

To solve the second problem, we could have multiple master-slave roles that can backup data periodically.

Both solutions are beyond the scope of this project. If the goal was to scale this application, we could potentially use these solutions. We are trading performance to be able to trust that your data is persisted to disk. For our needs, we are ok with that tradeoff.

## Testing

Basic controller tests have been added for registration and login routes.
