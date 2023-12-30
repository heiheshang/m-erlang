FROM erlang:23-slim
WORKDIR /app
COPY . .
RUN rebar3 compile
CMD ["erl", "-noshell", "-s", "m_erlang_app"]
