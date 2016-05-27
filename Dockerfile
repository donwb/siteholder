FROM donwb/elixir:0.3
MAINTAINER Don Browning

# Make sure mix is good
RUN mix local.rebar
RUN mix local.hex --force


## Install the app ##

# We assume the deps have already been fetched
ADD . /opt/siteholder


## Compile ##

# It is important to set MIX_ENV *before* compiling the code
ENV MIX_ENV dev

WORKDIR /opt/siteholder

# Compile and build the release
RUN mix compile
Run mix release

## Running environment ##

ENV PORT 3000

# This shouldn't be the way to do it, but it keeps the container running
CMD ["iex", "-S", "mix"]

# Still can't keep container running using exrm 
# CMD ["/opt/siteholder/rel/siteholder/bin/siteholder", "start"]




