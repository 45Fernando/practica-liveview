defmodule PracticaLiveviewWeb.ProvinceLiveTest do
  use PracticaLiveviewWeb.ConnCase

  import Phoenix.LiveViewTest

  alias PracticaLiveview.Provinces

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp fixture(:province) do
    {:ok, province} = Provinces.create_province(@create_attrs)
    province
  end

  defp create_province(_) do
    province = fixture(:province)
    %{province: province}
  end

  describe "Index" do
    setup [:create_province]

    test "lists all provinces", %{conn: conn, province: province} do
      {:ok, _index_live, html} = live(conn, Routes.province_index_path(conn, :index))

      assert html =~ "Listing Provinces"
      assert html =~ province.name
    end

    test "saves new province", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.province_index_path(conn, :index))

      assert index_live |> element("a", "New Province") |> render_click() =~
               "New Province"

      assert_patch(index_live, Routes.province_index_path(conn, :new))

      assert index_live
             |> form("#province-form", province: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#province-form", province: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.province_index_path(conn, :index))

      assert html =~ "Province created successfully"
      assert html =~ "some name"
    end

    test "updates province in listing", %{conn: conn, province: province} do
      {:ok, index_live, _html} = live(conn, Routes.province_index_path(conn, :index))

      assert index_live |> element("#province-#{province.id} a", "Edit") |> render_click() =~
               "Edit Province"

      assert_patch(index_live, Routes.province_index_path(conn, :edit, province))

      assert index_live
             |> form("#province-form", province: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#province-form", province: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.province_index_path(conn, :index))

      assert html =~ "Province updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes province in listing", %{conn: conn, province: province} do
      {:ok, index_live, _html} = live(conn, Routes.province_index_path(conn, :index))

      assert index_live |> element("#province-#{province.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#province-#{province.id}")
    end
  end

  describe "Show" do
    setup [:create_province]

    test "displays province", %{conn: conn, province: province} do
      {:ok, _show_live, html} = live(conn, Routes.province_show_path(conn, :show, province))

      assert html =~ "Show Province"
      assert html =~ province.name
    end

    test "updates province within modal", %{conn: conn, province: province} do
      {:ok, show_live, _html} = live(conn, Routes.province_show_path(conn, :show, province))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Province"

      assert_patch(show_live, Routes.province_show_path(conn, :edit, province))

      assert show_live
             |> form("#province-form", province: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#province-form", province: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.province_show_path(conn, :show, province))

      assert html =~ "Province updated successfully"
      assert html =~ "some updated name"
    end
  end
end
