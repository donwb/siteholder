defmodule Siteholder.Router do
	use Plug.Router
	use Plug.Builder

	if Mix.env == :dev do
		IO.puts("In debug environment")
		use Plug.Debugger
	end

	plug Plug.Static, at: "/public", from: Siteholder

	plug :match
	plug :dispatch

	get "/" do
		IO.puts("root route")
		conn
		|>send_resp(200, "done")
	end
end