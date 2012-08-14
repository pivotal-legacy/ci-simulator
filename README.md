# CI Server Simulator

Used to simulate CI servers for usage by ProjectMonitor.

NOTE: When updating a project, this tool will silently fail if you get the
wrong type/url combination.

## Command Line

Post a spontaneous webhook like so:

    bin/cisimulator.rb -e http://localhost:3000/projects/c1fbbfc1-6fc3-4c61-8840-9be43bcefed9/status -i 3 -s 1 -t jenkins

Invoked without any parameters and you'll get a usage message.

## Web app

Launch the web app like so:

    bin/frontend.rb

Then point your browser at http://localhost:4567/
