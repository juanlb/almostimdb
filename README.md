# ItCrowd Challenge

## Almost IMDB

### Libraries / Frameworks

* Ruby 2.6.3
* Ruby on Rails 5.2.3
* Rspec
* MySQL
* Docker
* JWT
* json:api

`Ruby on Rails` is perfect for API and Backend development.
It is flexible enough to build solutions with little steps, wich allows make easy and fast corrections.
RoR was created with testing inside, beacause of that, using the right tools you can deliver a 100% tested app.
I use `Rspec` because it allows make better and clearer tests. All the RoR comunity support it.

I've use the "full" version of RoR for this challenge because the app needs API and UI modules.
If only API is needed, RoR allows create an app with only API modules includes. This is usefull to get a smaller app without innecesary modules, like view rendering or assets managment.

`MySQL` is a great DB that works really good with RoR, I've used it for years and I chose it for this challenge because I think that have all the necessary to create a robust solution.

I deployed the app with `Docker` on `AWS ECS` (Elastic Container Service).
Docker is the devop best friend :-)
On `AWS` I used: ECS, Application Load Balancer and MySQL RDS.
To get HTTPS I used the feature that provides the Application Load Balancer.

I've choosed `JWT` to secure the API unsafe methods, because is strong, easy and allows that other services creates valid tokens to be used with this API.
For example, if I give the JWT secret to the developers of the `existing website` mentioned on the challenge, they could create valid JWT for existing users.

`json:api` is more a standard that a library. It is a good way to get the API responses organized.
I use the `fast_jsonapi` gem, that simplify that work and ensures that the result have always the same structure.

### Gems

**roman-numerals**:
The challenge needs roman numerals, and 85.000 dev downloaded this gem... what could be wrong?

**figaro**:
Great gem to get ENV variables organized.

**simplecov**:
Code coverage tool.

**devise**:
From the github repo: Devise is a flexible authentication solution for Rails based on Warden. It:
* Is Rack based;
* Is a complete MVC solution based on Rails engines;
* Allows you to have multiple models signed in at the same time;
* Is based on a modularity concept: use only what you really need.

# API Docs

Inside this repo there is a file called `ItCrowd.postman_collection.json`. It is Postman collection to use and test the API.
Once imported, you have to create a `enviroment` and create the variable `host`.

If use on localhost:
```
host = http://localhost:3000/api/v1
```

If use deployed app:
```
host = https://almostimdb.snappler-app/api/v1
```

The security is also configured. The unsafe methods needs a JWT as a `Bearer token`.

The `ItCrowd` collection has the security setted. The unsafe methods inherits from this configuration.

## Get the JWT
Other way to get a valid `JWT` to use the API is registering a new user on `http://localhost:3000/users/sign_in`.
Once crated and logged in, you can see on the sidebar the `API Key` section, there you can found the valid `JWT` for your user.

# API Endpoints

### GET /api/v1/people
* Publicly available
* Show all people
The references to movies are in the `includes` section. That is for the json:api standard
```
{
    "data": [
        {
            "id": "1",
            "type": "person",
            "attributes": {
                "first_name": "Harrison",
                "last_name": "Ford",
                "aliases": "Han Solo, Indiana Jones",
                "full_name": "Harrison Ford (Han Solo, Indiana Jones)"
            },
            "relationships": {
                "movies_as_director": {
                    "data": [
                        {
                            "id": "1",
                            "type": "movie"
                        },
                        {
                            "id": "2",
                            "type": "movie"
                        }
                    ]
                },
                "movies_as_producer": {
                    "data": []
                },
                "movies_as_member": {
                    "data": [
                        {
                            "id": "1",
                            "type": "movie"
                        }
                    ]
                }
            },
            "links": {
                "self": "http://localhost:3000/api/v1/people/1"
            }
        },
        {
            "id": "2",
            "type": "person",
            "attributes": {
                "first_name": "Ian",
                "last_name": "McKellen",
                "aliases": "Gandalf, Magneto",
                "full_name": "Ian McKellen (Gandalf, Magneto)"
            },
            "relationships": {
                "movies_as_director": {
                    "data": []
                },
                "movies_as_producer": {
                    "data": [
                        {
                            "id": "1",
                            "type": "movie"
                        }
                    ]
                },
                "movies_as_member": {
                    "data": []
                }
            },
            "links": {
                "self": "http://localhost:3000/api/v1/people/2"
            }
        }
    ],
    "included": [
        {
            "id": "1",
            "type": "movie",
            "attributes": {
                "title": "Star Wars"
            },
            "links": {
                "self": "http://localhost:3000/api/v1/movies/1"
            }
        },
        {
            "id": "2",
            "type": "movie",
            "attributes": {
                "title": "Lord of the Rings"
            },
            "links": {
                "self": "http://localhost:3000/api/v1/movies/2"
            }
        }
    ]
}
```

