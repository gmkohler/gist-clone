# REST Best Practices
  - 🔥take: prefer PUT or POST + idemKey

## Use correct response
### 200 OK
Default
### 201 Created
If you created something
### 301 Moved Permanently
### 302


### 304 Not Modified

Caching.  We can use headers to determine whether to respond with this.

This doesn't have to be a caching tier of the service, it can be the web server handling the headers and responding appropriately.

#### [`ETag`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/ETag)

A unique identiifer for the content.  For example take a SHA of a gist.

#### [`If-None-Match`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/If-None-Match)
A way to uniquely identify the actual content being served.  When the substance of this thing changes.

#### [`If-Modified-Since`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/If-None-Match)
A way to uniquely identify the actual content being served.  When the substance of this thing changes.

#### [`Expires`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Expires)

Server says "expect this shouldn't change for a day"

#### [`Cache-Control`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Cache-Control)
How long you hsou

### 400
### 401
### 403
### 404
### 405 Method not allowed
### 422
### 429 Rate limit exceeds

Some APIs support communication of what the current state of rate-limiting is; others indicate it in docs if at all.

#### Twitter

`X-Rate-Limit-Limit` is relating to queries per interval.

`X-Rate-Limit-Remaining` is whether you've exceeded the rate limit.

`X-Rate-Limit-Reset` is when you can start requesting again.

### 500

## content negotiation

### `Content-Type`

What the format of the request its

### `Accept`

What a request will accept

## Pagination

This is a better idea to put it in the query params.

### Stripe

They support  `?limit` and `?starting_after`/`?ending_before`

### `Content-Range` / `Link`

People want to put this

## Compression

`Accept-Encoding` / `Content-Encoding`

## Versioning

You should be careful to design API in a way such that the API doesn't break.

Often you'll see the version in the namespace:

`v1/users`

`v2/users`

## HATEOAS

Hypertext as the Engine of Application State.  _e.g._, you provide links for resources, pagination, etc.

### Object Expansion (Stripe)

You can specify in the request whether you want associated resources

## Batch updates

No standard way to do this; GraphQL addresses this explicitly.

# User stories

- [x] User can create gist
  - [ ] User can see the current state of the gist

- [ ] User can revise gist
  - POST revisions or PUT gist?

- [ ] User can view a list of revisions to gist
- [ ] User can delete a gist
- [ ] User can subscribe to a gist

- [ ] Gist knows about its "last active" status
  - [ ] most recent revision duh


- [ ] User can comment on gist
  - [ ] table comments (user gist)

- [ ] User can fork gist from another user


## Making use of the filesystem as part of the database
```sh
git diff > tmp/diff.patch
git apply < tmp/diff.patch
```
```sh
git diff | pbcopy
```

```rb
```


What's the story for the current views
