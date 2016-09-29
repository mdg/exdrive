# Exdrive

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: http://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

## Prioritization

Distributor.Supervisor
-> start server

Distributor.Server
-> start
   N0 Distributor.Worker(P0)
   N1 Distributor.Worker(P1)
   hold map {prio,id} => pids

Messages
-> more/less of prioN
   diff and convert to set #
-> set # of prioN
   msg those above threshold to die
   create more if below threshold
-> set balance for priorities
   set # for all priorities

Pipe.Supervisor
-> transient

Pipe.Worker
-> pip

-> monitor workers?
