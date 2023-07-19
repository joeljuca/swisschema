defmodule SwissSchema do
  @moduledoc """
  Documentation for `SwissSchema`.
  """

  defmacro __using__(opts) do
    repo = Keyword.fetch!(opts, :repo)

    quote do
      @spec aggregate(
              type :: :count,
              opts :: Keyword.t()
            ) :: term() | nil
      def aggregate(:count) do
        unquote(repo).aggregate(__MODULE__, :count)
      end

      def aggregate(:count, opts) do
        unquote(repo).aggregate(__MODULE__, :count, opts)
      end

      @spec aggregate(
              type :: :avg | :count | :max | :min | :sum,
              field :: atom(),
              opts :: Keyword.t()
            ) :: term() | nil
      def aggregate(type, field, opts \\ []) do
        unquote(repo).aggregate(__MODULE__, type, field, opts)
      end

      @spec all(opts :: Keyword.t()) :: [Ecto.Schema.t() | term()]
      def all(opts \\ []) do
        unquote(repo).all(__MODULE__, opts)
      end

      @spec create(
              params :: %{required(atom()) => term()},
              opts :: Keyword.t()
            ) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}
      def create(%{} = params, opts \\ []) do
        changeset = Function.capture(__MODULE__, :changeset, 2)

        struct(__MODULE__)
        |> changeset.(params)
        |> unquote(repo).insert(opts)
      end

      @spec create!(
              params :: %{required(atom()) => term()},
              opts :: Keyword.t()
            ) :: Ecto.Schema.t()
      def create!(%{} = params, opts \\ []) do
        changeset = Function.capture(__MODULE__, :changeset, 2)

        struct(__MODULE__)
        |> changeset.(params)
        |> unquote(repo).insert!(opts)
      end

      @spec delete(
              schema :: Ecto.Schema.t(),
              opts :: Keyword.t()
            ) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}
      def delete(%{__struct__: __MODULE__} = schema, opts \\ []) do
        unquote(repo).delete(schema, opts)
      end

      @spec delete!(
              schema :: Ecto.Schema.t(),
              opts :: Keyword.t()
            ) :: Ecto.Schema.t()
      def delete!(%{__struct__: __MODULE__} = schema, opts \\ []) do
        unquote(repo).delete!(schema, opts)
      end

      @spec delete_all(opts :: Keyword.t()) :: {non_neg_integer(), nil | [term()]}
      def delete_all(opts \\ []) do
        unquote(repo).delete_all(__MODULE__, opts)
      end

      @spec get(
              id :: term(),
              opts :: Keyword.t()
            ) :: {:ok, Ecto.Schema.t()} | {:ok, term()} | {:error, :not_found}
      def get(id, opts \\ []) do
        case unquote(repo).get(__MODULE__, id, opts) do
          %{} = schema -> {:ok, schema}
          nil -> {:error, :not_found}
        end
      end

      @spec get!(
              id :: term(),
              opts :: Keyword.t()
            ) :: Ecto.Schema.t() | term()
      def get!(id, opts \\ []) do
        unquote(repo).get!(__MODULE__, id, opts)
      end

      @spec get_by(
              clauses :: Keyword.t() | map(),
              opts :: Keyword.t()
            ) :: {:ok, Ecto.Schema.t()} | {:ok, term()} | {:error, :not_found}
      def get_by(clauses, opts \\ []) do
        case unquote(repo).get_by(__MODULE__, clauses, opts) do
          %{} = schema -> {:ok, schema}
          nil -> {:error, :not_found}
        end
      end

      @spec get_by!(
              clauses :: Keyword.t() | map(),
              opts :: Keyword.t()
            ) :: Ecto.Schema.t() | term()
      def get_by!(clauses, opts \\ []) do
        unquote(repo).get_by!(__MODULE__, clauses, opts)
      end

      @spec insert(
              params :: %{required(atom()) => term()},
              opts :: Keyword.t()
            ) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}
      def insert(%{} = params, opts \\ []) do
        changeset = Function.capture(__MODULE__, :changeset, 2)

        struct(__MODULE__)
        |> changeset.(params)
        |> unquote(repo).insert(opts)
      end

      @spec insert!(
              params :: %{required(atom()) => term()},
              opts :: Keyword.t()
            ) :: Ecto.Schema.t()
      def insert!(%{} = params, opts \\ []) do
        changeset = Function.capture(__MODULE__, :changeset, 2)

        struct(__MODULE__)
        |> changeset.(params)
        |> unquote(repo).insert!(opts)
      end

      @spec insert_all(
              entries :: [%{required(atom()) => term()}] | Keyword.t(),
              opts :: Keyword.t()
            ) :: {non_neg_integer(), nil | [term()]}
      def insert_all(entries, opts \\ []) do
        unquote(repo).insert_all(__MODULE__, entries, opts)
      end

      @spec insert_or_update(
              changeset :: Ecto.Changeset.t(),
              opts :: Keyword.t()
            ) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}
      def insert_or_update(%Ecto.Changeset{} = changeset, opts \\ []) do
        unquote(repo).insert_or_update(changeset, opts)
      end

      @spec insert_or_update!(
              changeset :: Ecto.Changeset.t(),
              opts :: Keyword.t()
            ) :: Ecto.Schema.t()
      def insert_or_update!(%Ecto.Changeset{} = changeset, opts \\ []) do
        unquote(repo).insert_or_update!(changeset, opts)
      end

      @spec stream(opts :: Keyword.t()) :: Enum.t()
      def stream(opts \\ []) do
        unquote(repo).stream(__MODULE__, opts)
      end

      @spec update(
              schema :: Ecto.Schema.t(),
              params :: %{required(atom()) => term()},
              opts :: Keyword.t()
            ) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}
      def update(%{__struct__: __MODULE__} = schema, %{} = params, opts \\ []) do
        changeset = Function.capture(__MODULE__, :changeset, 2)

        schema
        |> changeset.(params)
        |> unquote(repo).update(opts)
      end

      @spec update!(
              schema :: Ecto.Schema.t(),
              params :: %{required(atom()) => term()},
              opts :: Keyword.t()
            ) :: Ecto.Schema.t()
      def update!(%{__struct__: __MODULE__} = schema, %{} = params, opts \\ []) do
        changeset = Function.capture(__MODULE__, :changeset, 2)

        schema
        |> changeset.(params)
        |> unquote(repo).update!(opts)
      end

      @spec update_all(
              updates :: Keyword.t(),
              opts :: Keyword.t()
            ) :: {non_neg_integer(), nil | [term()]}
      def update_all(updates, opts \\ []) do
        unquote(repo).update_all(__MODULE__, updates, opts)
      end
    end
  end
end
