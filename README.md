# Sello Theme

> The theme applied to all Sello shops.

## Setup

First, make sure you have the [shopify_theme](http://github.com/Shopify/shopify_theme) gem installed.

```bash
$ gem install shopify_theme

```

Rename `config.yml.example` to `config.yml` and fill in the missing information by following these [setup instructions](https://github.com/Shopify/shopify_theme#usage).

Then, install Grunt and it's dependencies.

```bash
$ cd ~/sello-theme
$ npm install
```

## Development

From the root directory of the repo, run Grunt to watch and compile SASS as well as sync your changed files to your development shop.

```bash
$ grunt
```

## Preview and Testing

If your Sello shop was created after May 20th 2015, there's a good chance your theme is up to date. If your shop was created before that date, you can preview the latest build on [jane-smith.sello.com](https://jane-smith.sello.com/). Use this shop, when possible, for bug hunting.
