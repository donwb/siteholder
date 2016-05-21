defmodule Siteholder do
	use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
        
      worker(__MODULE__, [], function: :run)
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    # opts = [name: PgTest.Sup, strategy: :one_for_one]
    opts = [strategy: :one_for_one, name: Siteholder.Supervisor]
    Supervisor.start_link(children, opts)
  end
  
  def run do
    p = System.get_env("PORT")
    
    {port, _} = 
      case p do
        nil -> {3000, nil}
        _ -> Integer.parse(p)
      end
      
    IO.puts("port: #{port}" )
    
    {:ok, _} = Plug.Adapters.Cowboy.http Siteholder.Router, [], [port: port]
    
  end
end
