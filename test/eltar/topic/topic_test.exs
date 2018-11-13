defmodule Eltar.TopicTest do
  use Eltar.DataCase

  alias Eltar.Topic

  describe "links" do
    alias Eltar.Topic.Link

    @valid_attrs %{description: "some description", title: "some title", url: "some url"}
    @update_attrs %{description: "some updated description", title: "some updated title", url: "some updated url"}
    @invalid_attrs %{description: nil, title: nil, url: nil}

    def link_fixture(attrs \\ %{}) do
      {:ok, link} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Topic.create_link()

      link
    end

    test "list_links/0 returns all links" do
      link = link_fixture()
      assert Topic.list_links() == [link]
    end

    test "get_link!/1 returns the link with given id" do
      link = link_fixture()
      assert Topic.get_link!(link.id) == link
    end

    test "create_link/1 with valid data creates a link" do
      assert {:ok, %Link{} = link} = Topic.create_link(@valid_attrs)
      assert link.description == "some description"
      assert link.title == "some title"
      assert link.url == "some url"
    end

    test "create_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Topic.create_link(@invalid_attrs)
    end

    test "update_link/2 with valid data updates the link" do
      link = link_fixture()
      assert {:ok, link} = Topic.update_link(link, @update_attrs)
      assert %Link{} = link
      assert link.description == "some updated description"
      assert link.title == "some updated title"
      assert link.url == "some updated url"
    end

    test "update_link/2 with invalid data returns error changeset" do
      link = link_fixture()
      assert {:error, %Ecto.Changeset{}} = Topic.update_link(link, @invalid_attrs)
      assert link == Topic.get_link!(link.id)
    end

    test "delete_link/1 deletes the link" do
      link = link_fixture()
      assert {:ok, %Link{}} = Topic.delete_link(link)
      assert_raise Ecto.NoResultsError, fn -> Topic.get_link!(link.id) end
    end

    test "change_link/1 returns a link changeset" do
      link = link_fixture()
      assert %Ecto.Changeset{} = Topic.change_link(link)
    end
  end
end
