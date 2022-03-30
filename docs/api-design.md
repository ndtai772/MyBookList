# API design

-– by @Nguyễn Đức Tài

## Analysis

Use role-based access control.

Roles:

- Any: any guest can access (aka public resources)
- User: anyone with a valid user account could access
- Owner(:resource_id): owner/creator of resource
- Manager: only specific people with a manager account

Resources:

|          | Create  | View             | Update           | Delete           |
| -------- | ------- | ---------------- | ---------------- | ---------------- |
| Account  | Any     | Any              | Owner or Manager | Owner or Manager |
| Book     | Manager | Any              | Manager          | Manager          |
| Category | Manager | Any              | Manager          | Manager          |
| Comment  | User    | Any              | Owner            | Owner or Manager |
| Feedback | User    | Owner or Manager | Owner or Manager | Owner or Manager |
| Rating   | User    | Any              | -                | Owner            |
| Bookmark | User    | Owner            | -                | Owner            |

**Note**: Since books may have many properties (authors, categories, publisher, year of publication, ISBN, ...), searching and grouping properties as resources may become really complicated and make the project couldn’t even finish, so we deceived to have a minimum workable version of API fist with some kind of book properties that really necessary (categories).

## REST API

BASE_URL: `https://api.mybooklist.com/v0.1/{{endpoints}}`

> TODO: consider redesign - using /account/{:id} instead of /profile ? \
> TODO: consider redesign - /bookmarks?account_id=$ instead of /bookmarks (and feedbacks, rates too) \
> TODO: naming - is `ratings` or `votes` better than rates ?

General endpoints:

|                   | GET                                | POST                                     | PUT                               | PATCH                               | DELETE                         |
| ----------------- | ---------------------------------- | ---------------------------------------- | --------------------------------- | ----------------------------------- | ------------------------------ |
| /login            | -                                  | log a user in                            | -                                 | -                                   | -                              |
| /accounts         | -                                  | create a new user account                | -                                 | -                                   | -                              |
| /accounts/{:id}   | view user account info             | -                                        | -                                 | update a part of account info       | delete a specific user account |
| /books            | list all books                     | add new book                             | -                                 | -                                   | -                              |
| /books/{:id}      | get a specific book info           | -                                        | -                                 | update a part of specific book info | delete a specific book         |
| /categories       | list all book categories available | add new book categories                  | -                                 | -                                   | -                              |
| /categories/{:id} | -                                  | -                                        | update a specific category info   | -                                   | delete a specific category     |
| /comments         | list all user comments             | create a new comment                     | -                                 | -                                   | -                              |
| /comments/{:id}   | get a comment content              | -                                        | update a specific comment content | -                                   | delete a specific comment      |
| /bookmarks        | list all personal bookmarks        | add a new book to personal bookmark list | -                                 | -                                   | -                              |
| /bookmarks/{:id}  | get a bookmark item info           | -                                        | -                                 | -                                   | remove a specific bookmark     |
| /feedbacks        | list all feedback from users       | create new feedback                      | -                                 | -                                   | -                              |
| /feedbacks/{:id}  | get a specific feedback detail     | -                                        | -                                 | update a specific feedback          | delete a specific feedback     |
| /rates            | list all personal rating           | create new rating about a book           | -                                 | -                                   | -                              |
| /rates/{:id}      | -                                  | -                                        | -                                 | -                                   | delete a specific rating       |

Search/filterable endpoints (GET only)

- `/books/?author_like=$?title_like=$category_id=?`
- `/comments/?thread_id=$`: any comment created will belong to a *thread,* a *thread* is something that contains comments, when a book was added, a thread contain all comments directly to that books will also be created, when a user add a reply to a comment, the original comment will become a *thread*.
- `/feedbacks/?account_id=$`
- `/rate/?book_id=$`

Paginate responses:

- `/accounts`
- `/books`
- `/rates`
- `/comments`
