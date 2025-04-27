defmodule JumpTicketsWeb.TicketDoneController do
  use JumpTicketsWeb, :controller

  alias JumpTickets.Ticket
  alias JumpTickets.External.Notion
  alias JumpTickets.Ticket.DoneNotifier

  @doc """
  Handles a Notion webhook for when a ticket is marked as Done.

  Expects a payload containing a page entity id.
  """

  def notion_webhook(conn, %{"entity" => %{"id" => page_id}}) do
    case Notion.get_ticket_by_page_id(page_id) do
      %Ticket{} = ticket ->
        DoneNotifier.notify_ticket_done(ticket)

        json(conn, %{status: "ok", message: "Ticket done notification sent."})

      {:error, reason} ->
        conn
        |> put_status(400)
        |> json(%{status: "error", error: reason})
    end
  end

  def notion_webhook(conn, params) do
    conn
    |> put_status(400)
    |> json(%{status: "error", message: "Invalid webhook payload"})
  end
end
