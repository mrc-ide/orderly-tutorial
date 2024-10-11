# orderly Tutorial

A site for [orderly2](https://mrc-ide.github.io/orderly2) training; you may prefer to go to the [actual site](https://mrc-ide.github.io/orderly-tutorial/) if you want the content.

## Development

You will need to install quarto, [start here](https://quarto.org/docs/get-started/) to do so.

You will also need a very recent versions of orderly2, the easiest way is probably

```
install.packages(
  "orderly2",
  repos = c("https://mrc-ide.r-universe.dev", "https://cloud.r-project.org"))
```

Run

```
quarto preview
```

which will open the site in a browser.  Then edit the `.qmd` pages; changes will rebuild automatically.

The site will build when pushed to GitHub, so failures will show on a PR.  It will push to `gh-pages` automatically when merged.

Documentation for quarto is [here](https://quarto.org/docs/guide/) and for revealjs presentations specifically [here](https://quarto.org/docs/presentations/revealjs/)
