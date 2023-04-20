# %sites

Inspired by [`%blog`](https://github.com/tadad/blog).

Serve html files directly out of a folder structure in `/app/files`.

Configure permissions using [`%login`](https://github.com/niblyx-malnus/login) in the `config.sites-0` file.

Can use html and css.

html and css files stored in `/app/files/this/is/a/path.html` will be available at: `[your-domain]/site/this/is/a/path[.html]`  (notice `/app/files -> /site`)

Use the `config.sites-0` file to gate specific paths (and all their subpaths) according to a `bloc` using `%login`.

The `config.sites-0` is a list of `(pair path (unit bloc-path))` where the `path` corresponds to the path within
`/app/files` and the `(unit bloc-path)` is the `%login` `bloc-path` associated with the grouping you want to give access to your site. Anything not covered by the `config.sites-0` will be public. (Actually I should probably make this so that it's ONLY YOU in the typical way...)

Toy project. Rough around the edges.

## Installation
1. Clone this repo.
2. Boot up a ship (fakezod or moon or whatever you use).
4. `|new-desk %sites` to create a new desk called `%sites`.
5. `|mount %sites` to access the `%sites` desk from the unix command line.
6. At the unix command line `rm -rf [ship-name]/sites/*` to empty out the contents of the desk.
7. `cp -r sites/desk/* [ship-name]/sites` to copy the contents of this repo into your new desk.
8. At the dojo command line `|commit %sites`.
9. Install with `|install our %sites`.
