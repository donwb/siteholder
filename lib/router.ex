defmodule Siteholder.Router do
	use Plug.Router
	use Plug.Builder

	if Mix.env == :dev do
		IO.puts("In debug environment")
		use Plug.Debugger
	end

	plug Plug.Static, at: "/public", from: :siteholder

	plug :match
	plug :dispatch

	get "/" do
		idx = Path.join("#{:code.priv_dir(:siteholder)}", "static/index.html")
    send_file(conn, 200, idx)
	end

	match _ do
        conn
        |> send_resp(404, "404'd")
        |> halt
    end
end