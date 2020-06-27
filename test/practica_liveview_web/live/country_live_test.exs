defmodule PracticaLiveviewWeb.CountryLiveTest do
  use PracticaLiveviewWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PracticaLiveview.Countries

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp fixture(:country) do
    {:ok, country} = Countries.create_country(@create_attrs)
    country
  end

  defp create_country(_) do
    country = fixture(:country)
    %{country: country}
  end

  describe "Index" do
    setup [:create_country]

    test "lists all countries", %{conn: conn, country: country} do
      {:ok, _index_live, html} = live(conn, Routes.country_index_path(conn, :index))

      assert html =~ "Listing Countries"
      assert html =~ country.name
    end

    test "saves new country", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.country_index_path(conn, :index))

      assert index_live |> element("a", "New Country") |> render_click() =~
               "New Country"

      assert_patch(index_live, Routes.country_index_path(conn, :new))

      assert index_live
             |> form("#country-form", country: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#country-form", country: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.country_index_path(conn, :index))

      assert html =~ "Country created successfully"
      assert html =~ "some name"
    end

    test "updates country in listing", %{conn: conn, country: country} do
      {:ok, index_live, _html} = live(conn, Routes.country_index_path(conn, :index))

      assert index_live |> element("#country-#{country.id} a", "Edit") |> render_click() =~
               "Edit Country"

      assert_patch(index_live, Routes.country_index_path(conn, :edit, country))

      assert index_live
             |> form("#country-form", country: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#country-form", country: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.country_index_path(conn, :index))

      assert html =~ "Country updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes country in listing", %{conn: conn, country: country} do
      {:ok, index_live, _html} = live(conn, Routes.country_index_path(conn, :index))

      assert index_live |> element("#country-#{country.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#country-#{country.id}")
    end
  end

  describe "Show" do
    setup [:create_country]

    test "displays country", %{conn: conn, country: country} do
      {:ok, _show_live, html} = live(conn, Routes.country_show_path(conn, :show, country))

      assert html =~ "Show Country"
      assert html =~ country.name
    end

    test "updates country within modal", %{conn: conn, country: country} do
      {:ok, show_live, _html} = live(conn, Routes.country_show_path(conn, :show, country))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Country"

      assert_patch(show_live, Routes.country_show_path(conn, :edit, country))

      assert show_live
             |> form("#country-form", country: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#country-form", country: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.country_show_path(conn, :show, country))

      assert html =~ "Country updated successfully"
      assert html =~ "some updated name"
    end
  end
end
