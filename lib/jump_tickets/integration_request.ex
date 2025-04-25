defmodule JumpTickets.IntegrationRequest do
  alias JumpTickets.IntegrationRequest.Coordinator

  def create_integration_request(
        %{
          conversation_id: _,
          conversation_url: _,
          message_body: _
        } = params
      ) do
    Coordinator.create_request(params)
  end

  def list_integration_requests() do
    Coordinator.list_requests()
  end

  def retry_step(request_id, step) do
    Coordinator.retry_step(request_id, step)
  end

  def get_channel_id(path, idx) do
    parts = String.split(path, "/")
    Enum.at(parts, idx)
  end
end
