-- http://www.postgresql.org/docs/current/static/app-psql.html

\set QUIET 1
\pset null '<null>'

-- http://www.postgresql.org/docs/9.3/static/app-psql.html#APP-PSQL-PROMPTING
\set PROMPT1 '%n@%/%# '
\set PROMPT2 '... %R > '

-- Show query time
\timing

-- Use best available output format
\x auto
\set HISTFILE `echo $PSQL_HISTORY`_:DBNAME
\set HISTCONTROL ignoredups
-- Autocomplete keywords as uppercase
\set COMP_KEYWORD_CASE upper

-- Aliased queries
\set version 'SHOW server_version;'
\set extensions 'SELECT * FROM pg_available_extensions;'

\set QUIET 0
