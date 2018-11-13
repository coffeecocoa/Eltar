defmodule Eltar.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :url, :string
      add :title, :string
      add :description, :text
      add :user_id, references(:links, on_delete: :nothing)

      timestamps()
    end

    create index(:links, [:user_id])
  end
end
