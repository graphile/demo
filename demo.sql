-- Scalar computed column

create or replace function articles_title_abbrv(
  a articles,
  max_length int = 20
)
returns text
as $$
  select substr(a.title, 1, max_length) || (
    case
    when length(a.title) > max_length then '...'
    else ''
    end
  );
$$ language sql stable;




comment on function articles_title_abbrv(articles, int) is
  'Abbreviated `title`.';




















/**********/

-- Record computed column

create or replace function articles_next(a articles)
returns articles
as $$
  select *
  from articles
  where articles.id > a.id
  order by id asc
  limit 1;
$$ language sql stable;

comment on function articles_next(a articles) is
  'The next `Article` in the database, ordered by `id`';















/**********/

-- Root custom query

create or replace function search_articles(query text)
returns setof articles
as $$
  select *
  from articles
  where to_tsvector('english', title) @@
    websearch_to_tsquery('english', query);
$$ language sql stable;

comment on function search_articles(text) is
  'Search for articles matching the given query.';















/**********/

grant insert (title, url) on articles to graphql;
















/**********/

alter table articles enable row level security;



create policy select_own on articles for select using (
  author_id = current_user_id()
);



create policy select_verified on articles for select using (
  exists(
    select 1 from users
    where users.id = articles.author_id
    and users.verified is true
  )
);








/**********/

create domain web_address as text check (value ~ '^https?://');

comment on domain web_address is 
  'The absolute location of a webpage on the world-wide web.
  Must use http:// or https://';


alter table articles alter column url type web_address;