### GET /api/v1/people/:id
* Publicly available
* Show one person
* 404 if not found
```
{
    "data": {
        "id": "1",
        "type": "person",
        "attributes": {
            "first_name": "Harrison",
            "last_name": "Ford",
            "aliases": "Han Solo, Indiana Jones",
            "full_name": "Harrison Ford (Han Solo, Indiana Jones)"
        },
        "relationships": {
            "movies_as_director": {
                "data": [
                    {
                        "id": "1",
                        "type": "movie"
                    },
                    {
                        "id": "2",
                        "type": "movie"
                    }
                ]
            },
            "movies_as_producer": {
                "data": []
            },
            "movies_as_member": {
                "data": [
                    {
                        "id": "1",
                        "type": "movie"
                    }
                ]
            }
        },
        "links": {
            "self": "http://localhost:3000/api/v1/people/1"
        }
    },
    "included": [
        {
            "id": "1",
            "type": "movie",
            "attributes": {
                "title": "Star Wars"
            },
            "links": {
                "self": "http://localhost:3000/api/v1/movies/1"
            }
        },
        {
            "id": "2",
            "type": "movie",
            "attributes": {
                "title": "Lord of the Rings"
            },
            "links": {
                "self": "http://localhost:3000/api/v1/movies/2"
            }
        }
    ]
}
```
### POST /api/v1/people
* Secured endpoint
* Create a person
```
{
	"first_name": "John",
	"last_name": "Doe",
	"aliases": "The Kid"
}
```
* first_name: required
* last_name: required
* aliases: optional
### PUT /api/v1/people/:id
* Secured endpoint
* Update a person
* 404 if not found
```
{
	"first_name": "Peter",
	"last_name": "Smith",
	"aliases": "The Awesome"
}
```
* first_name: not null
* last_name: not null
* aliases: optional
### DELETE /api/v1/people/:id
* Secured endpoint
* Delete a person
* 404 if not found
### GET /api/v1/movies
* Publicly available
* Show all movies
The references to people are in the `includes` section. That is for the json:api standard
```
{
    "data": [
        {
            "id": "1",
            "type": "movie",
            "attributes": {
                "title": "Star Wars",
                "release_year": "MCMLXXVII"
            },
            "relationships": {
                "directors": {
                    "data": [
                        {
                            "id": "1",
                            "type": "person"
                        }
                    ],
                    "links": {
                        "related": "http://localhost:3000/api/v1/movies/1/directors"
                    }
                },
                "producers": {
                    "data": [
                        {
                            "id": "2",
                            "type": "person"
                        }
                    ],
                    "links": {
                        "related": "http://localhost:3000/api/v1/movies/1/producers"
                    }
                },
                "casting": {
                    "data": [
                        {
                            "id": "1",
                            "type": "person"
                        }
                    ],
                    "links": {
                        "related": "http://localhost:3000/api/v1/movies/1/cast"
                    }
                }
            },
            "links": {
                "self": "http://localhost:3000/api/v1/movies/1"
            }
        },
        {
            "id": "2",
            "type": "movie",
            "attributes": {
                "title": "Lord of the Rings",
                "release_year": "MMI"
            },
            "relationships": {
                "directors": {
                    "data": [
                        {
                            "id": "1",
                            "type": "person"
                        }
                    ],
                    "links": {
                        "related": "http://localhost:3000/api/v1/movies/2/directors"
                    }
                },
                "producers": {
                    "data": [],
                    "links": {
                        "related": "http://localhost:3000/api/v1/movies/2/producers"
                    }
                },
                "casting": {
                    "data": [],
                    "links": {
                        "related": "http://localhost:3000/api/v1/movies/2/cast"
                    }
                }
            },
            "links": {
                "self": "http://localhost:3000/api/v1/movies/2"
            }
        }
    ],
    "included": [
        {
            "id": "1",
            "type": "person",
            "attributes": {
                "first_name": "Harrison",
                "last_name": "Ford",
                "aliases": "Han Solo, Indiana Jones"
            },
            "links": {
                "self": "http://localhost:3000/api/v1/people/1"
            }
        },
        {
            "id": "2",
            "type": "person",
            "attributes": {
                "first_name": "Ian",
                "last_name": "McKellen",
                "aliases": "Gandalf, Magneto"
            },
            "links": {
                "self": "http://localhost:3000/api/v1/people/2"
            }
        }
    ]
}
```
### GET /api/v1/movies/:id
* Publicly available
* Show one movie
* 404 if not found
```
{
    "data": {
        "id": "1",
        "type": "movie",
        "attributes": {
            "title": "Star Wars",
            "release_year": "MCMLXXVII"
        },
        "relationships": {
            "directors": {
                "data": [
                    {
                        "id": "1",
                        "type": "person"
                    }
                ],
                "links": {
                    "related": "http://localhost:3000/api/v1/movies/1/directors"
                }
            },
            "producers": {
                "data": [
                    {
                        "id": "2",
                        "type": "person"
                    }
                ],
                "links": {
                    "related": "http://localhost:3000/api/v1/movies/1/producers"
                }
            },
            "casting": {
                "data": [
                    {
                        "id": "1",
                        "type": "person"
                    }
                ],
                "links": {
                    "related": "http://localhost:3000/api/v1/movies/1/cast"
                }
            }
        },
        "links": {
            "self": "http://localhost:3000/api/v1/movies/1"
        }
    },
    "included": [
        {
            "id": "1",
            "type": "person",
            "attributes": {
                "first_name": "Harrison",
                "last_name": "Ford",
                "aliases": "Han Solo, Indiana Jones"
            },
            "links": {
                "self": "http://localhost:3000/api/v1/people/1"
            }
        },
        {
            "id": "2",
            "type": "person",
            "attributes": {
                "first_name": "Ian",
                "last_name": "McKellen",
                "aliases": "Gandalf, Magneto"
            },
            "links": {
                "self": "http://localhost:3000/api/v1/people/2"
            }
        }
    ]
}
```
### POST /api/v1/movies
* Secured endpoint
* Create a movie
```
{
	"title": "Avengers",
	"release_year": 1979
}
```
* title: required
* release_year: required
### PUT /api/v1/movies/:id
* Secured endpoint
* Update a movie
* 404 if not found
```
{
	"title": "AvengersX",
	"release_year": 2000
}
```
* title: not null
* release_year: not null
### DELETE /api/v1/movies/:id
* Secured endpoint
* Delete a movie
* 404 if not found
### GET /api/v1/movies/:movie_id/directors
* Publicly available
* Show all directors from a movie
### POST /api/v1/movies/:movie_id/directors
* Secured endpoint
* Add existing person as director for a movie
* Can't be duplicated relation
```
{
	"person_id": 2
}
```
### DELETE /api/v1/movies/:movie_id/directors/:id
* Secured endpoint
* Remove a director for a movie
* 404 if not found
### GET /api/v1/movies/:movie_id/producers
* Publicly available
* Show all producers from a movie
### POST /api/v1/movies/:movie_id/producers
* Secured endpoint
* Add existing person as producer for a movie
* Can't be duplicated relation
```
{
	"person_id": 2
}
```
### DELETE /api/v1/movies/:movie_id/producers/:id
* Secured endpoint
* Remove a producer for a movie
* 404 if not found
### GET /api/v1/movies/:movie_id/cast
* Publicly available
* Show the cast from a movie
### POST /api/v1/movies/:movie_id/cast
* Secured endpoint
* Add existing person as cast for a movie
* Can't be duplicated relation
```
{
	"person_id": 2
}
```
### DELETE /api/v1/movies/:movie_id/cast/:id
* Secured endpoint
* Remove a cast for a movie
* 404 if not found
