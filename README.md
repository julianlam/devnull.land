# Hi.

This is the minmalist engine that powers https://devnull.land

Feel free to fork it.

It uses [express](expressjs.com/), [benchpress](https://github.com/benchpressjs/benchpressjs), and [Milligram](//milligram.io). Blog posts are parsed using [markdown-it](https://github.com/markdown-it/markdown-it).

[Read more about it here](https://devnull.land/github-gist-blog).

## Configuring and running the site

It listens on port 3000. You'll probably want nginx in front to proxy requests to this app.

`node index.js` starts the app. You'll probably want a nice `systemd` config to automate running this (and restarting if it falls over.)

There are two configuration variables:

* `BASE_URL` &ndash; is the URL of the site, it is used in the sitemap *(default: `devnull.land`)*
* `GITHUB_USERNAME` &ndash; is your GitHub username. This app uses your username to get your gists *(default: `julianlam`)*

## Adding blog posts

[Create a gist](//gist.github.com/), ensuring that the suffix `#blog` is added to the end of your gist description.

* The first filename with `.md` automatically becomes the url of the page (the `.md` suffix is stripped out), and is your blog post, written in [Markdown](https://commonmark.org/help/).
* You can create a `meta.json` file in your gist as well, which supports the following root-level properties
    * `timestamp` &ndash; a UNIX timestamp, if you want to backdate your blog post, otherwise the gist creation date is used.