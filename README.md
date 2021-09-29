# Hi.

This is the minmalist engine that powers https://devnull.land

Feel free to fork it.

It uses [express](expressjs.com/), [benchpress](https://github.com/benchpressjs/benchpressjs), and [Milligram](//milligram.io).

[Read more about it here](https://devnull.land/github-gist-blog).

## Configuring and running the site

It listens on port 3000. You'll probably want nginx in front to proxy requests to this app.

`node index.js` starts the app. You'll probably want a nice `systemd` config to automate running this (and restarting if it falls over.)

The config is hardcoded in `index.js`, change it as necessary to suit your site.