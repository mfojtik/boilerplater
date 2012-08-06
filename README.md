Boilerplater
=============

Boilerplater is handy tool that helps me get over the boring process
of creating new applications/test files/rake files/etc. in Ruby.
You know it, you got an idea but the process of getting all files in
place is boring and slows you down. In the end you find yourself dealing
with with CSS and DataMapper configuration than working on the 'real'
application logic.

How it works?
--------

I like to store my boiler plates somewhere where everyone can see them
but also I can have some private ones. Also I want to have all templates
in GIT, so I can easely update them once they are outdated. Yes, i'm looking
at you GIST.

All boilerplates are just GIST snippets with the 'right' formatting. To store
list of available boilerplates I use special public GIST#[3266785](https://gist.github.com/3266785).
Everyone who wants to share his boilerplates and bootstrap files is welcomed
to open an pull request on that GIST.

To see how the actual boilerplate looks like navigate to GIST#[3265768](https://gist.github.com/3265768).
Each file is annotated by the '^##' line with target filename. The bottom
content will be saved to that file. Also you can 'link' to remote files if you
want. They will be downloaded to your project folder.

Usage
--------

Boilerplater cames with simple 'bp' command:

        Usage: bp command [id|alias|action] [options]

        Commands:

          bp list                         - List all boilerplates
          bp search [name]                - Search for boilerplate
          bp show   [id|alias]            - Show boilerplate details
          bp use    [id|alias]            - Apply boilerplate
          bp alias  create [id]    [name] - Create alias for boilerplate
          bp alias  delete [name]         - Delete alias
          bp alias  list                  - List all aliases

        Options:
          --prefix, -p <s>:   Prefix for boilerplate files (default: .)
                --help, -h:   Show this message

To fetch and use boilerplate, just type:

    $ bp use 3265768

    Setting up new project using BPR: Sample template

      [create  ] test/./Gemfile
      [create  ] test/./app.rb
      [create  ] test/views/index.haml
      [create  ] test/views/layout.haml
      [download] test/public/css/bootstrap.css
      [download] test/public/css/bootstrap-responsive.css

    done.

The [Sinatra application](https://gist.github.com/3265768) boilerplate
will be installed into the current directory. If you want to install it
somewhere else, use the '--prefix' parameter.

Since the numeric ID is really challenge to remember, 'bp' has simple
aliasing system to create your own local aliases:

    $ bp alias create 3265768 sinatra

Then instead of using the 3265768 you can use 'sinatra' everytime you use
the 'use' or 'show operation.
